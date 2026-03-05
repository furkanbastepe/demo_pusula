import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:pusula/features/skill_paths/models/learning_stage.dart';

part 'project_module.freezed.dart';
part 'project_module.g.dart';

// ═══════════════════════════════════════════════════════════════════════════════════
// 📦 PROJECT MODULE MODEL
// ═══════════════════════════════════════════════════════════════════════════════════

@freezed
class ProjectModule with _$ProjectModule {
  const ProjectModule._();

  const factory ProjectModule({
    required String id,
    required int order,
    required String title,
    required String description,
    required List<LearningStage> stages,
    required int xpReward,
    required int estimatedMinutes,
  }) = _ProjectModule;

  factory ProjectModule.fromJson(Map<String, dynamic> json) =>
      _$ProjectModuleFromJson(json);

  int get totalStages => stages.length;
  
  double calculateProgress(List<String> completedStageIds) {
    if (stages.isEmpty) return 0.0;
    final completed = stages.where((stage) => completedStageIds.contains(stage.id)).length;
    return completed / stages.length;
  }
}
