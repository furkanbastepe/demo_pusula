import 'package:flutter/material.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import '../../../core/core.dart';

// ═══════════════════════════════════════════════════════════════════════════════════
// 📊 PROBLEM MODEL - Problem-Based Learning
// ═══════════════════════════════════════════════════════════════════════════════════

/// Impact areas for problems
enum ImpactArea {
  transportation,
  education,
  healthcare,
  environment,
  socialServices,
  economy,
  culture,
  technology;

  String get displayName {
    switch (this) {
      case ImpactArea.transportation:
        return 'Ulaşım';
      case ImpactArea.education:
        return 'Eğitim';
      case ImpactArea.healthcare:
        return 'Sağlık';
      case ImpactArea.environment:
        return 'Çevre';
      case ImpactArea.socialServices:
        return 'Sosyal Hizmetler';
      case ImpactArea.economy:
        return 'Ekonomi';
      case ImpactArea.culture:
        return 'Kültür';
      case ImpactArea.technology:
        return 'Teknoloji';
    }
  }

  IconData get icon {
    switch (this) {
      case ImpactArea.transportation:
        return LucideIcons.bus;
      case ImpactArea.education:
        return LucideIcons.graduationCap;
      case ImpactArea.healthcare:
        return LucideIcons.heart;
      case ImpactArea.environment:
        return LucideIcons.leaf;
      case ImpactArea.socialServices:
        return LucideIcons.users;
      case ImpactArea.economy:
        return LucideIcons.trendingUp;
      case ImpactArea.culture:
        return LucideIcons.landmark;
      case ImpactArea.technology:
        return LucideIcons.cpu;
    }
  }

  Color get color {
    switch (this) {
      case ImpactArea.transportation:
        return PColors.info;
      case ImpactArea.education:
        return PColors.primary;
      case ImpactArea.healthcare:
        return PColors.warning;
      case ImpactArea.environment:
        return PColors.success;
      case ImpactArea.socialServices:
        return PColors.accent;
      case ImpactArea.economy:
        return PColors.warning;
      case ImpactArea.culture:
        return PColors.impactCulture;
      case ImpactArea.technology:
        return PColors.impactTechnology;
    }
  }
}

/// Problem status in the system
enum ProblemStatus {
  pending_review,
  open,
  in_workshop,
  solved,
  archived;

  String get displayName {
    switch (this) {
      case ProblemStatus.pending_review:
        return 'İnceleniyor';
      case ProblemStatus.open:
        return 'Açık';
      case ProblemStatus.in_workshop:
        return 'Atölyede';
      case ProblemStatus.solved:
        return 'Çözüldü';
      case ProblemStatus.archived:
        return 'Arşivlendi';
    }
  }

  Color get color {
    switch (this) {
      case ProblemStatus.pending_review:
        return PColors.warning;
      case ProblemStatus.open:
        return PColors.success;
      case ProblemStatus.in_workshop:
        return PColors.info;
      case ProblemStatus.solved:
        return PColors.primary;
      case ProblemStatus.archived:
        return PColors.textDim;
    }
  }
}

/// Engagement metrics for a problem
class ProblemEngagement {
  final int views;
  final int saves;
  final int workshopApplications;
  final int activeWorkshops;
  final int submittedSolutions;

  const ProblemEngagement({
    this.views = 0,
    this.saves = 0,
    this.workshopApplications = 0,
    this.activeWorkshops = 0,
    this.submittedSolutions = 0,
  });

  int get totalEngagement => saves + workshopApplications;

  bool get isPopular => totalEngagement > 20;

  factory ProblemEngagement.fromJson(Map<String, dynamic> json) {
    return ProblemEngagement(
      views: json['views'] as int? ?? 0,
      saves: json['saves'] as int? ?? 0,
      workshopApplications: json['workshopApplications'] as int? ?? 0,
      activeWorkshops: json['activeWorkshops'] as int? ?? 0,
      submittedSolutions: json['submittedSolutions'] as int? ?? 0,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'views': views,
      'saves': saves,
      'workshopApplications': workshopApplications,
      'activeWorkshops': activeWorkshops,
      'submittedSolutions': submittedSolutions,
    };
  }

  ProblemEngagement copyWith({
    int? views,
    int? saves,
    int? workshopApplications,
    int? activeWorkshops,
    int? submittedSolutions,
  }) {
    return ProblemEngagement(
      views: views ?? this.views,
      saves: saves ?? this.saves,
      workshopApplications: workshopApplications ?? this.workshopApplications,
      activeWorkshops: activeWorkshops ?? this.activeWorkshops,
      submittedSolutions: submittedSolutions ?? this.submittedSolutions,
    );
  }
}

/// Main Problem model
class Problem {
  final String id;
  final String title;
  final String description;
  final String organization;
  final String organizationId;
  final ImpactArea impactArea;
  final String city;
  final List<String> requiredSkills;
  final ProblemStatus status;
  final int urgencyLevel; // 1-5
  final int impactScore; // 1-100
  final DateTime submittedAt;
  final DateTime? deadline;
  final List<String> attachments;
  final Map<String, dynamic> constraints;
  final ProblemEngagement engagement;

  const Problem({
    required this.id,
    required this.title,
    required this.description,
    required this.organization,
    required this.organizationId,
    required this.impactArea,
    required this.city,
    required this.requiredSkills,
    this.status = ProblemStatus.open,
    this.urgencyLevel = 3,
    this.impactScore = 50,
    required this.submittedAt,
    this.deadline,
    this.attachments = const [],
    this.constraints = const {},
    this.engagement = const ProblemEngagement(),
  });

  // Computed properties
  bool get isUrgent {
    if (deadline == null) return false;
    return deadline!.difference(DateTime.now()).inDays <= 14;
  }

  int get daysUntilDeadline {
    if (deadline == null) return -1;
    return deadline!.difference(DateTime.now()).inDays;
  }

  double get engagementScore {
    return (engagement.views * 0.1 +
            engagement.saves * 2.0 +
            engagement.workshopApplications * 3.0 +
            engagement.activeWorkshops * 5.0)
        .clamp(0.0, 100.0);
  }

  String get urgencyLabel {
    switch (urgencyLevel) {
      case 1:
        return 'Düşük';
      case 2:
        return 'Normal';
      case 3:
        return 'Orta';
      case 4:
        return 'Yüksek';
      case 5:
        return 'Acil';
      default:
        return 'Normal';
    }
  }

  Color get urgencyColor {
    if (urgencyLevel >= 4) return PColors.warning;
    if (urgencyLevel >= 3) return PColors.urgencyMedium;
    return PColors.success;
  }

  Color get impactColor {
    if (impactScore >= 80) return PColors.success;
    if (impactScore >= 50) return PColors.warning;
    return PColors.urgencyMedium;
  }

  factory Problem.fromJson(Map<String, dynamic> json) {
    return Problem(
      id: json['id'] as String,
      title: json['title'] as String,
      description: json['description'] as String,
      organization: json['organization'] as String,
      organizationId: json['organizationId'] as String,
      impactArea: ImpactArea.values.firstWhere(
        (e) => e.name == json['impactArea'],
        orElse: () => ImpactArea.technology,
      ),
      city: json['city'] as String,
      requiredSkills: (json['requiredSkills'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          [],
      status: ProblemStatus.values.firstWhere(
        (e) => e.name == json['status'],
        orElse: () => ProblemStatus.open,
      ),
      urgencyLevel: json['urgencyLevel'] as int? ?? 3,
      impactScore: json['impactScore'] as int? ?? 50,
      submittedAt: DateTime.parse(json['submittedAt'] as String),
      deadline: json['deadline'] != null
          ? DateTime.parse(json['deadline'] as String)
          : null,
      attachments: (json['attachments'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          [],
      constraints: json['constraints'] as Map<String, dynamic>? ?? {},
      engagement: json['engagement'] != null
          ? ProblemEngagement.fromJson(
              json['engagement'] as Map<String, dynamic>)
          : const ProblemEngagement(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'organization': organization,
      'organizationId': organizationId,
      'impactArea': impactArea.name,
      'city': city,
      'requiredSkills': requiredSkills,
      'status': status.name,
      'urgencyLevel': urgencyLevel,
      'impactScore': impactScore,
      'submittedAt': submittedAt.toIso8601String(),
      'deadline': deadline?.toIso8601String(),
      'attachments': attachments,
      'constraints': constraints,
      'engagement': engagement.toJson(),
    };
  }

  Problem copyWith({
    String? id,
    String? title,
    String? description,
    String? organization,
    String? organizationId,
    ImpactArea? impactArea,
    String? city,
    List<String>? requiredSkills,
    ProblemStatus? status,
    int? urgencyLevel,
    int? impactScore,
    DateTime? submittedAt,
    DateTime? deadline,
    List<String>? attachments,
    Map<String, dynamic>? constraints,
    ProblemEngagement? engagement,
  }) {
    return Problem(
      id: id ?? this.id,
      title: title ?? this.title,
      description: description ?? this.description,
      organization: organization ?? this.organization,
      organizationId: organizationId ?? this.organizationId,
      impactArea: impactArea ?? this.impactArea,
      city: city ?? this.city,
      requiredSkills: requiredSkills ?? this.requiredSkills,
      status: status ?? this.status,
      urgencyLevel: urgencyLevel ?? this.urgencyLevel,
      impactScore: impactScore ?? this.impactScore,
      submittedAt: submittedAt ?? this.submittedAt,
      deadline: deadline ?? this.deadline,
      attachments: attachments ?? this.attachments,
      constraints: constraints ?? this.constraints,
      engagement: engagement ?? this.engagement,
    );
  }
}
