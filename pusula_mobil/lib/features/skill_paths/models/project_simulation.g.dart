// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'project_simulation.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$ProjectSimulationImpl _$$ProjectSimulationImplFromJson(
  Map<String, dynamic> json,
) => _$ProjectSimulationImpl(
  id: json['id'] as String,
  title: json['title'] as String,
  skillPath: json['skillPath'] as String,
  emoji: json['emoji'] as String,
  context: ProjectContext.fromJson(json['context'] as Map<String, dynamic>),
  modules: (json['modules'] as List<dynamic>)
      .map((e) => ProjectModule.fromJson(e as Map<String, dynamic>))
      .toList(),
  totalXP: (json['totalXP'] as num).toInt(),
  estimatedHours: (json['estimatedHours'] as num).toInt(),
  difficulty: json['difficulty'] as String,
  learningOutcomes: (json['learningOutcomes'] as List<dynamic>)
      .map((e) => e as String)
      .toList(),
  toolsUsed: (json['toolsUsed'] as List<dynamic>)
      .map((e) => e as String)
      .toList(),
);

Map<String, dynamic> _$$ProjectSimulationImplToJson(
  _$ProjectSimulationImpl instance,
) => <String, dynamic>{
  'id': instance.id,
  'title': instance.title,
  'skillPath': instance.skillPath,
  'emoji': instance.emoji,
  'context': instance.context,
  'modules': instance.modules,
  'totalXP': instance.totalXP,
  'estimatedHours': instance.estimatedHours,
  'difficulty': instance.difficulty,
  'learningOutcomes': instance.learningOutcomes,
  'toolsUsed': instance.toolsUsed,
};
