import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

import '../models/models.dart';
import 'projects_provider.dart';

/// Provider for managing project progress
final progressNotifierProvider =
    StateNotifierProvider<ProgressNotifier, Map<String, ProjectProgress>>(
  (ref) => ProgressNotifier(ref),
);

class ProgressNotifier extends StateNotifier<Map<String, ProjectProgress>> {
  final Ref ref;

  ProgressNotifier(this.ref) : super({}) {
    _loadProgress();
  }

  Future<void> _loadProgress() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final progressJson = prefs.getString('skill_paths_progress');
      if (progressJson != null) {
        final Map<String, dynamic> data = json.decode(progressJson);
        final progress = data.map(
          (key, value) => MapEntry(
            key,
            ProjectProgress.fromJson(value as Map<String, dynamic>),
          ),
        );
        state = progress;
      }
    } catch (e) {
      print('Error loading progress: $e');
    }
  }

  Future<void> _saveProgress() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final data = state.map((key, value) => MapEntry(key, value.toJson()));
      await prefs.setString('skill_paths_progress', json.encode(data));
    } catch (e) {
      print('Error saving progress: $e');
    }
  }

  /// Start a project
  Future<void> startProject(String projectId) async {
    if (state.containsKey(projectId)) return;

    final progress = ProjectProgress(
      userId: 'current_user', // TODO: Get from auth
      projectId: projectId,
      moduleProgress: {},
      currentModuleId: null,
      currentStageId: null,
      earnedXP: 0,
      totalStagesCompleted: 0,
      startedAt: DateTime.now(),
      completedAt: null,
      lastActivityAt: DateTime.now(),
      projectLink: null,
      projectDescription: null,
      submittedAt: null,
      atolyeSessionId: null,
      atolyeDate: null,
      atolyeCompleted: false,
      analytics: LearningAnalytics(
        totalTimeSpentMinutes: 0,
        timePerStage: {},
        totalAIInteractions: 0,
        totalValidationAttempts: 0,
        validationSuccessRate: 0.0,
        strugglingStages: [],
        consecutiveDaysActive: 1,
        lastActiveDate: DateTime.now(),
      ),
    );

    state = {...state, projectId: progress};
    await _saveProgress();
  }

  /// Start a stage
  Future<void> startStage(String projectId, String moduleId, String stageId) async {
    final progress = state[projectId];
    if (progress == null) return;

    final moduleProgress = progress.moduleProgress[moduleId] ?? ModuleProgress(
      moduleId: moduleId,
      stageProgress: {},
      isCompleted: false,
      completedAt: null,
      earnedXP: 0,
    );

    final stageProgress = StageProgress(
      stageId: stageId,
      status: StageStatus.inProgress,
      startedAt: DateTime.now(),
      completedAt: null,
      earnedXP: 0,
      validationAttempts: [],
      validationPassed: false,
      aiInteractionCount: 0,
      aiConversationIds: [],
    );

    final updatedModuleProgress = moduleProgress.copyWith(
      stageProgress: {...moduleProgress.stageProgress, stageId: stageProgress},
    );

    final updatedProgress = progress.copyWith(
      moduleProgress: {...progress.moduleProgress, moduleId: updatedModuleProgress},
      currentModuleId: moduleId,
      currentStageId: stageId,
      lastActivityAt: DateTime.now(),
    );

    state = {...state, projectId: updatedProgress};
    await _saveProgress();
  }

  /// Complete a stage
  Future<void> completeStage(
    String projectId,
    String moduleId,
    String stageId,
    int xpReward,
  ) async {
    final progress = state[projectId];
    if (progress == null) return;

    final moduleProgress = progress.moduleProgress[moduleId];
    if (moduleProgress == null) return;

    final stageProgress = moduleProgress.stageProgress[stageId];
    if (stageProgress == null) return;

    final updatedStageProgress = stageProgress.copyWith(
      status: StageStatus.completed,
      completedAt: DateTime.now(),
      earnedXP: xpReward,
      validationPassed: true,
    );

    final updatedModuleProgress = moduleProgress.copyWith(
      stageProgress: {
        ...moduleProgress.stageProgress,
        stageId: updatedStageProgress
      },
      earnedXP: moduleProgress.earnedXP + xpReward,
    );

    final updatedProgress = progress.copyWith(
      moduleProgress: {
        ...progress.moduleProgress,
        moduleId: updatedModuleProgress
      },
      earnedXP: progress.earnedXP + xpReward,
      totalStagesCompleted: progress.totalStagesCompleted + 1,
      lastActivityAt: DateTime.now(),
    );

    state = {...state, projectId: updatedProgress};
    await _saveProgress();

    // Check if module is complete
    await _checkModuleCompletion(projectId, moduleId);
  }

  /// Check if module is complete
  Future<void> _checkModuleCompletion(String projectId, String moduleId) async {
    final progress = state[projectId];
    if (progress == null) return;

    final moduleProgress = progress.moduleProgress[moduleId];
    if (moduleProgress == null) return;

    // Get module from project
    final projectAsync = ref.read(projectProvider(projectId));
    final project = projectAsync.value;
    if (project == null) return;

    final module = project.modules.firstWhere((m) => m.id == moduleId);
    final allStagesComplete = module.stages.every(
      (stage) =>
          moduleProgress.stageProgress[stage.id]?.status == StageStatus.completed,
    );

    if (allStagesComplete && !moduleProgress.isCompleted) {
      final updatedModuleProgress = moduleProgress.copyWith(
        isCompleted: true,
        completedAt: DateTime.now(),
      );

      final updatedProgress = progress.copyWith(
        moduleProgress: {
          ...progress.moduleProgress,
          moduleId: updatedModuleProgress
        },
      );

      state = {...state, projectId: updatedProgress};
      await _saveProgress();

      // Check if project is complete
      await _checkProjectCompletion(projectId);
    }
  }

  /// Check if project is complete
  Future<void> _checkProjectCompletion(String projectId) async {
    final progress = state[projectId];
    if (progress == null) return;

    final projectAsync = ref.read(projectProvider(projectId));
    final project = projectAsync.value;
    if (project == null) return;

    final allModulesComplete = project.modules.every(
      (module) => progress.moduleProgress[module.id]?.isCompleted == true,
    );

    if (allModulesComplete && progress.completedAt == null) {
      final updatedProgress = progress.copyWith(
        completedAt: DateTime.now(),
      );

      state = {...state, projectId: updatedProgress};
      await _saveProgress();
    }
  }

  /// Submit project
  Future<void> submitProject(
    String projectId,
    String link,
    String description,
  ) async {
    final progress = state[projectId];
    if (progress == null) return;

    final updatedProgress = progress.copyWith(
      projectLink: link,
      projectDescription: description,
      submittedAt: DateTime.now(),
    );

    state = {...state, projectId: updatedProgress};
    await _saveProgress();
  }

  /// Track AI interaction
  Future<void> trackAIInteraction(String projectId, String stageId) async {
    final progress = state[projectId];
    if (progress == null) return;

    final updatedAnalytics = progress.analytics.copyWith(
      totalAIInteractions: progress.analytics.totalAIInteractions + 1,
    );

    final updatedProgress = progress.copyWith(
      analytics: updatedAnalytics,
      lastActivityAt: DateTime.now(),
    );

    state = {...state, projectId: updatedProgress};
    await _saveProgress();
  }

  /// Get progress for a project
  ProjectProgress? getProgress(String projectId) {
    return state[projectId];
  }
}
