// ═══════════════════════════════════════════════════════════════════════════════════
// 📊 WORKSHOP TEAM MODEL - Problem-Based Learning
// ═══════════════════════════════════════════════════════════════════════════════════

/// Team progress tracking
class TeamProgress {
  final double completionPercentage;
  final int currentMilestone;
  final int totalMilestones;
  final DateTime lastUpdated;

  const TeamProgress({
    this.completionPercentage = 0.0,
    this.currentMilestone = 0,
    this.totalMilestones = 0,
    required this.lastUpdated,
  });

  bool get isComplete => completionPercentage >= 100.0;

  factory TeamProgress.fromJson(Map<String, dynamic> json) {
    return TeamProgress(
      completionPercentage: (json['completionPercentage'] as num?)?.toDouble() ?? 0.0,
      currentMilestone: json['currentMilestone'] as int? ?? 0,
      totalMilestones: json['totalMilestones'] as int? ?? 0,
      lastUpdated: DateTime.parse(json['lastUpdated'] as String),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'completionPercentage': completionPercentage,
      'currentMilestone': currentMilestone,
      'totalMilestones': totalMilestones,
      'lastUpdated': lastUpdated.toIso8601String(),
    };
  }

  TeamProgress copyWith({
    double? completionPercentage,
    int? currentMilestone,
    int? totalMilestones,
    DateTime? lastUpdated,
  }) {
    return TeamProgress(
      completionPercentage: completionPercentage ?? this.completionPercentage,
      currentMilestone: currentMilestone ?? this.currentMilestone,
      totalMilestones: totalMilestones ?? this.totalMilestones,
      lastUpdated: lastUpdated ?? this.lastUpdated,
    );
  }
}

/// Team deliverable
class TeamDeliverable {
  final String id;
  final String title;
  final String description;
  final String? fileUrl;
  final String? linkUrl;
  final DateTime submittedAt;
  final String submittedBy;

  const TeamDeliverable({
    required this.id,
    required this.title,
    required this.description,
    this.fileUrl,
    this.linkUrl,
    required this.submittedAt,
    required this.submittedBy,
  });

  bool get hasFile => fileUrl != null && fileUrl!.isNotEmpty;
  bool get hasLink => linkUrl != null && linkUrl!.isNotEmpty;

  factory TeamDeliverable.fromJson(Map<String, dynamic> json) {
    return TeamDeliverable(
      id: json['id'] as String,
      title: json['title'] as String,
      description: json['description'] as String,
      fileUrl: json['fileUrl'] as String?,
      linkUrl: json['linkUrl'] as String?,
      submittedAt: DateTime.parse(json['submittedAt'] as String),
      submittedBy: json['submittedBy'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'fileUrl': fileUrl,
      'linkUrl': linkUrl,
      'submittedAt': submittedAt.toIso8601String(),
      'submittedBy': submittedBy,
    };
  }

  TeamDeliverable copyWith({
    String? id,
    String? title,
    String? description,
    String? fileUrl,
    String? linkUrl,
    DateTime? submittedAt,
    String? submittedBy,
  }) {
    return TeamDeliverable(
      id: id ?? this.id,
      title: title ?? this.title,
      description: description ?? this.description,
      fileUrl: fileUrl ?? this.fileUrl,
      linkUrl: linkUrl ?? this.linkUrl,
      submittedAt: submittedAt ?? this.submittedAt,
      submittedBy: submittedBy ?? this.submittedBy,
    );
  }
}

/// Team message for communication
class TeamMessage {
  final String id;
  final String teamId;
  final String senderId;
  final String senderName;
  final String message;
  final DateTime sentAt;
  final bool isRead;

  const TeamMessage({
    required this.id,
    required this.teamId,
    required this.senderId,
    required this.senderName,
    required this.message,
    required this.sentAt,
    this.isRead = false,
  });

  factory TeamMessage.fromJson(Map<String, dynamic> json) {
    return TeamMessage(
      id: json['id'] as String,
      teamId: json['teamId'] as String,
      senderId: json['senderId'] as String,
      senderName: json['senderName'] as String,
      message: json['message'] as String,
      sentAt: DateTime.parse(json['sentAt'] as String),
      isRead: json['isRead'] as bool? ?? false,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'teamId': teamId,
      'senderId': senderId,
      'senderName': senderName,
      'message': message,
      'sentAt': sentAt.toIso8601String(),
      'isRead': isRead,
    };
  }

  TeamMessage copyWith({
    String? id,
    String? teamId,
    String? senderId,
    String? senderName,
    String? message,
    DateTime? sentAt,
    bool? isRead,
  }) {
    return TeamMessage(
      id: id ?? this.id,
      teamId: teamId ?? this.teamId,
      senderId: senderId ?? this.senderId,
      senderName: senderName ?? this.senderName,
      message: message ?? this.message,
      sentAt: sentAt ?? this.sentAt,
      isRead: isRead ?? this.isRead,
    );
  }
}

/// Main Workshop Team model
class WorkshopTeam {
  final String id;
  final String workshopId;
  final String name;
  final List<String> memberIds;
  final String? leaderId;
  final TeamProgress progress;
  final List<TeamDeliverable> deliverables;

  const WorkshopTeam({
    required this.id,
    required this.workshopId,
    required this.name,
    this.memberIds = const [],
    this.leaderId,
    required this.progress,
    this.deliverables = const [],
  });

  // Computed properties
  int get memberCount => memberIds.length;

  bool get hasLeader => leaderId != null;

  bool get isValidSize => memberCount >= 2 && memberCount <= 5;

  String get memberCountText => '$memberCount üye';

  factory WorkshopTeam.fromJson(Map<String, dynamic> json) {
    return WorkshopTeam(
      id: json['id'] as String,
      workshopId: json['workshopId'] as String,
      name: json['name'] as String,
      memberIds: (json['memberIds'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          [],
      leaderId: json['leaderId'] as String?,
      progress: TeamProgress.fromJson(
          json['progress'] as Map<String, dynamic>? ??
              {
                'completionPercentage': 0.0,
                'currentMilestone': 0,
                'totalMilestones': 0,
                'lastUpdated': DateTime.now().toIso8601String(),
              }),
      deliverables: (json['deliverables'] as List<dynamic>?)
              ?.map((e) => TeamDeliverable.fromJson(e as Map<String, dynamic>))
              .toList() ??
          [],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'workshopId': workshopId,
      'name': name,
      'memberIds': memberIds,
      'leaderId': leaderId,
      'progress': progress.toJson(),
      'deliverables': deliverables.map((d) => d.toJson()).toList(),
    };
  }

  WorkshopTeam copyWith({
    String? id,
    String? workshopId,
    String? name,
    List<String>? memberIds,
    String? leaderId,
    TeamProgress? progress,
    List<TeamDeliverable>? deliverables,
  }) {
    return WorkshopTeam(
      id: id ?? this.id,
      workshopId: workshopId ?? this.workshopId,
      name: name ?? this.name,
      memberIds: memberIds ?? this.memberIds,
      leaderId: leaderId ?? this.leaderId,
      progress: progress ?? this.progress,
      deliverables: deliverables ?? this.deliverables,
    );
  }
}
