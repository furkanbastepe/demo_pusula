import 'package:freezed_annotation/freezed_annotation.dart';

part 'project_context.freezed.dart';
part 'project_context.g.dart';

// ═══════════════════════════════════════════════════════════════════════════════════
// 🏢 PROJECT CONTEXT MODEL
// ═══════════════════════════════════════════════════════════════════════════════════

@freezed
class ProjectContext with _$ProjectContext {
  const factory ProjectContext({
    required String companyName,
    required String companyType,
    required String industry,
    required String projectGoal,
    required String targetAudience,
    required String scenario,
    required List<String> deliverables,
  }) = _ProjectContext;

  factory ProjectContext.fromJson(Map<String, dynamic> json) =>
      _$ProjectContextFromJson(json);
}
