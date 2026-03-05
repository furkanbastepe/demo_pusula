import 'package:freezed_annotation/freezed_annotation.dart';

part 'validation_question.freezed.dart';
part 'validation_question.g.dart';

// ═══════════════════════════════════════════════════════════════════════════════════
// ❓ VALIDATION QUESTION MODEL
// ═══════════════════════════════════════════════════════════════════════════════════

@freezed
class ValidationQuestion with _$ValidationQuestion {
  const factory ValidationQuestion({
    required String question,
    required String expectedKeywords, // Keywords AI should look for
    required String hint, // Hint if answer is wrong
  }) = _ValidationQuestion;

  factory ValidationQuestion.fromJson(Map<String, dynamic> json) =>
      _$ValidationQuestionFromJson(json);
}
