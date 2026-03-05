import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:pusula/features/skill_paths/models/models.dart';

// ═══════════════════════════════════════════════════════════════════════════════════
// 🎯 PROJECT SERVICE
// ═══════════════════════════════════════════════════════════════════════════════════

class ProjectService {
  // Singleton pattern
  static final ProjectService _instance = ProjectService._internal();
  factory ProjectService() => _instance;
  ProjectService._internal();

  // In-memory cache
  final Map<String, ProjectSimulation> _projectCache = {};
  List<ProjectSimulation>? _allProjects;

  // ═══════════════════════════════════════════════════════════════════════════════════
  // PROJECT MANAGEMENT
  // ═══════════════════════════════════════════════════════════════════════════════════

  /// Load all projects from assets
  Future<List<ProjectSimulation>> getProjects() async {
    if (_allProjects != null) return _allProjects!;

    try {
      final projectIds = [
        'data-analyst-restaurant',
        'software-dev-todo-app',
        'digital-marketing-campaign',
        'ai-sentiment-analysis',
        'digital-designer-menu',
        'ecommerce-handcrafts-store',
      ];

      final projects = <ProjectSimulation>[];
      for (final id in projectIds) {
        try {
          final project = await getProjectById(id);
          projects.add(project);
        } catch (e) {
          print('Error loading project $id: $e');
          // Continue loading other projects
        }
      }

      _allProjects = projects;
      return projects;
    } catch (e) {
      print('Error loading projects: $e');
      return [];
    }
  }

  /// Load a specific project by ID
  Future<ProjectSimulation> getProjectById(String id) async {
    // Check cache first
    if (_projectCache.containsKey(id)) {
      return _projectCache[id]!;
    }

    try {
      final jsonString = await rootBundle.loadString(
        'assets/projects/$id.json',
      );
      final json = jsonDecode(jsonString) as Map<String, dynamic>;
      final project = ProjectSimulation.fromJson(json);

      // Cache the project
      _projectCache[id] = project;

      return project;
    } catch (e) {
      throw Exception('Failed to load project $id: $e');
    }
  }

  /// Get a specific module from a project
  Future<ProjectModule> getModule(String projectId, String moduleId) async {
    final project = await getProjectById(projectId);
    final module = project.modules.firstWhere(
      (m) => m.id == moduleId,
      orElse: () => throw Exception('Module $moduleId not found'),
    );
    return module;
  }

  /// Get a specific stage from a project
  Future<LearningStage> getStage(
    String projectId,
    String moduleId,
    String stageId,
  ) async {
    final module = await getModule(projectId, moduleId);
    final stage = module.stages.firstWhere(
      (s) => s.id == stageId,
      orElse: () => throw Exception('Stage $stageId not found'),
    );
    return stage;
  }

  // ═══════════════════════════════════════════════════════════════════════════════════
  // PROGRESS MANAGEMENT
  // ═══════════════════════════════════════════════════════════════════════════════════

  /// Get user's progress for a project (returns null if not started)
  Future<ProjectProgress?> getProjectProgress(String projectId) async {
    // For now, use a default user ID
    // In production, this would come from auth
    const userId = 'default_user';
    
    final prefs = await SharedPreferences.getInstance();
    final key = 'project_progress_${userId}_$projectId';
    final jsonString = prefs.getString(key);

    if (jsonString == null) {
      return null; // Project not started
    }

    try {
      final json = jsonDecode(jsonString) as Map<String, dynamic>;
      return ProjectProgress.fromJson(json);
    } catch (e) {
      print('Error parsing progress: $e');
      return null;
    }
  }

  /// Get user's progress for a project
  Future<ProjectProgress> getProgress(String userId, String projectId) async {
    final prefs = await SharedPreferences.getInstance();
    final key = 'project_progress_${userId}_$projectId';
    final jsonString = prefs.getString(key);

    if (jsonString == null) {
      // Create new progress
      return ProjectProgress(
        userId: userId,
        projectId: projectId,
        earnedXP: 0,
        totalStagesCompleted: 0,
        startedAt: DateTime.now(),
        analytics: LearningAnalytics(
          totalTimeSpentMinutes: 0,
          totalAIInteractions: 0,
          totalValidationAttempts: 0,
          validationSuccessRate: 0.0,
          consecutiveDaysActive: 1,
          lastActiveDate: DateTime.now(),
        ),
      );
    }

    try {
      final json = jsonDecode(jsonString) as Map<String, dynamic>;
      return ProjectProgress.fromJson(json);
    } catch (e) {
      print('Error parsing progress: $e');
      // Return new progress if parsing fails
      return ProjectProgress(
        userId: userId,
        projectId: projectId,
        earnedXP: 0,
        totalStagesCompleted: 0,
        startedAt: DateTime.now(),
        analytics: LearningAnalytics(
          totalTimeSpentMinutes: 0,
          totalAIInteractions: 0,
          totalValidationAttempts: 0,
          validationSuccessRate: 0.0,
          consecutiveDaysActive: 1,
          lastActiveDate: DateTime.now(),
        ),
      );
    }
  }

  // Note: Progress saving is handled by ProgressProvider
  // This method was removed to avoid duplication

  /// Start a stage
  Future<void> startStage(String projectId, String stageId) async {
    // This will be implemented with Riverpod state management
    // For now, just a placeholder
  }

  /// Complete a stage
  Future<void> completeStage(
    String projectId,
    String stageId,
    int xp,
  ) async {
    // This will be implemented with Riverpod state management
    // For now, just a placeholder
  }

  /// Complete a module
  Future<void> completeModule(String projectId, String moduleId) async {
    // This will be implemented with Riverpod state management
    // For now, just a placeholder
  }

  /// Submit project
  Future<void> submitProject(
    String projectId,
    String link,
    String description,
  ) async {
    // This will be implemented with Riverpod state management
    // For now, just a placeholder
  }

  // ═══════════════════════════════════════════════════════════════════════════════════
  // ANALYTICS
  // ═══════════════════════════════════════════════════════════════════════════════════

  /// Track time spent on a stage
  Future<void> trackTimeSpent(String stageId, int minutes) async {
    // This will be implemented with AnalyticsService
  }

  /// Track AI interaction
  Future<void> trackAIInteraction(String stageId) async {
    // This will be implemented with AnalyticsService
  }

  /// Track validation attempt
  Future<void> trackValidationAttempt(
    String stageId,
    ValidationAttempt attempt,
  ) async {
    // This will be implemented with AnalyticsService
  }

  // ═══════════════════════════════════════════════════════════════════════════════════
  // UTILITY METHODS
  // ═══════════════════════════════════════════════════════════════════════════════════

  /// Clear cache (useful for testing)
  void clearCache() {
    _projectCache.clear();
    _allProjects = null;
  }
}
