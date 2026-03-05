import '../../../data/models/user_level.dart';

// ═══════════════════════════════════════════════════════════════════════════════════
// 📝 PROJECT APPLICATION MODEL
// ═══════════════════════════════════════════════════════════════════════════════════

enum ApplicationStatus {
  pending,
  accepted,
  rejected,
  withdrawn,
}

class ProjectApplication {
  final String id;
  final String projectId;
  final String youthId;
  final String youthName;
  final UserLevel youthLevel;
  final List<String> youthSkills;
  final double youthReputation;
  final String coverLetter;
  final ApplicationStatus status;
  final DateTime appliedAt;
  final DateTime? reviewedAt;
  final String? reviewNotes;

  const ProjectApplication({
    required this.id,
    required this.projectId,
    required this.youthId,
    required this.youthName,
    required this.youthLevel,
    required this.youthSkills,
    required this.youthReputation,
    required this.coverLetter,
    required this.status,
    required this.appliedAt,
    this.reviewedAt,
    this.reviewNotes,
  });

  factory ProjectApplication.fromJson(Map<String, dynamic> json) {
    return ProjectApplication(
      id: json['id'] as String,
      projectId: json['projectId'] as String,
      youthId: json['youthId'] as String,
      youthName: json['youthName'] as String,
      youthLevel: UserLevel.values.firstWhere(
        (e) => e.name == json['youthLevel'],
        orElse: () => UserLevel.cirak,
      ),
      youthSkills: (json['youthSkills'] as List<dynamic>?)?.cast<String>() ?? [],
      youthReputation: (json['youthReputation'] as num?)?.toDouble() ?? 5.0,
      coverLetter: json['coverLetter'] as String? ?? '',
      status: ApplicationStatus.values.firstWhere(
        (e) => e.name == json['status'],
        orElse: () => ApplicationStatus.pending,
      ),
      appliedAt: json['appliedAt'] != null
          ? DateTime.parse(json['appliedAt'] as String)
          : DateTime.now(),
      reviewedAt: json['reviewedAt'] != null
          ? DateTime.parse(json['reviewedAt'] as String)
          : null,
      reviewNotes: json['reviewNotes'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'projectId': projectId,
      'youthId': youthId,
      'youthName': youthName,
      'youthLevel': youthLevel.name,
      'youthSkills': youthSkills,
      'youthReputation': youthReputation,
      'coverLetter': coverLetter,
      'status': status.name,
      'appliedAt': appliedAt.toIso8601String(),
      'reviewedAt': reviewedAt?.toIso8601String(),
      'reviewNotes': reviewNotes,
    };
  }

  ProjectApplication copyWith({
    String? id,
    String? projectId,
    String? youthId,
    String? youthName,
    UserLevel? youthLevel,
    List<String>? youthSkills,
    double? youthReputation,
    String? coverLetter,
    ApplicationStatus? status,
    DateTime? appliedAt,
    DateTime? reviewedAt,
    String? reviewNotes,
  }) {
    return ProjectApplication(
      id: id ?? this.id,
      projectId: projectId ?? this.projectId,
      youthId: youthId ?? this.youthId,
      youthName: youthName ?? this.youthName,
      youthLevel: youthLevel ?? this.youthLevel,
      youthSkills: youthSkills ?? this.youthSkills,
      youthReputation: youthReputation ?? this.youthReputation,
      coverLetter: coverLetter ?? this.coverLetter,
      status: status ?? this.status,
      appliedAt: appliedAt ?? this.appliedAt,
      reviewedAt: reviewedAt ?? this.reviewedAt,
      reviewNotes: reviewNotes ?? this.reviewNotes,
    );
  }

  bool get isPending => status == ApplicationStatus.pending;

  bool get isAccepted => status == ApplicationStatus.accepted;

  bool get isRejected => status == ApplicationStatus.rejected;

  bool get isWithdrawn => status == ApplicationStatus.withdrawn;

  String get statusLabel {
    switch (status) {
      case ApplicationStatus.pending:
        return 'Beklemede';
      case ApplicationStatus.accepted:
        return 'Kabul Edildi';
      case ApplicationStatus.rejected:
        return 'Reddedildi';
      case ApplicationStatus.withdrawn:
        return 'Geri Çekildi';
    }
  }

  String get youthLevelName {
    switch (youthLevel) {
      case UserLevel.cirak:
        return 'Çırak';
      case UserLevel.kalfa:
        return 'Kalfa';
      case UserLevel.usta:
        return 'Usta';
      case UserLevel.buyukUsta:
        return 'Büyük Usta';
    }
  }
}
