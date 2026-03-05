import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/models.dart';

// ═══════════════════════════════════════════════════════════════════════════════════
// 🎯 WORKSHOP SERVICE - Problem-Based Learning
// ═══════════════════════════════════════════════════════════════════════════════════

class WorkshopService {
  // Singleton pattern
  static final WorkshopService _instance = WorkshopService._internal();
  factory WorkshopService() => _instance;
  WorkshopService._internal();

  // In-memory cache
  final Map<String, SolutionWorkshop> _workshopCache = {};

  // Default milestones for new workshops
  static const List<Map<String, String>> _defaultMilestones = [
    {
      'id': 'milestone_1',
      'title': 'Problem Analizi',
      'description': 'Problemi detaylı analiz edin ve gereksinimleri belirleyin',
    },
    {
      'id': 'milestone_2',
      'title': 'Çözüm Fikir Geliştirme',
      'description': 'Brainstorming yapın ve olası çözümleri değerlendirin',
    },
    {
      'id': 'milestone_3',
      'title': 'Prototip Geliştirme',
      'description': 'Seçilen çözüm için prototip oluşturun',
    },
    {
      'id': 'milestone_4',
      'title': 'Test ve Doğrulama',
      'description': 'Prototipi test edin ve geri bildirim toplayın',
    },
    {
      'id': 'milestone_5',
      'title': 'Final Sunum',
      'description': 'Çözümü tamamlayın ve organizasyona sunun',
    },
  ];

  // ═══════════════════════════════════════════════════════════════════════════════════
  // WORKSHOP MANAGEMENT
  // ═══════════════════════════════════════════════════════════════════════════════════

  /// Create a new workshop
  Future<SolutionWorkshop> createWorkshop(
    String problemId,
    String creatorId,
  ) async {
    final id = 'workshop_${DateTime.now().millisecondsSinceEpoch}';
    final now = DateTime.now();

    // Create default milestones
    final milestones = _defaultMilestones.asMap().entries.map((entry) {
      return WorkshopMilestone(
        id: '${id}_${entry.value['id']}',
        title: entry.value['title']!,
        description: entry.value['description']!,
        order: entry.key + 1,
      );
    }).toList();

    final workshop = SolutionWorkshop(
      id: id,
      problemId: problemId,
      name: 'Çözüm Atölyesi #${DateTime.now().millisecondsSinceEpoch % 1000}',
      status: WorkshopStatus.forming,
      participantIds: [creatorId],
      createdAt: now,
      milestones: milestones,
    );

    // Save to cache and storage
    _workshopCache[id] = workshop;
    await _saveWorkshopToStorage(workshop);

    return workshop;
  }

  /// Get workshop by ID
  Future<SolutionWorkshop> getWorkshopById(String id) async {
    // Check cache first
    if (_workshopCache.containsKey(id)) {
      return _workshopCache[id]!;
    }

    // Load from storage
    final prefs = await SharedPreferences.getInstance();
    final key = 'workshop_$id';
    final jsonString = prefs.getString(key);

    if (jsonString != null) {
      final json = jsonDecode(jsonString) as Map<String, dynamic>;
      final workshop = SolutionWorkshop.fromJson(json);
      _workshopCache[id] = workshop;
      return workshop;
    }

    throw Exception('Workshop not found: $id');
  }

  /// Get all workshops for a problem
  Future<List<SolutionWorkshop>> getWorkshopsForProblem(String problemId) async {
    final allWorkshops = await _loadAllWorkshops();
    return allWorkshops.where((w) => w.problemId == problemId).toList();
  }

  /// Get all workshops for a user
  Future<List<SolutionWorkshop>> getUserWorkshops(String userId) async {
    final allWorkshops = await _loadAllWorkshops();
    return allWorkshops
        .where((w) =>
            w.participantIds.contains(userId) ||
            w.facilitatorId == userId ||
            w.teams.any((t) => t.memberIds.contains(userId)))
        .toList();
  }

  /// Load all workshops from storage
  Future<List<SolutionWorkshop>> _loadAllWorkshops() async {
    final prefs = await SharedPreferences.getInstance();
    final keys = prefs.getKeys().where((k) => k.startsWith('workshop_'));

    final workshops = <SolutionWorkshop>[];
    for (final key in keys) {
      try {
        final jsonString = prefs.getString(key);
        if (jsonString != null) {
          final json = jsonDecode(jsonString) as Map<String, dynamic>;
          final workshop = SolutionWorkshop.fromJson(json);
          workshops.add(workshop);
          _workshopCache[workshop.id] = workshop;
        }
      } catch (e) {
        // Skip workshops that fail to load
        continue;
      }
    }

    return workshops;
  }

  // ═══════════════════════════════════════════════════════════════════════════════════
  // PARTICIPATION
  // ═══════════════════════════════════════════════════════════════════════════════════

  /// Join a workshop
  Future<void> joinWorkshop(String workshopId, String userId) async {
    final workshop = await getWorkshopById(workshopId);

    // Validation checks
    if (workshop.status != WorkshopStatus.forming) {
      throw Exception('Atölye yeni katılımcı kabul etmiyor');
    }

    if (workshop.isFull) {
      throw Exception('Atölye dolu (${workshop.maxParticipants} kişi)');
    }

    if (workshop.participantIds.contains(userId)) {
      throw Exception('Bu atölyeye zaten katıldınız');
    }

    // Add participant
    final updatedParticipants = [...workshop.participantIds, userId];
    final updatedWorkshop = workshop.copyWith(
      participantIds: updatedParticipants,
    );

    // Check if workshop should become active
    if (updatedParticipants.length >= workshop.minParticipants &&
        workshop.status == WorkshopStatus.forming) {
      await _activateWorkshop(updatedWorkshop);
    } else {
      _workshopCache[workshopId] = updatedWorkshop;
      await _saveWorkshopToStorage(updatedWorkshop);
    }
  }

  /// Leave a workshop
  Future<void> leaveWorkshop(String workshopId, String userId) async {
    final workshop = await getWorkshopById(workshopId);

    if (!workshop.participantIds.contains(userId)) {
      throw Exception('Bu atölyenin üyesi değilsiniz');
    }

    if (workshop.status == WorkshopStatus.active) {
      throw Exception('Aktif atölyeden ayrılamazsınız');
    }

    // Remove participant
    final updatedParticipants = workshop.participantIds.where((id) => id != userId).toList();
    final updatedWorkshop = workshop.copyWith(
      participantIds: updatedParticipants,
    );

    _workshopCache[workshopId] = updatedWorkshop;
    await _saveWorkshopToStorage(updatedWorkshop);
  }

  // ═══════════════════════════════════════════════════════════════════════════════════
  // TEAM FORMATION
  // ═══════════════════════════════════════════════════════════════════════════════════

  /// Create a team in workshop
  Future<WorkshopTeam> createTeam(
    String workshopId,
    String teamName,
    List<String> memberIds,
  ) async {
    final workshop = await getWorkshopById(workshopId);

    // Validate team size
    if (memberIds.length < 2 || memberIds.length > 5) {
      throw Exception('Takım 2-5 kişi arasında olmalıdır');
    }

    // Validate all members are participants
    for (final memberId in memberIds) {
      if (!workshop.participantIds.contains(memberId)) {
        throw Exception('Tüm takım üyeleri atölye katılımcısı olmalıdır');
      }
    }

    final teamId = '${workshopId}_team_${DateTime.now().millisecondsSinceEpoch}';
    final team = WorkshopTeam(
      id: teamId,
      workshopId: workshopId,
      name: teamName,
      memberIds: memberIds,
      leaderId: memberIds.first, // First member is leader by default
      progress: TeamProgress(
        completionPercentage: 0.0,
        currentMilestone: 0,
        totalMilestones: workshop.milestones.length,
        lastUpdated: DateTime.now(),
      ),
    );

    // Add team to workshop
    final updatedTeams = [...workshop.teams, team];
    final updatedWorkshop = workshop.copyWith(teams: updatedTeams);

    _workshopCache[workshopId] = updatedWorkshop;
    await _saveWorkshopToStorage(updatedWorkshop);

    return team;
  }

  /// Assign facilitator to workshop
  Future<void> assignFacilitator(String workshopId, String facilitatorId) async {
    final workshop = await getWorkshopById(workshopId);

    // In production, would validate facilitator criteria here
    // (Usta or Büyük Usta level, >3 completed projects)

    final updatedWorkshop = workshop.copyWith(facilitatorId: facilitatorId);

    _workshopCache[workshopId] = updatedWorkshop;
    await _saveWorkshopToStorage(updatedWorkshop);
  }

  // ═══════════════════════════════════════════════════════════════════════════════════
  // WORKSHOP LIFECYCLE
  // ═══════════════════════════════════════════════════════════════════════════════════

  /// Activate workshop (move from forming to active)
  Future<void> _activateWorkshop(SolutionWorkshop workshop) async {
    final updatedWorkshop = workshop.copyWith(
      status: WorkshopStatus.active,
      startedAt: DateTime.now(),
    );

    _workshopCache[workshop.id] = updatedWorkshop;
    await _saveWorkshopToStorage(updatedWorkshop);
  }

  /// Start workshop manually
  Future<void> startWorkshop(String workshopId) async {
    final workshop = await getWorkshopById(workshopId);

    if (workshop.status != WorkshopStatus.forming) {
      throw Exception('Atölye zaten başlatılmış');
    }

    if (!workshop.canStart) {
      throw Exception(
          'Atölye başlatmak için en az ${workshop.minParticipants} katılımcı gerekli');
    }

    await _activateWorkshop(workshop);
  }

  /// Complete a milestone
  Future<void> completeMilestone(
    String workshopId,
    String milestoneId,
    String feedback,
  ) async {
    final workshop = await getWorkshopById(workshopId);

    final milestoneIndex =
        workshop.milestones.indexWhere((m) => m.id == milestoneId);
    if (milestoneIndex == -1) {
      throw Exception('Milestone bulunamadı');
    }

    final updatedMilestones = List<WorkshopMilestone>.from(workshop.milestones);
    updatedMilestones[milestoneIndex] = updatedMilestones[milestoneIndex].copyWith(
      isCompleted: true,
      completedAt: DateTime.now(),
      facilitatorFeedback: feedback,
    );

    final updatedWorkshop = workshop.copyWith(milestones: updatedMilestones);

    _workshopCache[workshopId] = updatedWorkshop;
    await _saveWorkshopToStorage(updatedWorkshop);
  }

  /// Submit project
  Future<void> submitProject(String workshopId, WorkshopProject project) async {
    final workshop = await getWorkshopById(workshopId);

    if (workshop.status != WorkshopStatus.active) {
      throw Exception('Sadece aktif atölyelerde proje gönderilebilir');
    }

    final updatedWorkshop = workshop.copyWith(project: project);

    _workshopCache[workshopId] = updatedWorkshop;
    await _saveWorkshopToStorage(updatedWorkshop);
  }

  /// Complete workshop
  Future<void> completeWorkshop(String workshopId) async {
    final workshop = await getWorkshopById(workshopId);

    if (workshop.status != WorkshopStatus.active) {
      throw Exception('Sadece aktif atölyeler tamamlanabilir');
    }

    if (workshop.project == null) {
      throw Exception('Atölye tamamlanmadan önce proje gönderilmelidir');
    }

    final updatedWorkshop = workshop.copyWith(
      status: WorkshopStatus.completed,
      completedAt: DateTime.now(),
    );

    _workshopCache[workshopId] = updatedWorkshop;
    await _saveWorkshopToStorage(updatedWorkshop);
  }

  // ═══════════════════════════════════════════════════════════════════════════════════
  // PROGRESS TRACKING
  // ═══════════════════════════════════════════════════════════════════════════════════

  /// Get workshop progress
  Future<WorkshopProgress> getWorkshopProgress(String workshopId) async {
    final workshop = await getWorkshopById(workshopId);

    return WorkshopProgress(
      workshopId: workshopId,
      completedMilestones: workshop.completedMilestones,
      totalMilestones: workshop.milestones.length,
      progressPercentage: workshop.progressPercentage,
      daysActive: workshop.daysActive ?? 0,
      isCompleted: workshop.isCompleted,
    );
  }

  // ═══════════════════════════════════════════════════════════════════════════════════
  // UTILITY METHODS
  // ═══════════════════════════════════════════════════════════════════════════════════

  /// Save workshop to storage
  Future<void> _saveWorkshopToStorage(SolutionWorkshop workshop) async {
    final prefs = await SharedPreferences.getInstance();
    final key = 'workshop_${workshop.id}';
    final json = jsonEncode(workshop.toJson());
    await prefs.setString(key, json);
  }

  /// Clear cache
  void clearCache() {
    _workshopCache.clear();
  }
}

/// Workshop progress data class
class WorkshopProgress {
  final String workshopId;
  final int completedMilestones;
  final int totalMilestones;
  final double progressPercentage;
  final int daysActive;
  final bool isCompleted;

  const WorkshopProgress({
    required this.workshopId,
    required this.completedMilestones,
    required this.totalMilestones,
    required this.progressPercentage,
    required this.daysActive,
    required this.isCompleted,
  });
}
