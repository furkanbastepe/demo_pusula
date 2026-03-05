// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'project_module.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$ProjectModuleImpl _$$ProjectModuleImplFromJson(Map<String, dynamic> json) =>
    _$ProjectModuleImpl(
      id: json['id'] as String,
      order: (json['order'] as num).toInt(),
      title: json['title'] as String,
      description: json['description'] as String,
      stages: (json['stages'] as List<dynamic>)
          .map((e) => LearningStage.fromJson(e as Map<String, dynamic>))
          .toList(),
      xpReward: (json['xpReward'] as num).toInt(),
      estimatedMinutes: (json['estimatedMinutes'] as num).toInt(),
    );

Map<String, dynamic> _$$ProjectModuleImplToJson(_$ProjectModuleImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'order': instance.order,
      'title': instance.title,
      'description': instance.description,
      'stages': instance.stages,
      'xpReward': instance.xpReward,
      'estimatedMinutes': instance.estimatedMinutes,
    };
