import 'package:freezed_annotation/freezed_annotation.dart';

part 'learning_analytics.freezed.dart';
part 'learning_analytics.g.dart';

// ═══════════════════════════════════════════════════════════════════════════════════
// 📈 LEARNING ANALYTICS MODEL
// ═══════════════════════════════════════════════════════════════════════════════════

@freezed
class LearningAnalytics with _$LearningAnalytics {
  const factory LearningAnalytics({
    required int totalTimeSpentMinutes,
    @Default({}) Map<String, int> timePerStage, // stageId → minutes
    required int totalAIInteractions,
    required int totalValidationAttempts,
    required double validationSuccessRate,
    @Default([]) List<String> strugglingStages, // Stages with >3 attempts
    required int consecutiveDaysActive,
    required DateTime lastActiveDate,
  }) = _LearningAnalytics;

  factory LearningAnalytics.fromJson(Map<String, dynamic> json) =>
      _$LearningAnalyticsFromJson(json);
}
