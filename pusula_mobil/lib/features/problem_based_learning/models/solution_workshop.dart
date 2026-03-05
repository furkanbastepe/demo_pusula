import 'package:flutter/material.dart';
import '../../../core/core.dart';
import 'workshop_team.dart';

// ═══════════════════════════════════════════════════════════════════════════════════
// 📊 SOLUTION WORKSHOP MODEL - Problem-Based Learning
// ═══════════════════════════════════════════════════════════════════════════════════

/// Workshop status in the lifecycle
enum WorkshopStatus {
  forming,
  active,
  completed,
  cancelled;

  String get displayName {
    switch (this) {
      case WorkshopStatus.forming:
        return 'Oluşuyor';
      case WorkshopStatus.active:
        return 'Aktif';
      case WorkshopStatus.completed:
        return 'Tamamlandı';
      case WorkshopStatus.cancelled:
        return 'İptal Edildi';
    }
  }

  Color get color {
    switch (this) {
      case WorkshopStatus.forming:
        return PColors.warning;
      case WorkshopStatus.active:
        return PColors.success;
      case WorkshopStatus.completed:
        return PColors.primary;
      case WorkshopStatus.cancelled:
        return PColors.textDim;
    }
  }
}

/// Milestone in workshop progress
class WorkshopMilestone {
  final String id;
  final String title;
  final String description;
  final int order;
  final bool isCompleted;
  final DateTime? completedAt;
  final String? facilitatorFeedback;

  const WorkshopMilestone({
    required this.id,
    required this.title,
    required this.description,
    required this.order,
    this.isCompleted = false,
    this.completedAt,
    this.facilitatorFeedback,
  });

  factory WorkshopMilestone.fromJson(Map<String, dynamic> json) {
    return WorkshopMilestone(
      id: json['id'] as String,
      title: json['title'] as String,
      description: json['description'] as String,
      order: json['order'] as int,
      isCompleted: json['isCompleted'] as bool? ?? false,
      completedAt: json['completedAt'] != null
          ? DateTime.parse(json['completedAt'] as String)
          : null,
      facilitatorFeedback: json['facilitatorFeedback'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'order': order,
      'isCompleted': isCompleted,
      'completedAt': completedAt?.toIso8601String(),
      'facilitatorFeedback': facilitatorFeedback,
    };
  }

  WorkshopMilestone copyWith({
    String? id,
    String? title,
    String? description,
    int? order,
    bool? isCompleted,
    DateTime? completedAt,
    String? facilitatorFeedback,
  }) {
    return WorkshopMilestone(
      id: id ?? this.id,
      title: title ?? this.title,
      description: description ?? this.description,
      order: order ?? this.order,
      isCompleted: isCompleted ?? this.isCompleted,
      completedAt: completedAt ?? this.completedAt,
      facilitatorFeedback: facilitatorFeedback ?? this.facilitatorFeedback,
    );
  }
}

/// Project validation by organization
class ProjectValidation {
  final bool isApproved;
  final int rating; // 1-5
  final String feedback;
  final DateTime reviewedAt;
  final String reviewerId;

  const ProjectValidation({
    required this.isApproved,
    required this.rating,
    required this.feedback,
    required this.reviewedAt,
    required this.reviewerId,
  });

  factory ProjectValidation.fromJson(Map<String, dynamic> json) {
    return ProjectValidation(
      isApproved: json['isApproved'] as bool,
      rating: json['rating'] as int,
      feedback: json['feedback'] as String,
      reviewedAt: DateTime.parse(json['reviewedAt'] as String),
      reviewerId: json['reviewerId'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'isApproved': isApproved,
      'rating': rating,
      'feedback': feedback,
      'reviewedAt': reviewedAt.toIso8601String(),
      'reviewerId': reviewerId,
    };
  }
}

/// Workshop project deliverable
class WorkshopProject {
  final String id;
  final String workshopId;
  final String problemId;
  final String title;
  final String description;
  final List<String> deliverables;
  final String? repositoryUrl;
  final String? demoUrl;
  final ProjectValidation? validation;
  final DateTime submittedAt;

  const WorkshopProject({
    required this.id,
    required this.workshopId,
    required this.problemId,
    required this.title,
    required this.description,
    this.deliverables = const [],
    this.repositoryUrl,
    this.demoUrl,
    this.validation,
    required this.submittedAt,
  });

  bool get isValidated => validation != null;
  bool get isApproved => validation?.isApproved ?? false;

  factory WorkshopProject.fromJson(Map<String, dynamic> json) {
    return WorkshopProject(
      id: json['id'] as String,
      workshopId: json['workshopId'] as String,
      problemId: json['problemId'] as String,
      title: json['title'] as String,
      description: json['description'] as String,
      deliverables: (json['deliverables'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          [],
      repositoryUrl: json['repositoryUrl'] as String?,
      demoUrl: json['demoUrl'] as String?,
      validation: json['validation'] != null
          ? ProjectValidation.fromJson(
              json['validation'] as Map<String, dynamic>)
          : null,
      submittedAt: DateTime.parse(json['submittedAt'] as String),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'workshopId': workshopId,
      'problemId': problemId,
      'title': title,
      'description': description,
      'deliverables': deliverables,
      'repositoryUrl': repositoryUrl,
      'demoUrl': demoUrl,
      'validation': validation?.toJson(),
      'submittedAt': submittedAt.toIso8601String(),
    };
  }

  WorkshopProject copyWith({
    String? id,
    String? workshopId,
    String? problemId,
    String? title,
    String? description,
    List<String>? deliverables,
    String? repositoryUrl,
    String? demoUrl,
    ProjectValidation? validation,
    DateTime? submittedAt,
  }) {
    return WorkshopProject(
      id: id ?? this.id,
      workshopId: workshopId ?? this.workshopId,
      problemId: problemId ?? this.problemId,
      title: title ?? this.title,
      description: description ?? this.description,
      deliverables: deliverables ?? this.deliverables,
      repositoryUrl: repositoryUrl ?? this.repositoryUrl,
      demoUrl: demoUrl ?? this.demoUrl,
      validation: validation ?? this.validation,
      submittedAt: submittedAt ?? this.submittedAt,
    );
  }
}

/// Main Solution Workshop model
class SolutionWorkshop {
  final String id;
  final String problemId;
  final String name;
  final WorkshopStatus status;
  final String? facilitatorId;
  final List<String> participantIds;
  final List<WorkshopTeam> teams;
  final DateTime createdAt;
  final DateTime? startedAt;
  final DateTime? completedAt;
  final int maxParticipants;
  final int minParticipants;
  final List<WorkshopMilestone> milestones;
  final WorkshopProject? project;

  const SolutionWorkshop({
    required this.id,
    required this.problemId,
    required this.name,
    this.status = WorkshopStatus.forming,
    this.facilitatorId,
    this.participantIds = const [],
    this.teams = const [],
    required this.createdAt,
    this.startedAt,
    this.completedAt,
    this.maxParticipants = 15,
    this.minParticipants = 3,
    this.milestones = const [],
    this.project,
  });

  // Computed properties
  int get currentParticipants => participantIds.length;

  bool get isFull => currentParticipants >= maxParticipants;

  bool get canStart => currentParticipants >= minParticipants;

  bool get isActive => status == WorkshopStatus.active;

  bool get isCompleted => status == WorkshopStatus.completed;

  int get completedMilestones =>
      milestones.where((m) => m.isCompleted).length;

  double get progressPercentage {
    if (milestones.isEmpty) return 0.0;
    return (completedMilestones / milestones.length) * 100;
  }

  int? get daysActive {
    if (startedAt == null) return null;
    return DateTime.now().difference(startedAt!).inDays;
  }

  String get participantCountText => '$currentParticipants/$maxParticipants';

  factory SolutionWorkshop.fromJson(Map<String, dynamic> json) {
    return SolutionWorkshop(
      id: json['id'] as String,
      problemId: json['problemId'] as String,
      name: json['name'] as String,
      status: WorkshopStatus.values.firstWhere(
        (e) => e.name == json['status'],
        orElse: () => WorkshopStatus.forming,
      ),
      facilitatorId: json['facilitatorId'] as String?,
      participantIds: (json['participantIds'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          [],
      teams: (json['teams'] as List<dynamic>?)
              ?.map((e) => WorkshopTeam.fromJson(e as Map<String, dynamic>))
              .toList() ??
          [],
      createdAt: DateTime.parse(json['createdAt'] as String),
      startedAt: json['startedAt'] != null
          ? DateTime.parse(json['startedAt'] as String)
          : null,
      completedAt: json['completedAt'] != null
          ? DateTime.parse(json['completedAt'] as String)
          : null,
      maxParticipants: json['maxParticipants'] as int? ?? 15,
      minParticipants: json['minParticipants'] as int? ?? 3,
      milestones: (json['milestones'] as List<dynamic>?)
              ?.map((e) =>
                  WorkshopMilestone.fromJson(e as Map<String, dynamic>))
              .toList() ??
          [],
      project: json['project'] != null
          ? WorkshopProject.fromJson(json['project'] as Map<String, dynamic>)
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'problemId': problemId,
      'name': name,
      'status': status.name,
      'facilitatorId': facilitatorId,
      'participantIds': participantIds,
      'teams': teams.map((t) => t.toJson()).toList(),
      'createdAt': createdAt.toIso8601String(),
      'startedAt': startedAt?.toIso8601String(),
      'completedAt': completedAt?.toIso8601String(),
      'maxParticipants': maxParticipants,
      'minParticipants': minParticipants,
      'milestones': milestones.map((m) => m.toJson()).toList(),
      'project': project?.toJson(),
    };
  }

  SolutionWorkshop copyWith({
    String? id,
    String? problemId,
    String? name,
    WorkshopStatus? status,
    String? facilitatorId,
    List<String>? participantIds,
    List<WorkshopTeam>? teams,
    DateTime? createdAt,
    DateTime? startedAt,
    DateTime? completedAt,
    int? maxParticipants,
    int? minParticipants,
    List<WorkshopMilestone>? milestones,
    WorkshopProject? project,
  }) {
    return SolutionWorkshop(
      id: id ?? this.id,
      problemId: problemId ?? this.problemId,
      name: name ?? this.name,
      status: status ?? this.status,
      facilitatorId: facilitatorId ?? this.facilitatorId,
      participantIds: participantIds ?? this.participantIds,
      teams: teams ?? this.teams,
      createdAt: createdAt ?? this.createdAt,
      startedAt: startedAt ?? this.startedAt,
      completedAt: completedAt ?? this.completedAt,
      maxParticipants: maxParticipants ?? this.maxParticipants,
      minParticipants: minParticipants ?? this.minParticipants,
      milestones: milestones ?? this.milestones,
      project: project ?? this.project,
    );
  }
}
