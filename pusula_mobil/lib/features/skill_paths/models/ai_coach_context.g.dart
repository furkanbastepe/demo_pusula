// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ai_coach_context.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$AICoachContextImpl _$$AICoachContextImplFromJson(Map<String, dynamic> json) =>
    _$AICoachContextImpl(
      projectId: json['projectId'] as String,
      projectTitle: json['projectTitle'] as String,
      projectContext: ProjectContext.fromJson(
        json['projectContext'] as Map<String, dynamic>,
      ),
      currentModuleId: json['currentModuleId'] as String,
      currentStageId: json['currentStageId'] as String,
      stageType: $enumDecode(_$StageTypeEnumMap, json['stageType']),
      stageContent: StageContent.fromJson(
        json['stageContent'] as Map<String, dynamic>,
      ),
      completedStages:
          (json['completedStages'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          const [],
      analytics: LearningAnalytics.fromJson(
        json['analytics'] as Map<String, dynamic>,
      ),
      previousMessages: (json['previousMessages'] as List<dynamic>?)
          ?.map((e) => ChatMessage.fromJson(e as Map<String, dynamic>))
          .toList(),
      mode: $enumDecode(_$CoachingModeEnumMap, json['mode']),
    );

Map<String, dynamic> _$$AICoachContextImplToJson(
  _$AICoachContextImpl instance,
) => <String, dynamic>{
  'projectId': instance.projectId,
  'projectTitle': instance.projectTitle,
  'projectContext': instance.projectContext,
  'currentModuleId': instance.currentModuleId,
  'currentStageId': instance.currentStageId,
  'stageType': _$StageTypeEnumMap[instance.stageType]!,
  'stageContent': instance.stageContent,
  'completedStages': instance.completedStages,
  'analytics': instance.analytics,
  'previousMessages': instance.previousMessages,
  'mode': _$CoachingModeEnumMap[instance.mode]!,
};

const _$StageTypeEnumMap = {StageType.learn: 'learn', StageType.apply: 'apply'};

const _$CoachingModeEnumMap = {
  CoachingMode.guidance: 'guidance',
  CoachingMode.questioning: 'questioning',
  CoachingMode.hinting: 'hinting',
  CoachingMode.validation: 'validation',
};
