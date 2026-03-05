import 'package:freezed_annotation/freezed_annotation.dart';

part 'progress.freezed.dart';
part 'progress.g.dart';

// ═══════════════════════════════════════════════════════════════════════════════════
// 📊 PROGRESS MODELS - Freezed + JSON Serializable
// ═══════════════════════════════════════════════════════════════════════════════════

@freezed
class LearningProgress with _$LearningProgress {
  const LearningProgress._();
  
  const factory LearningProgress({
    required String userId,
    @Default({}) Map<String, CourseProgress> courseProgress,
    @Default(0) int totalXP,
    @Default(0) int currentStreak,
    required DateTime lastActivityDate,
    @Default([]) List<String> earnedAchievements,
  }) = _LearningProgress;

  factory LearningProgress.fromJson(Map<String, dynamic> json) => 
      _$LearningProgressFromJson(json);

  factory LearningProgress.initial(String userId) => LearningProgress(
    userId: userId,
    lastActivityDate: DateTime.now(),
  );

  LearningProgress completeLesson(String courseId, String lessonId, int xpEarned) {
    final currentCourseProgress = courseProgress[courseId] ?? CourseProgress.initial(courseId);
    
    // Don't add XP if lesson already completed
    if (currentCourseProgress.completedLessonIds.contains(lessonId)) {
      return this;
    }
    
    final updatedCourseProgress = currentCourseProgress.copyWith(
      completedLessonIds: [...currentCourseProgress.completedLessonIds, lessonId],
      earnedXP: currentCourseProgress.earnedXP + xpEarned,
      lastAccessDate: DateTime.now(),
    );

    return copyWith(
      courseProgress: {...courseProgress, courseId: updatedCourseProgress},
      totalXP: totalXP + xpEarned,
      lastActivityDate: DateTime.now(),
    );
  }

  LearningProgress updateStreak() {
    final now = DateTime.now();
    final lastActivity = lastActivityDate;
    final daysDifference = now.difference(lastActivity).inDays;

    int newStreak;
    if (daysDifference == 0) {
      // Same day, keep streak
      newStreak = currentStreak;
    } else if (daysDifference == 1) {
      // Next day, increment streak
      newStreak = currentStreak + 1;
    } else {
      // Streak broken, reset to 1
      newStreak = 1;
    }

    return copyWith(
      currentStreak: newStreak,
      lastActivityDate: now,
    );
  }

  double getCourseProgress(String courseId, int totalLessons) {
    final progress = courseProgress[courseId];
    if (progress == null || totalLessons == 0) return 0.0;
    return progress.completedLessonIds.length / totalLessons;
  }

  LearningProgress addAchievement(String achievementId) {
    if (earnedAchievements.contains(achievementId)) return this;
    return copyWith(
      earnedAchievements: [...earnedAchievements, achievementId],
    );
  }
}

@freezed
class CourseProgress with _$CourseProgress {
  const factory CourseProgress({
    required String courseId,
    @Default([]) List<String> completedLessonIds,
    @Default(0) int earnedXP,
    required DateTime lastAccessDate,
  }) = _CourseProgress;

  factory CourseProgress.fromJson(Map<String, dynamic> json) => 
      _$CourseProgressFromJson(json);

  factory CourseProgress.initial(String courseId) => CourseProgress(
    courseId: courseId,
    lastAccessDate: DateTime.now(),
  );
}
