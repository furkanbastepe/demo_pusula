import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/models.dart';

// ═══════════════════════════════════════════════════════════════════════════════════
// 💾 PROGRESS SERVICE - V2.1 SharedPreferences (No backend)
// ═══════════════════════════════════════════════════════════════════════════════════

class ProgressService {
  static const String _progressKey = 'learning_progress';

  Future<void> saveProgress(LearningProgress progress) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final jsonString = json.encode(progress.toJson());
      await prefs.setString(_progressKey, jsonString);
    } catch (e) {
      print('Error saving progress: $e');
      rethrow;
    }
  }

  Future<LearningProgress?> loadProgress(String userId) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final jsonString = prefs.getString(_progressKey);
      
      if (jsonString == null) {
        // For demo purposes, unlock all lessons for Merve
        return _createDemoProgress(userId);
      }

      final jsonMap = json.decode(jsonString) as Map<String, dynamic>;
      return LearningProgress.fromJson(jsonMap);
    } catch (e) {
      print('Error loading progress: $e');
      return _createDemoProgress(userId);
    }
  }

  // Create demo progress with all lessons unlocked
  LearningProgress _createDemoProgress(String userId) {
    return LearningProgress(
      userId: userId,
      courseProgress: {
        'python-basics': CourseProgress(
          courseId: 'python-basics',
          completedLessonIds: [], // All lessons accessible but not completed
          earnedXP: 0,
          lastAccessDate: DateTime.now(),
        ),
        'sql-basics': CourseProgress(
          courseId: 'sql-basics',
          completedLessonIds: [], // All lessons accessible but not completed
          earnedXP: 0,
          lastAccessDate: DateTime.now(),
        ),
      },
      totalXP: 0,
      currentStreak: 7, // Demo streak
      lastActivityDate: DateTime.now(),
      earnedAchievements: [],
    );
  }

  Future<void> clearProgress() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_progressKey);
  }
}
