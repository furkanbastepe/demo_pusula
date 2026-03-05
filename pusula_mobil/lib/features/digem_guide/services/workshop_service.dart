import '../models/workshop_event.dart';
import '../../../data/models/user_level.dart';

// ═══════════════════════════════════════════════════════════════════════════════════
// 🎓 WORKSHOP SERVICE
// ═══════════════════════════════════════════════════════════════════════════════════

class WorkshopService {
  static final List<WorkshopEvent> _workshops = _mockWorkshopData();

  // Create workshop
  Future<WorkshopEvent> createWorkshop({
    required String name,
    required String description,
    required String instructor,
    required DateTime dateTime,
    required int durationHours,
    required int capacity,
    UserLevel? requiredLevel,
    required List<String> skillsCovered,
  }) async {
    await Future.delayed(const Duration(milliseconds: 500));

    final workshop = WorkshopEvent(
      id: 'workshop_${DateTime.now().millisecondsSinceEpoch}',
      name: name,
      description: description,
      instructor: instructor,
      dateTime: dateTime,
      durationHours: durationHours,
      capacity: capacity,
      currentParticipants: 0,
      requiredLevel: requiredLevel,
      skillsCovered: skillsCovered,
      status: WorkshopStatus.upcoming,
      createdAt: DateTime.now(),
    );

    _workshops.add(workshop);
    return workshop;
  }

  // Get all workshops
  Future<List<WorkshopEvent>> getAllWorkshops() async {
    await Future.delayed(const Duration(milliseconds: 300));
    return List.from(_workshops);
  }

  // Get upcoming workshops
  Future<List<WorkshopEvent>> getUpcomingWorkshops() async {
    await Future.delayed(const Duration(milliseconds: 300));
    return _workshops
        .where((w) => w.status == WorkshopStatus.upcoming)
        .toList();
  }

  // Update workshop
  Future<WorkshopEvent> updateWorkshop(WorkshopEvent workshop) async {
    await Future.delayed(const Duration(milliseconds: 300));
    
    final index = _workshops.indexWhere((w) => w.id == workshop.id);
    if (index == -1) {
      throw Exception('Atölye bulunamadı');
    }

    _workshops[index] = workshop;
    return workshop;
  }

  // Cancel workshop
  Future<void> cancelWorkshop(String workshopId) async {
    await Future.delayed(const Duration(milliseconds: 300));
    
    final index = _workshops.indexWhere((w) => w.id == workshopId);
    if (index == -1) {
      throw Exception('Atölye bulunamadı');
    }

    _workshops[index] = _workshops[index].copyWith(
      status: WorkshopStatus.cancelled,
    );
  }

  // Mock data
  static List<WorkshopEvent> _mockWorkshopData() {
    final now = DateTime.now();
    return [
      WorkshopEvent(
        id: 'workshop_1',
        name: 'React ile Web Geliştirme',
        description: 'Modern web uygulamaları geliştirmeyi öğrenin',
        instructor: 'Ali Veli',
        dateTime: now.add(const Duration(days: 5)),
        durationHours: 3,
        capacity: 20,
        currentParticipants: 15,
        requiredLevel: null,
        skillsCovered: ['React', 'JavaScript', 'HTML', 'CSS'],
        status: WorkshopStatus.upcoming,
        createdAt: now.subtract(const Duration(days: 10)),
      ),
      WorkshopEvent(
        id: 'workshop_2',
        name: 'Python Temelleri',
        description: 'Python programlama diline giriş',
        instructor: 'Ayşe Yılmaz',
        dateTime: now.add(const Duration(days: 7)),
        durationHours: 4,
        capacity: 25,
        currentParticipants: 12,
        requiredLevel: UserLevel.cirak,
        skillsCovered: ['Python', 'Programming Basics'],
        status: WorkshopStatus.upcoming,
        createdAt: now.subtract(const Duration(days: 8)),
      ),
      WorkshopEvent(
        id: 'workshop_3',
        name: 'UI/UX Tasarım Prensipleri',
        description: 'Kullanıcı deneyimi tasarımı temelleri',
        instructor: 'Mehmet Kaya',
        dateTime: now.add(const Duration(days: 10)),
        durationHours: 2,
        capacity: 18,
        currentParticipants: 18,
        requiredLevel: null,
        skillsCovered: ['UI Design', 'UX Design', 'Figma'],
        status: WorkshopStatus.upcoming,
        createdAt: now.subtract(const Duration(days: 5)),
      ),
    ];
  }
}
