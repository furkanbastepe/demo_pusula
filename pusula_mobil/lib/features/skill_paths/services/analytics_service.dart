import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import 'package:pusula/features/skill_paths/models/models.dart';

// ═══════════════════════════════════════════════════════════════════════════════════
// 📈 ANALYTICS SERVICE
// ═══════════════════════════════════════════════════════════════════════════════════

class AnalyticsService {
  // Singleton pattern
  static final AnalyticsService _instance = AnalyticsService._internal();
  factory AnalyticsService() => _instance;
  AnalyticsService._internal();

  // Active timers
  final Map<String, DateTime> _activeTimers = {};

  // ═══════════════════════════════════════════════════════════════════════════════════
  // TIME TRACKING
  // ═══════════════════════════════════════════════════════════════════════════════════

  /// Start timer for a stage
  Future<void> startTimer(String stageId) async {
    _activeTimers[stageId] = DateTime.now();
  }

  /// Stop timer for a stage and return minutes spent
  Future<int> stopTimer(String stageId) async {
    final startTime = _activeTimers[stageId];
    if (startTime == null) return 0;

    final endTime = DateTime.now();
    final duration = endTime.difference(startTime);
    final minutes = duration.inMinutes;

    _activeTimers.remove(stageId);

    return minutes;
  }

  /// Get time spent on a stage
  Future<int> getTimeSpent(String stageId) async {
    final startTime = _activeTimers[stageId];
    if (startTime == null) return 0;

    final now = DateTime.now();
    final duration = now.difference(startTime);
    return duration.inMinutes;
  }

  // ═══════════════════════════════════════════════════════════════════════════════════
  // ENGAGEMENT TRACKING
  // ═══════════════════════════════════════════════════════════════════════════════════

  /// Track AI interaction
  Future<void> trackAIInteraction(String stageId, String messageType) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final key = 'ai_interactions_$stageId';
      final count = prefs.getInt(key) ?? 0;
      await prefs.setInt(key, count + 1);
    } catch (e) {
      print('Error tracking AI interaction: $e');
    }
  }

  /// Track validation attempt
  Future<void> trackValidationAttempt(String stageId, bool passed) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      
      // Track total attempts
      final attemptsKey = 'validation_attempts_$stageId';
      final attempts = prefs.getInt(attemptsKey) ?? 0;
      await prefs.setInt(attemptsKey, attempts + 1);

      // Track successful attempts
      if (passed) {
        final successKey = 'validation_success_$stageId';
        final successes = prefs.getInt(successKey) ?? 0;
        await prefs.setInt(successKey, successes + 1);
      }
    } catch (e) {
      print('Error tracking validation attempt: $e');
    }
  }

  /// Track stage completion
  Future<void> trackStageCompletion(String stageId, int attempts) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final key = 'stage_completion_$stageId';
      final data = {
        'completedAt': DateTime.now().toIso8601String(),
        'attempts': attempts,
      };
      await prefs.setString(key, jsonEncode(data));
    } catch (e) {
      print('Error tracking stage completion: $e');
    }
  }

  // ═══════════════════════════════════════════════════════════════════════════════════
  // ANALYTICS CALCULATION
  // ═══════════════════════════════════════════════════════════════════════════════════

  /// Calculate learning analytics for a user and project
  Future<LearningAnalytics> calculateAnalytics(
    String userId,
    String projectId,
  ) async {
    try {
      final prefs = await SharedPreferences.getInstance();

      // Calculate total time spent
      int totalTimeSpent = 0;
      final timePerStage = <String, int>{};
      
      // Get all stage time data
      final allKeys = prefs.getKeys();
      for (final key in allKeys) {
        if (key.startsWith('stage_time_')) {
          final stageId = key.replaceFirst('stage_time_', '');
          final minutes = prefs.getInt(key) ?? 0;
          timePerStage[stageId] = minutes;
          totalTimeSpent += minutes;
        }
      }

      // Calculate total AI interactions
      int totalAIInteractions = 0;
      for (final key in allKeys) {
        if (key.startsWith('ai_interactions_')) {
          final count = prefs.getInt(key) ?? 0;
          totalAIInteractions += count;
        }
      }

      // Calculate validation metrics
      int totalAttempts = 0;
      int totalSuccesses = 0;
      for (final key in allKeys) {
        if (key.startsWith('validation_attempts_')) {
          totalAttempts += prefs.getInt(key) ?? 0;
        }
        if (key.startsWith('validation_success_')) {
          totalSuccesses += prefs.getInt(key) ?? 0;
        }
      }

      final successRate = totalAttempts > 0 ? totalSuccesses / totalAttempts : 0.0;

      // Identify struggling stages (>3 attempts)
      final strugglingStages = <String>[];
      for (final key in allKeys) {
        if (key.startsWith('validation_attempts_')) {
          final attempts = prefs.getInt(key) ?? 0;
          if (attempts > 3) {
            final stageId = key.replaceFirst('validation_attempts_', '');
            strugglingStages.add(stageId);
          }
        }
      }

      // Calculate consecutive days active
      final lastActiveKey = 'last_active_$userId';
      final lastActiveStr = prefs.getString(lastActiveKey);
      final lastActive = lastActiveStr != null 
          ? DateTime.parse(lastActiveStr)
          : DateTime.now();
      
      final now = DateTime.now();
      final daysDiff = now.difference(lastActive).inDays;
      
      int consecutiveDays = 1;
      if (daysDiff == 0) {
        // Same day
        final streakKey = 'streak_$userId';
        consecutiveDays = prefs.getInt(streakKey) ?? 1;
      } else if (daysDiff == 1) {
        // Next day
        final streakKey = 'streak_$userId';
        consecutiveDays = (prefs.getInt(streakKey) ?? 0) + 1;
        await prefs.setInt(streakKey, consecutiveDays);
      } else {
        // Streak broken
        consecutiveDays = 1;
        await prefs.setInt('streak_$userId', 1);
      }

      // Update last active date
      await prefs.setString(lastActiveKey, now.toIso8601String());

      return LearningAnalytics(
        totalTimeSpentMinutes: totalTimeSpent,
        timePerStage: timePerStage,
        totalAIInteractions: totalAIInteractions,
        totalValidationAttempts: totalAttempts,
        validationSuccessRate: successRate,
        strugglingStages: strugglingStages,
        consecutiveDaysActive: consecutiveDays,
        lastActiveDate: now,
      );
    } catch (e) {
      print('Error calculating analytics: $e');
      return LearningAnalytics(
        totalTimeSpentMinutes: 0,
        totalAIInteractions: 0,
        totalValidationAttempts: 0,
        validationSuccessRate: 0.0,
        consecutiveDaysActive: 1,
        lastActiveDate: DateTime.now(),
      );
    }
  }

  /// Identify stages where user is struggling
  Future<List<String>> identifyStrugglingStages(
    String userId,
    String projectId,
  ) async {
    final analytics = await calculateAnalytics(userId, projectId);
    return analytics.strugglingStages;
  }

  /// Calculate success rate for a user
  Future<double> calculateSuccessRate(String userId, String projectId) async {
    final analytics = await calculateAnalytics(userId, projectId);
    return analytics.validationSuccessRate;
  }

  // ═══════════════════════════════════════════════════════════════════════════════════
  // REPORTING
  // ═══════════════════════════════════════════════════════════════════════════════════

  /// Generate learning report for atölye presentation
  Future<Map<String, dynamic>> generateLearningReport(
    String userId,
    String projectId,
  ) async {
    final analytics = await calculateAnalytics(userId, projectId);

    return {
      'userId': userId,
      'projectId': projectId,
      'generatedAt': DateTime.now().toIso8601String(),
      'totalTimeSpent': '${analytics.totalTimeSpentMinutes} dakika',
      'totalAIInteractions': analytics.totalAIInteractions,
      'validationSuccessRate': '${(analytics.validationSuccessRate * 100).toStringAsFixed(1)}%',
      'consecutiveDaysActive': analytics.consecutiveDaysActive,
      'strugglingStages': analytics.strugglingStages,
      'strengths': _identifyStrengths(analytics),
      'areasForImprovement': _identifyAreasForImprovement(analytics),
    };
  }

  List<String> _identifyStrengths(LearningAnalytics analytics) {
    final strengths = <String>[];

    if (analytics.validationSuccessRate >= 0.8) {
      strengths.add('Yüksek doğrulama başarı oranı');
    }

    if (analytics.consecutiveDaysActive >= 7) {
      strengths.add('Düzenli çalışma alışkanlığı');
    }

    if (analytics.totalAIInteractions < analytics.totalValidationAttempts * 2) {
      strengths.add('Bağımsız problem çözme becerisi');
    }

    return strengths;
  }

  List<String> _identifyAreasForImprovement(LearningAnalytics analytics) {
    final areas = <String>[];

    if (analytics.validationSuccessRate < 0.5) {
      areas.add('Doğrulama sorularında daha fazla pratik gerekli');
    }

    if (analytics.strugglingStages.isNotEmpty) {
      areas.add('Bazı aşamalarda ek destek alınabilir');
    }

    if (analytics.consecutiveDaysActive < 3) {
      areas.add('Daha düzenli çalışma programı oluşturulabilir');
    }

    return areas;
  }

  /// Alert mentor if user shows signs of disengagement
  Future<void> alertMentor(String userId, String reason) async {
    // This would send a notification to mentors
    // For now, just log it
    print('MENTOR ALERT: User $userId - $reason');
    
    // In production, this would:
    // 1. Send push notification to mentor
    // 2. Create a task in mentor dashboard
    // 3. Log the alert in analytics system
  }

  // ═══════════════════════════════════════════════════════════════════════════════════
  // UTILITY METHODS
  // ═══════════════════════════════════════════════════════════════════════════════════

  /// Clear all analytics data (useful for testing)
  Future<void> clearAnalytics() async {
    final prefs = await SharedPreferences.getInstance();
    final keys = prefs.getKeys();
    
    for (final key in keys) {
      if (key.startsWith('ai_interactions_') ||
          key.startsWith('validation_') ||
          key.startsWith('stage_time_') ||
          key.startsWith('stage_completion_') ||
          key.startsWith('last_active_') ||
          key.startsWith('streak_')) {
        await prefs.remove(key);
      }
    }
    
    _activeTimers.clear();
  }
}
