import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../models/project_simulation.dart';
import '../models/project_progress.dart';
import '../services/project_service.dart';
import 'progress_provider.dart';

/// Provider for ProjectService
final projectServiceProvider = Provider<ProjectService>((ref) {
  return ProjectService();
});

/// Provider for all projects
final projectsProvider = FutureProvider<List<ProjectSimulation>>((ref) async {
  final service = ref.watch(projectServiceProvider);
  return service.getProjects();
});

/// Provider for a specific project by ID
final projectProvider = FutureProvider.family<ProjectSimulation?, String>(
  (ref, projectId) async {
    final service = ref.watch(projectServiceProvider);
    return service.getProjectById(projectId);
  },
);

/// Provider for project progress by project ID
final projectProgressProvider = FutureProvider.family<ProjectProgress?, String>(
  (ref, projectId) async {
    // Get from progress notifier instead of service
    final progressNotifier = ref.watch(progressNotifierProvider.notifier);
    return progressNotifier.getProgress(projectId);
  },
);

/// Provider for current project (selected project)
final currentProjectProvider = StateProvider<String?>((ref) => null);

/// Provider for current module within a project
final currentModuleProvider = StateProvider<String?>((ref) => null);

/// Provider for current stage within a module
final currentStageProvider = StateProvider<String?>((ref) => null);
