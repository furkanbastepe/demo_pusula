// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'project_progress.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$ProjectProgressImpl _$$ProjectProgressImplFromJson(
  Map<String, dynamic> json,
) => _$ProjectProgressImpl(
  userId: json['userId'] as String,
  projectId: json['projectId'] as String,
  moduleProgress:
      (json['moduleProgress'] as Map<String, dynamic>?)?.map(
        (k, e) =>
            MapEntry(k, ModuleProgress.fromJson(e as Map<String, dynamic>)),
      ) ??
      const {},
  currentModuleId: json['currentModuleId'] as String?,
  currentStageId: json['currentStageId'] as String?,
  earnedXP: (json['earnedXP'] as num).toInt(),
  totalStagesCompleted: (json['totalStagesCompleted'] as num).toInt(),
  startedAt: DateTime.parse(json['startedAt'] as String),
  completedAt: json['completedAt'] == null
      ? null
      : DateTime.parse(json['completedAt'] as String),
  lastActivityAt: json['lastActivityAt'] == null
      ? null
      : DateTime.parse(json['lastActivityAt'] as String),
  projectLink: json['projectLink'] as String?,
  projectDescription: json['projectDescription'] as String?,
  submittedAt: json['submittedAt'] == null
      ? null
      : DateTime.parse(json['submittedAt'] as String),
  atolyeSessionId: json['atolyeSessionId'] as String?,
  atolyeDate: json['atolyeDate'] == null
      ? null
      : DateTime.parse(json['atolyeDate'] as String),
  atolyeCompleted: json['atolyeCompleted'] as bool? ?? false,
  analytics: LearningAnalytics.fromJson(
    json['analytics'] as Map<String, dynamic>,
  ),
);

Map<String, dynamic> _$$ProjectProgressImplToJson(
  _$ProjectProgressImpl instance,
) => <String, dynamic>{
  'userId': instance.userId,
  'projectId': instance.projectId,
  'moduleProgress': instance.moduleProgress,
  'currentModuleId': instance.currentModuleId,
  'currentStageId': instance.currentStageId,
  'earnedXP': instance.earnedXP,
  'totalStagesCompleted': instance.totalStagesCompleted,
  'startedAt': instance.startedAt.toIso8601String(),
  'completedAt': instance.completedAt?.toIso8601String(),
  'lastActivityAt': instance.lastActivityAt?.toIso8601String(),
  'projectLink': instance.projectLink,
  'projectDescription': instance.projectDescription,
  'submittedAt': instance.submittedAt?.toIso8601String(),
  'atolyeSessionId': instance.atolyeSessionId,
  'atolyeDate': instance.atolyeDate?.toIso8601String(),
  'atolyeCompleted': instance.atolyeCompleted,
  'analytics': instance.analytics,
};
