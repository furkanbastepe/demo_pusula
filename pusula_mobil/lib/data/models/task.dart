import 'package:flutter/material.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import '../../core/core.dart';
import 'project_type.dart';
import 'user_level.dart';

// ═══════════════════════════════════════════════════════════════════════════════════
// 📊 TASK MODEL
// ═══════════════════════════════════════════════════════════════════════════════════

class Task {
  final String id;
  final String title;
  final String description;
  final String organization;
  final ProjectType type;
  final UserLevel requiredLevel;
  final String city;
  final List<String> requiredSkills;
  final String imageUrl;
  final bool womenOnly;
  final int maxParticipants;
  final int currentParticipants;
  final DateTime deadline;
  final int impactScore;
  final int xpReward;
  final int estimatedHours;

  const Task({
    required this.id,
    required this.title,
    required this.description,
    required this.organization,
    required this.type,
    required this.requiredLevel,
    required this.city,
    required this.requiredSkills,
    required this.imageUrl,
    this.womenOnly = false,
    this.maxParticipants = 5,
    this.currentParticipants = 0,
    required this.deadline,
    this.impactScore = 50,
    this.xpReward = 100,
    this.estimatedHours = 8,
  });

  bool get isAvailable => currentParticipants < maxParticipants;
  bool get isUrgent => deadline.difference(DateTime.now()).inDays <= 7;
  int get remainingDays => deadline.difference(DateTime.now()).inDays;

  String get typeDescription {
    switch (type) {
      case ProjectType.volunteer:
        return 'Gönüllülük';
      case ProjectType.municipal:
        return 'Belediye';
      case ProjectType.sme:
        return 'KOBİ';
      case ProjectType.startup:
        return 'Girişim';
    }
  }
  
  Color get typeColor {
    switch (type) {
      case ProjectType.volunteer:
        return PColors.success;
      case ProjectType.municipal:
        return PColors.primary;
      case ProjectType.sme:
        return PColors.accent;
      case ProjectType.startup:
        return PColors.info;
    }
  }

  IconData get typeIcon {
    switch (type) {
      case ProjectType.volunteer:
        return LucideIcons.heart;
      case ProjectType.municipal:
        return LucideIcons.building;
      case ProjectType.sme:
        return LucideIcons.briefcase;
      case ProjectType.startup:
        return LucideIcons.rocket;
    }
  }
}
