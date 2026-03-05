import '../models/youth_profile.dart';
import '../../../data/models/user_level.dart';

// ═══════════════════════════════════════════════════════════════════════════════════
// 👥 YOUTH SERVICE
// ═══════════════════════════════════════════════════════════════════════════════════

class YouthService {
  // Mock data storage
  static final List<YouthProfile> _youthList = _mockYouthData();

  // Register new youth
  Future<YouthProfile> registerYouth({
    required String name,
    required String email,
    required String city,
    required String skillPath,
  }) async {
    await Future.delayed(const Duration(milliseconds: 500));

    // Check for duplicate email
    if (_youthList.any((y) => y.email == email)) {
      throw Exception('Bu e-posta adresi zaten kayıtlı');
    }

    final youth = YouthProfile(
      id: 'youth_${DateTime.now().millisecondsSinceEpoch}',
      name: name,
      email: email,
      city: city,
      level: UserLevel.cirak,
      skills: [],
      skillPath: skillPath,
      volunteerHours: 0,
      completedProjects: 0,
      reputation: 5.0,
      xp: 0,
      registrationDate: DateTime.now(),
      levelProgressionPending: false,
    );

    _youthList.add(youth);
    return youth;
  }

  // Get all youth
  Future<List<YouthProfile>> getAllYouth() async {
    await Future.delayed(const Duration(milliseconds: 300));
    return List.from(_youthList);
  }

  // Get youth by ID
  Future<YouthProfile?> getYouthById(String id) async {
    await Future.delayed(const Duration(milliseconds: 200));
    try {
      return _youthList.firstWhere((y) => y.id == id);
    } catch (e) {
      return null;
    }
  }

  // Update youth profile
  Future<YouthProfile> updateYouth(YouthProfile youth) async {
    await Future.delayed(const Duration(milliseconds: 300));
    
    final index = _youthList.indexWhere((y) => y.id == youth.id);
    if (index == -1) {
      throw Exception('Genç bulunamadı');
    }

    _youthList[index] = youth;
    return youth;
  }

  // Approve level progression
  Future<YouthProfile> approveLevelProgression(String youthId, UserLevel newLevel) async {
    await Future.delayed(const Duration(milliseconds: 400));
    
    final youth = await getYouthById(youthId);
    if (youth == null) {
      throw Exception('Genç bulunamadı');
    }

    final updatedYouth = youth.copyWith(
      level: newLevel,
      levelProgressionPending: false,
    );

    return updateYouth(updatedYouth);
  }

  // Reject level progression
  Future<YouthProfile> rejectLevelProgression(String youthId, String reason) async {
    await Future.delayed(const Duration(milliseconds: 400));
    
    final youth = await getYouthById(youthId);
    if (youth == null) {
      throw Exception('Genç bulunamadı');
    }

    final updatedYouth = youth.copyWith(
      levelProgressionPending: false,
    );

    return updateYouth(updatedYouth);
  }

  // Get youth with pending level progressions
  Future<List<YouthProfile>> getPendingProgressions() async {
    await Future.delayed(const Duration(milliseconds: 300));
    return _youthList.where((y) => y.levelProgressionPending).toList();
  }

  // Mock data
  static List<YouthProfile> _mockYouthData() {
    return [
      YouthProfile(
        id: 'youth_1',
        name: 'Ahmet Yılmaz',
        email: 'ahmet@example.com',
        city: 'İstanbul',
        level: UserLevel.cirak,
        skills: ['Flutter', 'Dart'],
        skillPath: 'Mobil Uygulama Geliştirme',
        volunteerHours: 15,
        completedProjects: 2,
        reputation: 4.5,
        xp: 450,
        registrationDate: DateTime.now().subtract(const Duration(days: 30)),
        levelProgressionPending: false,
      ),
      YouthProfile(
        id: 'youth_2',
        name: 'Zeynep Kaya',
        email: 'zeynep@example.com',
        city: 'Ankara',
        level: UserLevel.kalfa,
        skills: ['React', 'Node.js', 'MongoDB'],
        skillPath: 'Web Geliştirme',
        volunteerHours: 45,
        completedProjects: 5,
        reputation: 4.8,
        xp: 1250,
        registrationDate: DateTime.now().subtract(const Duration(days: 90)),
        levelProgressionPending: true,
      ),
      YouthProfile(
        id: 'youth_3',
        name: 'Mehmet Demir',
        email: 'mehmet@example.com',
        city: 'İzmir',
        level: UserLevel.cirak,
        skills: ['Python', 'Data Analysis'],
        skillPath: 'Veri Analizi',
        volunteerHours: 20,
        completedProjects: 3,
        reputation: 4.6,
        xp: 680,
        registrationDate: DateTime.now().subtract(const Duration(days: 45)),
        levelProgressionPending: false,
      ),
    ];
  }
}
