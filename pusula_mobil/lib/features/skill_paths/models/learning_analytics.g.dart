// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'learning_analytics.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$LearningAnalyticsImpl _$$LearningAnalyticsImplFromJson(
  Map<String, dynamic> json,
) => _$LearningAnalyticsImpl(
  totalTimeSpentMinutes: (json['totalTimeSpentMinutes'] as num).toInt(),
  timePerStage:
      (json['timePerStage'] as Map<String, dynamic>?)?.map(
        (k, e) => MapEntry(k, (e as num).toInt()),
      ) ??
      const {},
  totalAIInteractions: (json['totalAIInteractions'] as num).toInt(),
  totalValidationAttempts: (json['totalValidationAttempts'] as num).toInt(),
  validationSuccessRate: (json['validationSuccessRate'] as num).toDouble(),
  strugglingStages:
      (json['strugglingStages'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList() ??
      const [],
  consecutiveDaysActive: (json['consecutiveDaysActive'] as num).toInt(),
  lastActiveDate: DateTime.parse(json['lastActiveDate'] as String),
);

Map<String, dynamic> _$$LearningAnalyticsImplToJson(
  _$LearningAnalyticsImpl instance,
) => <String, dynamic>{
  'totalTimeSpentMinutes': instance.totalTimeSpentMinutes,
  'timePerStage': instance.timePerStage,
  'totalAIInteractions': instance.totalAIInteractions,
  'totalValidationAttempts': instance.totalValidationAttempts,
  'validationSuccessRate': instance.validationSuccessRate,
  'strugglingStages': instance.strugglingStages,
  'consecutiveDaysActive': instance.consecutiveDaysActive,
  'lastActiveDate': instance.lastActiveDate.toIso8601String(),
};
