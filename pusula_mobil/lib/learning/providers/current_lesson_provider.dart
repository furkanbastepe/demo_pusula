import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/models.dart';
import '../services/services.dart';

// ═══════════════════════════════════════════════════════════════════════════════════
// 📖 CURRENT LESSON PROVIDER
// ═══════════════════════════════════════════════════════════════════════════════════

final currentLessonProvider = StateProvider<Lesson?>((ref) => null);

final currentSectionIndexProvider = StateProvider<int>((ref) => 0);

final quizValidatorServiceProvider = Provider((ref) {
  return QuizValidatorService();
});
