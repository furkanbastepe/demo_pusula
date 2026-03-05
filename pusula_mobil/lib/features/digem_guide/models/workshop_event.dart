import '../../../data/models/user_level.dart';

// ═══════════════════════════════════════════════════════════════════════════════════
// 🎓 WORKSHOP EVENT MODEL
// ═══════════════════════════════════════════════════════════════════════════════════

enum WorkshopStatus {
  upcoming,
  inProgress,
  completed,
  cancelled,
}

class WorkshopEvent {
  final String id;
  final String name;
  final String description;
  final String instructor;
  final DateTime dateTime;
  final int durationHours;
  final int capacity;
  final int currentParticipants;
  final UserLevel? requiredLevel;
  final List<String> skillsCovered;
  final WorkshopStatus status;
  final DateTime createdAt;

  const WorkshopEvent({
    required this.id,
    required this.name,
    required this.description,
    required this.instructor,
    required this.dateTime,
    required this.durationHours,
    required this.capacity,
    required this.currentParticipants,
    this.requiredLevel,
    required this.skillsCovered,
    required this.status,
    required this.createdAt,
  });

  factory WorkshopEvent.fromJson(Map<String, dynamic> json) {
    return WorkshopEvent(
      id: json['id'] as String,
      name: json['name'] as String,
      description: json['description'] as String? ?? '',
      instructor: json['instructor'] as String,
      dateTime: DateTime.parse(json['dateTime'] as String),
      durationHours: json['durationHours'] as int,
      capacity: json['capacity'] as int,
      currentParticipants: json['currentParticipants'] as int? ?? 0,
      requiredLevel: json['requiredLevel'] != null
          ? UserLevel.values.firstWhere(
              (e) => e.name == json['requiredLevel'],
              orElse: () => UserLevel.cirak,
            )
          : null,
      skillsCovered: (json['skillsCovered'] as List<dynamic>?)?.cast<String>() ?? [],
      status: WorkshopStatus.values.firstWhere(
        (e) => e.name == json['status'],
        orElse: () => WorkshopStatus.upcoming,
      ),
      createdAt: json['createdAt'] != null
          ? DateTime.parse(json['createdAt'] as String)
          : DateTime.now(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'description': description,
      'instructor': instructor,
      'dateTime': dateTime.toIso8601String(),
      'durationHours': durationHours,
      'capacity': capacity,
      'currentParticipants': currentParticipants,
      'requiredLevel': requiredLevel?.name,
      'skillsCovered': skillsCovered,
      'status': status.name,
      'createdAt': createdAt.toIso8601String(),
    };
  }

  WorkshopEvent copyWith({
    String? id,
    String? name,
    String? description,
    String? instructor,
    DateTime? dateTime,
    int? durationHours,
    int? capacity,
    int? currentParticipants,
    UserLevel? requiredLevel,
    List<String>? skillsCovered,
    WorkshopStatus? status,
    DateTime? createdAt,
  }) {
    return WorkshopEvent(
      id: id ?? this.id,
      name: name ?? this.name,
      description: description ?? this.description,
      instructor: instructor ?? this.instructor,
      dateTime: dateTime ?? this.dateTime,
      durationHours: durationHours ?? this.durationHours,
      capacity: capacity ?? this.capacity,
      currentParticipants: currentParticipants ?? this.currentParticipants,
      requiredLevel: requiredLevel ?? this.requiredLevel,
      skillsCovered: skillsCovered ?? this.skillsCovered,
      status: status ?? this.status,
      createdAt: createdAt ?? this.createdAt,
    );
  }

  double get enrollmentPercentage => 
      capacity > 0 ? currentParticipants / capacity : 0.0;

  bool get isFull => currentParticipants >= capacity;

  bool get isUpcoming => status == WorkshopStatus.upcoming;

  bool get isInProgress => status == WorkshopStatus.inProgress;

  bool get isCompleted => status == WorkshopStatus.completed;

  bool get isCancelled => status == WorkshopStatus.cancelled;
}
