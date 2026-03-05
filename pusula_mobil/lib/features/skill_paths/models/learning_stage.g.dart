// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'learning_stage.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$LearningStageImpl _$$LearningStageImplFromJson(Map<String, dynamic> json) =>
    _$LearningStageImpl(
      id: json['id'] as String,
      order: (json['order'] as num).toInt(),
      type: $enumDecode(_$StageTypeEnumMap, json['type']),
      title: json['title'] as String,
      content: StageContent.fromJson(json['content'] as Map<String, dynamic>),
      xpReward: (json['xpReward'] as num).toInt(),
      estimatedMinutes: (json['estimatedMinutes'] as num).toInt(),
    );

Map<String, dynamic> _$$LearningStageImplToJson(_$LearningStageImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'order': instance.order,
      'type': _$StageTypeEnumMap[instance.type]!,
      'title': instance.title,
      'content': instance.content,
      'xpReward': instance.xpReward,
      'estimatedMinutes': instance.estimatedMinutes,
    };

const _$StageTypeEnumMap = {StageType.learn: 'learn', StageType.apply: 'apply'};
