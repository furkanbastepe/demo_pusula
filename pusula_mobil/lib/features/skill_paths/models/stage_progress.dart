import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:pusula/features/skill_paths/models/validation_attempt.dart';

part 'stage_progress.freezed.dart';
part 'stage_progress.g.dart';

// ═══════════════════════════════════════════════════════════════════════════════════
// 📝 STAGE PROGRESS MODEL
// ═══════════════════════════════════════════════════════════════════════════════════

enum StageStatus {
  @JsonValue('locked')
  locked,
  @JsonValue('unlocked')
  unlocked,
  @JsonValue('in_progress')
  inProgress,
  @JsonValue('completed')
  completed,
}

@freezed
class StageProgress with _$StageProgress {
  const factory StageProgress({
    required String stageId,
    required StageStatus status,
    DateTime? startedAt,
    DateTime? completedAt,
    required int earnedXP,
    
    // Validation data
    @Default([]) List<ValidationAttempt> validationAttempts,
    @Default(false) bool validationPassed,
    
    // AI interaction
    @Default(0) int aiInteractionCount,
    @Default([]) List<String> aiConversationIds,
  }) = _StageProgress;

  factory StageProgress.fromJson(Map<String, dynamic> json) =>
      _$StageProgressFromJson(json);
}
