// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'stage_progress.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$StageProgressImpl _$$StageProgressImplFromJson(Map<String, dynamic> json) =>
    _$StageProgressImpl(
      stageId: json['stageId'] as String,
      status: $enumDecode(_$StageStatusEnumMap, json['status']),
      startedAt: json['startedAt'] == null
          ? null
          : DateTime.parse(json['startedAt'] as String),
      completedAt: json['completedAt'] == null
          ? null
          : DateTime.parse(json['completedAt'] as String),
      earnedXP: (json['earnedXP'] as num).toInt(),
      validationAttempts:
          (json['validationAttempts'] as List<dynamic>?)
              ?.map(
                (e) => ValidationAttempt.fromJson(e as Map<String, dynamic>),
              )
              .toList() ??
          const [],
      validationPassed: json['validationPassed'] as bool? ?? false,
      aiInteractionCount: (json['aiInteractionCount'] as num?)?.toInt() ?? 0,
      aiConversationIds:
          (json['aiConversationIds'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          const [],
    );

Map<String, dynamic> _$$StageProgressImplToJson(_$StageProgressImpl instance) =>
    <String, dynamic>{
      'stageId': instance.stageId,
      'status': _$StageStatusEnumMap[instance.status]!,
      'startedAt': instance.startedAt?.toIso8601String(),
      'completedAt': instance.completedAt?.toIso8601String(),
      'earnedXP': instance.earnedXP,
      'validationAttempts': instance.validationAttempts,
      'validationPassed': instance.validationPassed,
      'aiInteractionCount': instance.aiInteractionCount,
      'aiConversationIds': instance.aiConversationIds,
    };

const _$StageStatusEnumMap = {
  StageStatus.locked: 'locked',
  StageStatus.unlocked: 'unlocked',
  StageStatus.inProgress: 'in_progress',
  StageStatus.completed: 'completed',
};
