import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:pusula/features/skill_paths/models/project_context.dart';
import 'package:pusula/features/skill_paths/models/learning_stage.dart';
import 'package:pusula/features/skill_paths/models/stage_content.dart';
import 'package:pusula/features/skill_paths/models/learning_analytics.dart';
import 'package:pusula/features/ai_assistant/models/chat_message.dart';

part 'ai_coach_context.freezed.dart';
part 'ai_coach_context.g.dart';

// ═══════════════════════════════════════════════════════════════════════════════════
// 🤖 AI COACH CONTEXT MODEL
// ═══════════════════════════════════════════════════════════════════════════════════

enum CoachingMode {
  @JsonValue('guidance')
  guidance,    // Step-by-step help
  @JsonValue('questioning')
  questioning, // Socratic questioning
  @JsonValue('hinting')
  hinting,     // Subtle hints
  @JsonValue('validation')
  validation,  // Check understanding
}

@freezed
class AICoachContext with _$AICoachContext {
  const AICoachContext._();

  const factory AICoachContext({
    // Project Context
    required String projectId,
    required String projectTitle,
    required ProjectContext projectContext,
    
    // Current Position
    required String currentModuleId,
    required String currentStageId,
    required StageType stageType,
    required StageContent stageContent,
    
    // User Progress
    @Default([]) List<String> completedStages,
    required LearningAnalytics analytics,
    
    // Conversation History
    List<ChatMessage>? previousMessages,
    
    // Coaching Mode
    required CoachingMode mode,
  }) = _AICoachContext;

  factory AICoachContext.fromJson(Map<String, dynamic> json) =>
      _$AICoachContextFromJson(json);
  
  // Generate system prompt for AI
  String toSystemPrompt() {
    final stageTypeStr = stageType == StageType.learn ? 'Learn (Theory)' : 'Apply (Practice)';
    final taskDescription = stageContent.maybeWhen(
      apply: (task, _, __, ___, ____, _____, ______) => '- Task: $task',
      orElse: () => '',
    );
    
    return '''
You are an AI Coach for PUSULA's project-based learning system.

PROJECT CONTEXT:
- Project: $projectTitle
- Company: ${projectContext.companyName} (${projectContext.companyType})
- Goal: ${projectContext.projectGoal}
- Scenario: ${projectContext.scenario}

CURRENT STAGE:
- Type: $stageTypeStr
- Stage: $currentStageId
$taskDescription

USER PROGRESS:
- Completed stages: ${completedStages.length}
- AI interactions: ${analytics.totalAIInteractions}
- Validation success rate: ${(analytics.validationSuccessRate * 100).toStringAsFixed(0)}%

COACHING MODE: ${mode.name}

COACHING PRINCIPLES:
1. Be proactive: Ask questions before giving answers
2. Use Socratic method: Guide learner to discover solutions
3. Be encouraging: Celebrate progress, motivate through challenges
4. Be context-aware: Reference the project scenario in responses
5. Detect copying: If answers seem copied, ask follow-up questions
6. Adapt difficulty: Based on user's success rate and interactions
7. Provide hints, not solutions: Help learner think, don't do the work
8. Validate understanding: Ask "why" and "how" questions

LANGUAGE: Always respond in Turkish, use simple and clear language.
''';
  }
}
