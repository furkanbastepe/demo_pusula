import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:pusula/features/skill_paths/models/stage_progress.dart';

part 'module_progress.freezed.dart';
part 'module_progress.g.dart';

// ═══════════════════════════════════════════════════════════════════════════════════
// 📦 MODULE PROGRESS MODEL
// ═══════════════════════════════════════════════════════════════════════════════════

@freezed
class ModuleProgress with _$ModuleProgress {
  const ModuleProgress._();

  const factory ModuleProgress({
    required String moduleId,
    @Default({}) Map<String, StageProgress> stageProgress, // stageId → progress
    @Default(false) bool isCompleted,
    DateTime? completedAt,
    required int earnedXP,
  }) = _ModuleProgress;

  factory ModuleProgress.fromJson(Map<String, dynamic> json) =>
      _$ModuleProgressFromJson(json);

  int get completedStagesCount => stageProgress.values
      .where((progress) => progress.status == StageStatus.completed)
      .length;
  
  /// Calculate progress percentage (0-100)
  double get progressPercentage {
    if (stageProgress.isEmpty) return 0.0;
    return (completedStagesCount / stageProgress.length) * 100;
  }
}
