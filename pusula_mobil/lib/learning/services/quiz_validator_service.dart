import '../models/models.dart';

// ═══════════════════════════════════════════════════════════════════════════════════
// ✅ QUIZ VALIDATOR SERVICE - V2.1 Simplified (No code execution)
// ═══════════════════════════════════════════════════════════════════════════════════

class QuizValidatorService {
  bool validateAnswer(int selectedIndex, int correctIndex) {
    return selectedIndex == correctIndex;
  }

  QuizResult checkQuizAnswer(QuizData quiz, int selectedIndex) {
    final isCorrect = validateAnswer(selectedIndex, quiz.correctAnswerIndex);
    return QuizResult(
      isCorrect: isCorrect,
      explanation: quiz.explanation,
      xpEarned: isCorrect ? quiz.xpReward : 0,
    );
  }

  QuizResult checkCodeChallengeAnswer(
    CodeChallengeData challenge,
    int selectedIndex,
  ) {
    final isCorrect = validateAnswer(selectedIndex, challenge.correctAnswerIndex);
    return QuizResult(
      isCorrect: isCorrect,
      explanation: isCorrect ? challenge.explanation : challenge.detailedSolution,
      xpEarned: isCorrect ? challenge.xpReward : 0,
    );
  }
}

class QuizResult {
  final bool isCorrect;
  final String explanation;
  final int xpEarned;

  QuizResult({
    required this.isCorrect,
    required this.explanation,
    required this.xpEarned,
  });
}
