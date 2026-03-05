import '../models/partner_project.dart';
import '../../../data/models/user_level.dart';

// ═══════════════════════════════════════════════════════════════════════════════════
// 💼 PROJECT SERVICE
// ═══════════════════════════════════════════════════════════════════════════════════

class ProjectService {
  static final List<PartnerProject> _projects = _mockProjectData();

  // Create project
  Future<PartnerProject> createProject({
    required String title,
    required String description,
    required String partnerOrganization,
    required String partnerId,
    required List<String> requiredSkills,
    required UserLevel requiredLevel,
    required int durationDays,
    required CompensationType compensationType,
    required int maxParticipants,
    DateTime? deadline,
  }) async {
    await Future.delayed(const Duration(milliseconds: 500));

    final project = PartnerProject(
      id: 'project_${DateTime.now().millisecondsSinceEpoch}',
      title: title,
      description: description,
      partnerOrganization: partnerOrganization,
      partnerId: partnerId,
      requiredSkills: requiredSkills,
      requiredLevel: requiredLevel,
      durationDays: durationDays,
      compensationType: compensationType,
      maxParticipants: maxParticipants,
      currentApplications: 0,
      assignedYouth: 0,
      status: ProjectStatus.open,
      createdAt: DateTime.now(),
      deadline: deadline,
    );

    _projects.add(project);
    return project;
  }

  // Get all projects
  Future<List<PartnerProject>> getAllProjects() async {
    await Future.delayed(const Duration(milliseconds: 300));
    return List.from(_projects);
  }

  // Get active projects
  Future<List<PartnerProject>> getActiveProjects() async {
    await Future.delayed(const Duration(milliseconds: 300));
    return _projects
        .where((p) => p.status == ProjectStatus.open || p.status == ProjectStatus.inProgress)
        .toList();
  }

  // Update project
  Future<PartnerProject> updateProject(PartnerProject project) async {
    await Future.delayed(const Duration(milliseconds: 300));
    
    final index = _projects.indexWhere((p) => p.id == project.id);
    if (index == -1) {
      throw Exception('Proje bulunamadı');
    }

    _projects[index] = project;
    return project;
  }

  // Close project
  Future<void> closeProject(String projectId) async {
    await Future.delayed(const Duration(milliseconds: 300));
    
    final index = _projects.indexWhere((p) => p.id == projectId);
    if (index == -1) {
      throw Exception('Proje bulunamadı');
    }

    _projects[index] = _projects[index].copyWith(
      status: ProjectStatus.closed,
    );
  }

  // Mock data
  static List<PartnerProject> _mockProjectData() {
    final now = DateTime.now();
    return [
      PartnerProject(
        id: 'project_1',
        title: 'E-ticaret Sitesi Geliştirme',
        description: 'Modern, kullanıcı dostu e-ticaret platformu geliştirme projesi',
        partnerOrganization: 'TechCorp A.Ş.',
        partnerId: 'partner_1',
        requiredSkills: ['React', 'Node.js', 'MongoDB'],
        requiredLevel: UserLevel.kalfa,
        durationDays: 60,
        compensationType: CompensationType.paid,
        maxParticipants: 3,
        currentApplications: 15,
        assignedYouth: 0,
        status: ProjectStatus.open,
        createdAt: now.subtract(const Duration(days: 5)),
        deadline: now.add(const Duration(days: 30)),
      ),
      PartnerProject(
        id: 'project_2',
        title: 'Mobil Uygulama Tasarımı',
        description: 'iOS ve Android için mobil uygulama UI/UX tasarımı',
        partnerOrganization: 'Design Studio',
        partnerId: 'partner_2',
        requiredSkills: ['Figma', 'UI Design', 'UX Design'],
        requiredLevel: UserLevel.cirak,
        durationDays: 30,
        compensationType: CompensationType.certificate,
        maxParticipants: 2,
        currentApplications: 23,
        assignedYouth: 0,
        status: ProjectStatus.open,
        createdAt: now.subtract(const Duration(days: 3)),
        deadline: now.add(const Duration(days: 20)),
      ),
      PartnerProject(
        id: 'project_3',
        title: 'Dijital Pazarlama Kampanyası',
        description: 'Sosyal medya ve SEO odaklı dijital pazarlama kampanyası',
        partnerOrganization: 'Marketing Plus',
        partnerId: 'partner_3',
        requiredSkills: ['Social Media', 'SEO', 'Content Marketing'],
        requiredLevel: UserLevel.cirak,
        durationDays: 45,
        compensationType: CompensationType.volunteer,
        maxParticipants: 4,
        currentApplications: 8,
        assignedYouth: 0,
        status: ProjectStatus.open,
        createdAt: now.subtract(const Duration(days: 7)),
        deadline: now.add(const Duration(days: 25)),
      ),
    ];
  }
}
