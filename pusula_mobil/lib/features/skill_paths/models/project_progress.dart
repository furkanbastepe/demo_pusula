import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:pusula/features/skill_paths/models/module_progress.dart';
import 'package:pusula/features/skill_paths/models/learning_analytics.dart';

part 'project_progress.freezed.dart';
part 'project_progress.g.dart';

// ═══════════════════════════════════════════════════════════════════════════════════
// 📊 PROJECT PROGRESS MODEL
// ═══════════════════════════════════════════════════════════════════════════════════

@freezed
class ProjectProgress with _$ProjectProgress {
  const ProjectProgress._();

  const factory ProjectProgress({
    required String userId,
    required String projectId,
    
    // Module Progress
    @Default({}) Map<String, ModuleProgress> moduleProgress, // moduleId → progress
    String? currentModuleId,
    String? currentStageId,
    
    // Overall Progress
    required int earnedXP,
    required int totalStagesCompleted,
    required DateTime startedAt,
    DateTime? completedAt,
    DateTime? lastActivityAt,
    
    // Project Submission
    String? projectLink,
    String? projectDescription,
    DateTime? submittedAt,
    
    // Atölye
    String? atolyeSessionId,
    DateTime? atolyeDate,
    @Default(false) bool atolyeCompleted,
    
    // Analytics
    required LearningAnalytics analytics,
  }) = _ProjectProgress;

  factory ProjectProgress.fromJson(Map<String, dynamic> json) =>
      _$ProjectProgressFromJson(json);

  bool get isCompleted => completedAt != null;
  
  bool get isSubmitted => projectLink != null && submittedAt != null;
  
  bool get isReadyForAtolye => isCompleted && isSubmitted;
  
  /// Calculate overall progress percentage (0-100)
  double get overallProgress {
    if (moduleProgress.isEmpty) return 0.0;
    
    // Calculate average progress across all modules
    double totalProgress = 0.0;
    for (final module in moduleProgress.values) {
      totalProgress += module.progressPercentage;
    }
    
    return totalProgress / moduleProgress.length;
  }
  
  double calculateOverallProgress(int totalStages) {
    if (totalStages == 0) return 0.0;
    return totalStagesCompleted / totalStages;
  }
}
