import '../../../data/models/user_level.dart';

// ═══════════════════════════════════════════════════════════════════════════════════
// 💼 PARTNER PROJECT MODEL
// ═══════════════════════════════════════════════════════════════════════════════════

enum CompensationType {
  volunteer,
  paid,
  certificate,
}

enum ProjectStatus {
  open,
  inProgress,
  completed,
  closed,
}

class PartnerProject {
  final String id;
  final String title;
  final String description;
  final String partnerOrganization;
  final String partnerId;
  final List<String> requiredSkills;
  final UserLevel requiredLevel;
  final int durationDays;
  final CompensationType compensationType;
  final int maxParticipants;
  final int currentApplications;
  final int assignedYouth;
  final ProjectStatus status;
  final DateTime createdAt;
  final DateTime? deadline;

  const PartnerProject({
    required this.id,
    required this.title,
    required this.description,
    required this.partnerOrganization,
    required this.partnerId,
    required this.requiredSkills,
    required this.requiredLevel,
    required this.durationDays,
    required this.compensationType,
    required this.maxParticipants,
    required this.currentApplications,
    required this.assignedYouth,
    required this.status,
    required this.createdAt,
    this.deadline,
  });

  factory PartnerProject.fromJson(Map<String, dynamic> json) {
    return PartnerProject(
      id: json['id'] as String,
      title: json['title'] as String,
      description: json['description'] as String,
      partnerOrganization: json['partnerOrganization'] as String,
      partnerId: json['partnerId'] as String,
      requiredSkills: (json['requiredSkills'] as List<dynamic>?)?.cast<String>() ?? [],
      requiredLevel: UserLevel.values.firstWhere(
        (e) => e.name == json['requiredLevel'],
        orElse: () => UserLevel.cirak,
      ),
      durationDays: json['durationDays'] as int,
      compensationType: CompensationType.values.firstWhere(
        (e) => e.name == json['compensationType'],
        orElse: () => CompensationType.volunteer,
      ),
      maxParticipants: json['maxParticipants'] as int,
      currentApplications: json['currentApplications'] as int? ?? 0,
      assignedYouth: json['assignedYouth'] as int? ?? 0,
      status: ProjectStatus.values.firstWhere(
        (e) => e.name == json['status'],
        orElse: () => ProjectStatus.open,
      ),
      createdAt: json['createdAt'] != null
          ? DateTime.parse(json['createdAt'] as String)
          : DateTime.now(),
      deadline: json['deadline'] != null
          ? DateTime.parse(json['deadline'] as String)
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'partnerOrganization': partnerOrganization,
      'partnerId': partnerId,
      'requiredSkills': requiredSkills,
      'requiredLevel': requiredLevel.name,
      'durationDays': durationDays,
      'compensationType': compensationType.name,
      'maxParticipants': maxParticipants,
      'currentApplications': currentApplications,
      'assignedYouth': assignedYouth,
      'status': status.name,
      'createdAt': createdAt.toIso8601String(),
      'deadline': deadline?.toIso8601String(),
    };
  }

  PartnerProject copyWith({
    String? id,
    String? title,
    String? description,
    String? partnerOrganization,
    String? partnerId,
    List<String>? requiredSkills,
    UserLevel? requiredLevel,
    int? durationDays,
    CompensationType? compensationType,
    int? maxParticipants,
    int? currentApplications,
    int? assignedYouth,
    ProjectStatus? status,
    DateTime? createdAt,
    DateTime? deadline,
  }) {
    return PartnerProject(
      id: id ?? this.id,
      title: title ?? this.title,
      description: description ?? this.description,
      partnerOrganization: partnerOrganization ?? this.partnerOrganization,
      partnerId: partnerId ?? this.partnerId,
      requiredSkills: requiredSkills ?? this.requiredSkills,
      requiredLevel: requiredLevel ?? this.requiredLevel,
      durationDays: durationDays ?? this.durationDays,
      compensationType: compensationType ?? this.compensationType,
      maxParticipants: maxParticipants ?? this.maxParticipants,
      currentApplications: currentApplications ?? this.currentApplications,
      assignedYouth: assignedYouth ?? this.assignedYouth,
      status: status ?? this.status,
      createdAt: createdAt ?? this.createdAt,
      deadline: deadline ?? this.deadline,
    );
  }

  bool get hasOpenings => assignedYouth < maxParticipants;

  bool get isOpen => status == ProjectStatus.open;

  bool get isInProgress => status == ProjectStatus.inProgress;

  bool get isCompleted => status == ProjectStatus.completed;

  bool get isClosed => status == ProjectStatus.closed;

  String get compensationTypeLabel {
    switch (compensationType) {
      case CompensationType.volunteer:
        return 'Gönüllü';
      case CompensationType.paid:
        return 'Ücretli';
      case CompensationType.certificate:
        return 'Sertifikalı';
    }
  }
}
