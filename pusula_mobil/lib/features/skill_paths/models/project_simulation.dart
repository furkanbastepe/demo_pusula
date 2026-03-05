import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:pusula/features/skill_paths/models/project_context.dart';
import 'package:pusula/features/skill_paths/models/project_module.dart';

part 'project_simulation.freezed.dart';
part 'project_simulation.g.dart';

// ═══════════════════════════════════════════════════════════════════════════════════
// 🎯 PROJECT SIMULATION MODEL - Proje Duolingo
// ═══════════════════════════════════════════════════════════════════════════════════

@freezed
class ProjectSimulation with _$ProjectSimulation {
  const ProjectSimulation._();

  const factory ProjectSimulation({
    required String id,
    required String title,
    required String skillPath, // Veri Analisti, Yazılım Geliştirici, etc.
    required String emoji,
    
    // Project Context
    required ProjectContext context,
    
    // Modules
    required List<ProjectModule> modules,
    
    // Metadata
    required int totalXP,
    required int estimatedHours,
    required String difficulty, // "Çırak", "Kalfa", "Usta"
    required List<String> learningOutcomes,
    required List<String> toolsUsed,
  }) = _ProjectSimulation;

  factory ProjectSimulation.fromJson(Map<String, dynamic> json) =>
      _$ProjectSimulationFromJson(json);

  int get totalModules => modules.length;
  
  int get totalStages => modules.fold(0, (sum, module) => sum + module.stages.length);
  
  double calculateProgress(List<String> completedStageIds) {
    if (totalStages == 0) return 0.0;
    final completed = modules
        .expand((module) => module.stages)
        .where((stage) => completedStageIds.contains(stage.id))
        .length;
    return completed / totalStages;
  }
}
