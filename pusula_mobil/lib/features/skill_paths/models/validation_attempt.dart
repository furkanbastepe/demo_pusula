import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:pusula/features/skill_paths/models/validation_answer.dart';

part 'validation_attempt.freezed.dart';
part 'validation_attempt.g.dart';

// ═══════════════════════════════════════════════════════════════════════════════════
// ✅ VALIDATION ATTEMPT MODEL
// ═══════════════════════════════════════════════════════════════════════════════════

@freezed
class ValidationAttempt with _$ValidationAttempt {
  const factory ValidationAttempt({
    required DateTime timestamp,
    required List<ValidationAnswer> answers,
    required bool passed,
    String? feedback,
  }) = _ValidationAttempt;

  factory ValidationAttempt.fromJson(Map<String, dynamic> json) =>
      _$ValidationAttemptFromJson(json);
}
