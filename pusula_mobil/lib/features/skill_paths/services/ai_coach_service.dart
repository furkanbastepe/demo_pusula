import 'package:pusula/features/ai_assistant/services/gemini_service.dart';
import 'package:pusula/features/skill_paths/models/models.dart';
import 'package:pusula/features/skill_paths/services/project_service.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

// ═══════════════════════════════════════════════════════════════════════════════════
// 🤖 AI COACH SERVICE
// ═══════════════════════════════════════════════════════════════════════════════════

class ValidationResult {
  final bool passed;
  final String feedback;
  final List<ValidationAnswer> answers;
  final String? hint;

  ValidationResult({
    required this.passed,
    required this.feedback,
    required this.answers,
    this.hint,
  });
}

class AICoachService {
  final GeminiService _geminiService;
  final ProjectService _projectService;

  AICoachService(this._geminiService, this._projectService);

  // ═══════════════════════════════════════════════════════════════════════════════════
  // CONTEXT MANAGEMENT
  // ═══════════════════════════════════════════════════════════════════════════════════

  /// Build complete AI context for a stage
  Future<AICoachContext> buildContext({
    required String projectId,
    required String stageId,
    required String userId,
  }) async {
    try {
      // Load project
      final project = await _projectService.getProjectById(projectId);
      
      // Find module and stage
      ProjectModule? module;
      LearningStage? stage;
      
      for (final m in project.modules) {
        final s = m.stages.firstWhere(
          (s) => s.id == stageId,
          orElse: () => throw Exception('Stage not found'),
        );
        if (s.id == stageId) {
          module = m;
          stage = s;
          break;
        }
      }
      
      if (module == null || stage == null) {
        throw Exception('Module or stage not found');
      }

      // Load progress
      final progress = await _projectService.getProgress(userId, projectId);
      
      // Get completed stages
      final completedStages = progress.moduleProgress.values
          .expand((mp) => mp.stageProgress.entries)
          .where((entry) => entry.value.status == StageStatus.completed)
          .map((entry) => entry.key)
          .toList();

      // Determine coaching mode based on analytics
      final mode = determineCoachingMode(progress.analytics);

      return AICoachContext(
        projectId: projectId,
        projectTitle: project.title,
        projectContext: project.context,
        currentModuleId: module.id,
        currentStageId: stageId,
        stageType: stage.type,
        stageContent: stage.content,
        completedStages: completedStages,
        analytics: progress.analytics,
        mode: mode,
      );
    } catch (e) {
      throw Exception('Failed to build AI context: $e');
    }
  }

  // ═══════════════════════════════════════════════════════════════════════════════════
  // COACHING INTERACTIONS
  // ═══════════════════════════════════════════════════════════════════════════════════

  /// Chat with AI coach
  Future<String> chat({
    required AICoachContext context,
    required String userMessage,
    required CoachingMode mode,
  }) async {
    try {
      final systemPrompt = context.toSystemPrompt();
      final response = await _geminiService.sendMessageWithProjectContext(
        userMessage,
        systemPrompt,
      );
      return response;
    } catch (e) {
      return 'Üzgünüm, şu anda cevap veremiyorum. Lütfen tekrar dene.';
    }
  }

  // ═══════════════════════════════════════════════════════════════════════════════════
  // VALIDATION
  // ═══════════════════════════════════════════════════════════════════════════════════

  /// Get validation questions for a stage
  Future<List<ValidationQuestion>> getValidationQuestions(String stageId) async {
    // This will be called from the stage content
    // For now, return empty list
    return [];
  }

  /// Ask a validation question
  Future<String> askValidationQuestion({
    required ValidationQuestion question,
    required AICoachContext context,
  }) async {
    try {
      final systemPrompt = context.toSystemPrompt();
      final prompt = '''
$systemPrompt

Şimdi kullanıcıya şu doğrulama sorusunu sor:

${question.question}

Soruyu samimi ve cesaretlendirici bir şekilde sor. Kullanıcının yaptığı işi anladığını kontrol etmek istediğini belirt.
''';

      final response = await _geminiService.sendMessageWithProjectContext(
        prompt,
        systemPrompt,
      );
      return response;
    } catch (e) {
      return question.question; // Fallback to direct question
    }
  }

  /// Evaluate user's answer to a validation question
  Future<bool> evaluateAnswer({
    required String question,
    required String userAnswer,
    required String expectedKeywords,
    required AICoachContext context,
  }) async {
    try {
      final systemPrompt = context.toSystemPrompt();
      final prompt = '''
$systemPrompt

DOĞRULAMA GÖREVİ:

Soru: $question
Kullanıcının Cevabı: $userAnswer
Beklenen Anahtar Kelimeler: $expectedKeywords

Kullanıcının cevabını değerlendir:
1. Anahtar kelimeleri kullanmış mı?
2. Konuyu gerçekten anlamış mı?
3. Cevap kopyalanmış gibi mi yoksa kendi cümleleriyle mi?
4. Açıklama yeterli mi?

Sadece "DOĞRU" veya "YANLIŞ" yaz. Başka bir şey yazma.
''';

      final response = await _geminiService.sendMessageWithProjectContext(
        prompt,
        systemPrompt,
      );

      // Check if response contains "DOĞRU" or "YANLIŞ"
      final normalized = response.toUpperCase().trim();
      if (normalized.contains('DOĞRU')) {
        return true;
      } else if (normalized.contains('YANLIŞ')) {
        return false;
      }

      // Fallback: Check for keywords in user answer
      final keywords = expectedKeywords.toLowerCase().split(',');
      final answerLower = userAnswer.toLowerCase();
      final keywordCount = keywords.where((k) => answerLower.contains(k.trim())).length;
      
      return keywordCount >= (keywords.length * 0.5); // At least 50% of keywords
    } catch (e) {
      // Fallback: Simple keyword matching
      final keywords = expectedKeywords.toLowerCase().split(',');
      final answerLower = userAnswer.toLowerCase();
      final keywordCount = keywords.where((k) => answerLower.contains(k.trim())).length;
      
      return keywordCount >= (keywords.length * 0.5);
    }
  }

  /// Validate entire stage
  Future<ValidationResult> validateStage({
    required AICoachContext context,
    required List<ValidationAnswer> answers,
  }) async {
    try {
      // Check if all answers are correct
      final allCorrect = answers.every((a) => a.isCorrect);

      if (allCorrect) {
        final feedback = await provideFeedback(
          passed: true,
          answers: answers,
          context: context,
        );
        return ValidationResult(
          passed: true,
          feedback: feedback,
          answers: answers,
        );
      } else {
        final feedback = await provideFeedback(
          passed: false,
          answers: answers,
          context: context,
        );
        
        // Find first incorrect answer for hint
        final incorrectAnswer = answers.firstWhere((a) => !a.isCorrect);
        
        return ValidationResult(
          passed: false,
          feedback: feedback,
          answers: answers,
          hint: incorrectAnswer.hint,
        );
      }
    } catch (e) {
      return ValidationResult(
        passed: false,
        feedback: 'Doğrulama sırasında bir hata oluştu. Lütfen tekrar dene.',
        answers: answers,
      );
    }
  }

  /// Provide feedback after validation
  Future<String> provideFeedback({
    required bool passed,
    required List<ValidationAnswer> answers,
    required AICoachContext context,
  }) async {
    try {
      final systemPrompt = context.toSystemPrompt();
      
      if (passed) {
        final prompt = '''
$systemPrompt

Kullanıcı tüm doğrulama sorularını doğru cevapladı! 🎉

Kısa ve cesaretlendirici bir kutlama mesajı yaz (2-3 cümle).
''';

        final response = await _geminiService.sendMessageWithProjectContext(
          prompt,
          systemPrompt,
        );
        return response;
      } else {
        final incorrectCount = answers.where((a) => !a.isCorrect).length;
        final prompt = '''
$systemPrompt

Kullanıcı $incorrectCount soruyu yanlış cevapladı.

Yanlış cevaplanan sorular:
${answers.where((a) => !a.isCorrect).map((a) => '- ${a.question}').join('\n')}

Cesaretlendirici ve yapıcı bir geri bildirim ver (2-3 cümle). Tekrar denemesini öner.
''';

        final response = await _geminiService.sendMessageWithProjectContext(
          prompt,
          systemPrompt,
        );
        return response;
      }
    } catch (e) {
      if (passed) {
        return 'Harika! Tüm soruları doğru cevapladın! 🎉 Sonraki aşamaya geçebilirsin.';
      } else {
        return 'Henüz tam değil. Bazı soruları tekrar gözden geçir ve tekrar dene!';
      }
    }
  }

  // ═══════════════════════════════════════════════════════════════════════════════════
  // ADAPTIVE COACHING
  // ═══════════════════════════════════════════════════════════════════════════════════

  /// Determine coaching mode based on analytics
  CoachingMode determineCoachingMode(LearningAnalytics analytics) {
    // If success rate is low, use more guidance
    if (analytics.validationSuccessRate < 0.5) {
      return CoachingMode.guidance;
    }
    
    // If success rate is medium, use questioning
    if (analytics.validationSuccessRate < 0.8) {
      return CoachingMode.questioning;
    }
    
    // If success rate is high, use hints only
    return CoachingMode.hinting;
  }

  // ═══════════════════════════════════════════════════════════════════════════════════
  // CONVERSATION MANAGEMENT
  // ═══════════════════════════════════════════════════════════════════════════════════

  /// Save conversation for a stage
  Future<void> saveConversation(
    String stageId,
    List<Map<String, dynamic>> messages,
  ) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final key = 'conversation_$stageId';
      final jsonString = jsonEncode(messages);
      await prefs.setString(key, jsonString);
    } catch (e) {
      print('Error saving conversation: $e');
    }
  }

  /// Get conversation for a stage
  Future<List<Map<String, dynamic>>> getConversation(String stageId) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final key = 'conversation_$stageId';
      final jsonString = prefs.getString(key);
      
      if (jsonString == null) return [];
      
      final list = jsonDecode(jsonString) as List;
      return list.cast<Map<String, dynamic>>();
    } catch (e) {
      print('Error loading conversation: $e');
      return [];
    }
  }
}
