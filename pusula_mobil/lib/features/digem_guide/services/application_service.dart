import '../models/project_application.dart';
import '../../../data/models/user_level.dart';

// ═══════════════════════════════════════════════════════════════════════════════════
// 📝 APPLICATION SERVICE
// ═══════════════════════════════════════════════════════════════════════════════════

class ApplicationService {
  static final List<ProjectApplication> _applications = _mockApplicationData();

  // Get applications by project
  Future<List<ProjectApplication>> getApplicationsByProject(String projectId) async {
    await Future.delayed(const Duration(milliseconds: 300));
    return _applications.where((a) => a.projectId == projectId).toList();
  }

  // Accept application
  Future<ProjectApplication> acceptApplication(String applicationId) async {
    await Future.delayed(const Duration(milliseconds: 400));
    
    final index = _applications.indexWhere((a) => a.id == applicationId);
    if (index == -1) {
      throw Exception('Başvuru bulunamadı');
    }

    _applications[index] = _applications[index].copyWith(
      status: ApplicationStatus.accepted,
      reviewedAt: DateTime.now(),
    );

    return _applications[index];
  }

  // Reject application
  Future<ProjectApplication> rejectApplication(String applicationId, String reason) async {
    await Future.delayed(const Duration(milliseconds: 400));
    
    final index = _applications.indexWhere((a) => a.id == applicationId);
    if (index == -1) {
      throw Exception('Başvuru bulunamadı');
    }

    _applications[index] = _applications[index].copyWith(
      status: ApplicationStatus.rejected,
      reviewedAt: DateTime.now(),
      reviewNotes: reason,
    );

    return _applications[index];
  }

  // Get pending applications
  Future<List<ProjectApplication>> getPendingApplications() async {
    await Future.delayed(const Duration(milliseconds: 300));
    return _applications.where((a) => a.status == ApplicationStatus.pending).toList();
  }

  // Mock data
  static List<ProjectApplication> _mockApplicationData() {
    final now = DateTime.now();
    return [
      ProjectApplication(
        id: 'app_1',
        projectId: 'project_1',
        youthId: 'youth_2',
        youthName: 'Zeynep Kaya',
        youthLevel: UserLevel.kalfa,
        youthSkills: ['React', 'Node.js', 'MongoDB'],
        youthReputation: 4.8,
        coverLetter: 'E-ticaret projelerinde deneyimim var ve bu projede yer almak istiyorum.',
        status: ApplicationStatus.pending,
        appliedAt: now.subtract(const Duration(days: 2)),
      ),
      ProjectApplication(
        id: 'app_2',
        projectId: 'project_1',
        youthId: 'youth_1',
        youthName: 'Ahmet Yılmaz',
        youthLevel: UserLevel.cirak,
        youthSkills: ['Flutter', 'Dart'],
        youthReputation: 4.5,
        coverLetter: 'Web geliştirme öğrenmek ve bu projede katkıda bulunmak istiyorum.',
        status: ApplicationStatus.pending,
        appliedAt: now.subtract(const Duration(days: 1)),
      ),
      ProjectApplication(
        id: 'app_3',
        projectId: 'project_2',
        youthId: 'youth_3',
        youthName: 'Mehmet Demir',
        youthLevel: UserLevel.cirak,
        youthSkills: ['Python', 'Data Analysis'],
        youthReputation: 4.6,
        coverLetter: 'Tasarım alanında kendimi geliştirmek istiyorum.',
        status: ApplicationStatus.pending,
        appliedAt: now.subtract(const Duration(hours: 12)),
      ),
    ];
  }
}
