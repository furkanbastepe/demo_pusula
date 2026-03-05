import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:pusula/features/skill_paths/models/stage_content.dart';

part 'learning_stage.freezed.dart';
part 'learning_stage.g.dart';

// ═══════════════════════════════════════════════════════════════════════════════════
// 📚 LEARNING STAGE MODEL
// ═══════════════════════════════════════════════════════════════════════════════════

enum StageType {
  @JsonValue('learn')
  learn,
  @JsonValue('apply')
  apply,
}

@freezed
class LearningStage with _$LearningStage {
  const factory LearningStage({
    required String id,
    required int order,
    required StageType type, // "learn" or "apply"
    required String title,
    required StageContent content,
    required int xpReward,
    required int estimatedMinutes,
  }) = _LearningStage;

  factory LearningStage.fromJson(Map<String, dynamic> json) =>
      _$LearningStageFromJson(json);
}
