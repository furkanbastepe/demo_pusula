import 'package:freezed_annotation/freezed_annotation.dart';

part 'validation_answer.freezed.dart';
part 'validation_answer.g.dart';

// ═══════════════════════════════════════════════════════════════════════════════════
// 💬 VALIDATION ANSWER MODEL
// ═══════════════════════════════════════════════════════════════════════════════════

@freezed
class ValidationAnswer with _$ValidationAnswer {
  const factory ValidationAnswer({
    required String question,
    required String userAnswer,
    required bool isCorrect,
    String? hint,
  }) = _ValidationAnswer;

  factory ValidationAnswer.fromJson(Map<String, dynamic> json) =>
      _$ValidationAnswerFromJson(json);
}
