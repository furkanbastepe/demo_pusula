import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:pusula/features/skill_paths/models/validation_question.dart';

part 'stage_content.freezed.dart';
part 'stage_content.g.dart';

// ═══════════════════════════════════════════════════════════════════════════════════
// 📝 STAGE CONTENT MODEL - Union Type
// ═══════════════════════════════════════════════════════════════════════════════════

@Freezed(unionKey: 'type', unionValueCase: FreezedUnionCase.snake)
class StageContent with _$StageContent {
  // Learn stage content
  const factory StageContent.learn({
    required String concept,
    required String definition,
    required String whyImportant,
    required String howItWorks,
    required List<String> examples,
    String? visualAid,
  }) = LearnContent;

  // Apply stage content
  const factory StageContent.apply({
    required String task,
    required String deliverable,
    required List<String> steps,
    required List<String> tools,
    required String exampleOutput,
    required List<String> commonMistakes,
    required List<ValidationQuestion> validationQuestions,
  }) = ApplyContent;

  factory StageContent.fromJson(Map<String, dynamic> json) =>
      _$StageContentFromJson(json);
}
