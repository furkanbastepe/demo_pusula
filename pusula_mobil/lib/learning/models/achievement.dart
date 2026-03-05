import 'package:freezed_annotation/freezed_annotation.dart';
import 'progress.dart';

part 'achievement.freezed.dart';
part 'achievement.g.dart';

// ═══════════════════════════════════════════════════════════════════════════════════
// 🏆 ACHIEVEMENT MODEL - Freezed + JSON Serializable
// ═══════════════════════════════════════════════════════════════════════════════════

enum AchievementType {
  firstLesson,
  streakMilestone,
  courseCompletion,
  xpMilestone,
  perfectQuiz,
}

@freezed
class Achievement with _$Achievement {
  const Achievement._();
  
  const factory Achievement({
    required String id,
    required String title,
    required String description,
    required String iconPath,
    required AchievementType type,
    required int requirement,
  }) = _Achievement;

  factory Achievement.fromJson(Map<String, dynamic> json) => 
      _$AchievementFromJson(json);

  bool isEarned(LearningProgress progress) {
    return progress.earnedAchievements.contains(id);
  }

  bool shouldEarn(LearningProgress progress) {
    switch (type) {
      case AchievementType.firstLesson:
        // Check if any lesson is completed
        return progress.courseProgress.values
            .any((cp) => cp.completedLessonIds.isNotEmpty);
      
      case AchievementType.streakMilestone:
        return progress.currentStreak >= requirement;
      
      case AchievementType.courseCompletion:
        // This is checked per course, requirement is total lessons
        return false; // Handled separately in provider
      
      case AchievementType.xpMilestone:
        return progress.totalXP >= requirement;
      
      case AchievementType.perfectQuiz:
        // This is tracked per quiz, not globally
        return false; // Handled separately
    }
  }

  static List<Achievement> getDefaultAchievements() {
    return [
      const Achievement(
        id: 'first_lesson',
        title: 'İlk Adım',
        description: 'İlk dersini tamamladın!',
        iconPath: '🎯',
        type: AchievementType.firstLesson,
        requirement: 1,
      ),
      const Achievement(
        id: 'streak_7',
        title: 'Haftalık Savaşçı',
        description: '7 gün üst üste ders çalıştın!',
        iconPath: '🔥',
        type: AchievementType.streakMilestone,
        requirement: 7,
      ),
      const Achievement(
        id: 'streak_30',
        title: 'Aylık Kahraman',
        description: '30 gün üst üste ders çalıştın!',
        iconPath: '⚡',
        type: AchievementType.streakMilestone,
        requirement: 30,
      ),
      const Achievement(
        id: 'xp_500',
        title: 'Yükselen Yıldız',
        description: '500 XP kazandın!',
        iconPath: '⭐',
        type: AchievementType.xpMilestone,
        requirement: 500,
      ),
      const Achievement(
        id: 'xp_1000',
        title: 'Bilgi Avcısı',
        description: '1000 XP kazandın!',
        iconPath: '💎',
        type: AchievementType.xpMilestone,
        requirement: 1000,
      ),
      const Achievement(
        id: 'xp_2500',
        title: 'Kod Ustası',
        description: '2500 XP kazandın!',
        iconPath: '👑',
        type: AchievementType.xpMilestone,
        requirement: 2500,
      ),
    ];
  }
}
