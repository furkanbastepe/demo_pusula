import 'package:flutter/material.dart';
import '../../features/ai_assistant/screens/ai_chat_screen.dart';

// ═══════════════════════════════════════════════════════════════════════════════════
// 🧭 NAVIGATION UTILITIES
// ═══════════════════════════════════════════════════════════════════════════════════

/// Opens the AI chat screen as a fullscreen modal dialog.
/// 
/// This helper function provides a consistent way to open the AI chat
/// from anywhere in the app with proper context injection.
/// 
/// Parameters:
/// - [context]: BuildContext for navigation
/// - [lessonContext]: Optional lesson content for context-aware help
/// - [simulationId]: Optional simulation ID for project context
/// - [taskId]: Optional task ID for specific task help
/// - [projectName]: Optional project name for display
/// - [taskName]: Optional task name for display
void openAIChat(
  BuildContext context, {
  String? lessonContext,
  String? simulationId,
  String? taskId,
  String? projectName,
  String? taskName,
}) {
  Navigator.of(context).push(
    MaterialPageRoute(
      builder: (context) => AIChatScreen(
        lessonContext: lessonContext,
        simulationId: simulationId,
        taskId: taskId,
        projectName: projectName,
        taskName: taskName,
      ),
      fullscreenDialog: true, // Better UX for modal presentation
    ),
  );
}
