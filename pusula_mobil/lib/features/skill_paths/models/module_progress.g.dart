// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'module_progress.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$ModuleProgressImpl _$$ModuleProgressImplFromJson(Map<String, dynamic> json) =>
    _$ModuleProgressImpl(
      moduleId: json['moduleId'] as String,
      stageProgress:
          (json['stageProgress'] as Map<String, dynamic>?)?.map(
            (k, e) =>
                MapEntry(k, StageProgress.fromJson(e as Map<String, dynamic>)),
          ) ??
          const {},
      isCompleted: json['isCompleted'] as bool? ?? false,
      completedAt: json['completedAt'] == null
          ? null
          : DateTime.parse(json['completedAt'] as String),
      earnedXP: (json['earnedXP'] as num).toInt(),
    );

Map<String, dynamic> _$$ModuleProgressImplToJson(
  _$ModuleProgressImpl instance,
) => <String, dynamic>{
  'moduleId': instance.moduleId,
  'stageProgress': instance.stageProgress,
  'isCompleted': instance.isCompleted,
  'completedAt': instance.completedAt?.toIso8601String(),
  'earnedXP': instance.earnedXP,
};
