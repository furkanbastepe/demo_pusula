import 'package:flutter/material.dart';
import '../../core/core.dart';
import 'user_level.dart';

// ═══════════════════════════════════════════════════════════════════════════════════
// 📊 APP USER MODEL
// ═══════════════════════════════════════════════════════════════════════════════════

class AppUser {
  final String id;
  final String name;
  final String email;
  final String city;
  final UserLevel level;
  final List<String> skills;
  final String skillPath;
  final bool safeMode;
  final int volunteerHours;
  final int completedProjects;
  final double reputation;
  final int xp;
  final List<String> mentees;
  final String? mentorId;
  final String? avatar;
  final int learningXP;
  final int learningStreak;

  const AppUser({
    required this.id,
    required this.name,
    required this.email,
    required this.city,
    this.level = UserLevel.cirak,
    this.skills = const [],
    this.skillPath = 'Veri Analisti',
    this.safeMode = false,
    this.volunteerHours = 0,
    this.completedProjects = 0,
    this.reputation = 5.0,
    this.xp = 0,
    this.mentees = const [],
    this.mentorId,
    this.avatar,
    this.learningXP = 0,
    this.learningStreak = 0,
  });

  AppUser copyWith({
    String? city,
    UserLevel? level,
    List<String>? skills,
    String? skillPath,
    int? volunteerHours,
    int? completedProjects,
    double? reputation,
    int? xp,
    int? learningXP,
    int? learningStreak,
  }) {
    return AppUser(
      id: id,
      name: name,
      email: email,
      city: city ?? this.city,
      level: level ?? this.level,
      skills: skills ?? this.skills,
      skillPath: skillPath ?? this.skillPath,
      safeMode: safeMode,
      volunteerHours: volunteerHours ?? this.volunteerHours,
      completedProjects: completedProjects ?? this.completedProjects,
      reputation: reputation ?? this.reputation,
      xp: xp ?? this.xp,
      mentees: mentees,
      mentorId: mentorId,
      avatar: avatar,
      learningXP: learningXP ?? this.learningXP,
      learningStreak: learningStreak ?? this.learningStreak,
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

  Color get levelColor {
    switch (level) {
      case UserLevel.cirak:
        return PColors.success;
      case UserLevel.kalfa:
        return PColors.info;
      case UserLevel.usta:
        return PColors.accent;
      case UserLevel.buyukUsta:
        return PColors.levelBuyukUsta;
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

  int get completedTasks => completedProjects * 3 + volunteerHours ~/ 5;
}
