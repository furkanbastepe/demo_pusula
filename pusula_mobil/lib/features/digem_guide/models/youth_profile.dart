import '../../../data/models/user_level.dart';

// ═══════════════════════════════════════════════════════════════════════════════════
// 👤 YOUTH PROFILE MODEL
// ═══════════════════════════════════════════════════════════════════════════════════

class YouthProfile {
  final String id;
  final String name;
  final String email;
  final String city;
  final UserLevel level;
  final List<String> skills;
  final String skillPath;
  final int volunteerHours;
  final int completedProjects;
  final double reputation;
  final int xp;
  final DateTime registrationDate;
  final String? mentorId;
  final bool levelProgressionPending;

  const YouthProfile({
    required this.id,
    required this.name,
    required this.email,
    required this.city,
    required this.level,
    required this.skills,
    required this.skillPath,
    required this.volunteerHours,
    required this.completedProjects,
    required this.reputation,
    required this.xp,
    required this.registrationDate,
    this.mentorId,
    this.levelProgressionPending = false,
  });

  factory YouthProfile.fromJson(Map<String, dynamic> json) {
    return YouthProfile(
      id: json['id'] as String,
      name: json['name'] as String,
      email: json['email'] as String,
      city: json['city'] as String,
      level: UserLevel.values.firstWhere(
        (e) => e.name == json['level'],
        orElse: () => UserLevel.cirak,
      ),
      skills: (json['skills'] as List<dynamic>?)?.cast<String>() ?? [],
      skillPath: json['skillPath'] as String? ?? '',
      volunteerHours: json['volunteerHours'] as int? ?? 0,
      completedProjects: json['completedProjects'] as int? ?? 0,
      reputation: (json['reputation'] as num?)?.toDouble() ?? 5.0,
      xp: json['xp'] as int? ?? 0,
      registrationDate: json['registrationDate'] != null
          ? DateTime.parse(json['registrationDate'] as String)
          : DateTime.now(),
      mentorId: json['mentorId'] as String?,
      levelProgressionPending: json['levelProgressionPending'] as bool? ?? false,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'email': email,
      'city': city,
      'level': level.name,
      'skills': skills,
      'skillPath': skillPath,
      'volunteerHours': volunteerHours,
      'completedProjects': completedProjects,
      'reputation': reputation,
      'xp': xp,
      'registrationDate': registrationDate.toIso8601String(),
      'mentorId': mentorId,
      'levelProgressionPending': levelProgressionPending,
    };
  }

  YouthProfile copyWith({
    String? id,
    String? name,
    String? email,
    String? city,
    UserLevel? level,
    List<String>? skills,
    String? skillPath,
    int? volunteerHours,
    int? completedProjects,
    double? reputation,
    int? xp,
    DateTime? registrationDate,
    String? mentorId,
    bool? levelProgressionPending,
  }) {
    return YouthProfile(
      id: id ?? this.id,
      name: name ?? this.name,
      email: email ?? this.email,
      city: city ?? this.city,
      level: level ?? this.level,
      skills: skills ?? this.skills,
      skillPath: skillPath ?? this.skillPath,
      volunteerHours: volunteerHours ?? this.volunteerHours,
      completedProjects: completedProjects ?? this.completedProjects,
      reputation: reputation ?? this.reputation,
      xp: xp ?? this.xp,
      registrationDate: registrationDate ?? this.registrationDate,
      mentorId: mentorId ?? this.mentorId,
      levelProgressionPending: levelProgressionPending ?? this.levelProgressionPending,
    );
  }

  String get levelName {
    switch (level) {
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

  int get xpToNextLevel {
    switch (level) {
      case UserLevel.cirak:
        return 1000;
      case UserLevel.kalfa:
        return 2500;
      case UserLevel.usta:
        return 5000;
      case UserLevel.buyukUsta:
        return 10000;
    }
  }

  double get progressToNextLevel {
    return xp / xpToNextLevel;
  }
}
