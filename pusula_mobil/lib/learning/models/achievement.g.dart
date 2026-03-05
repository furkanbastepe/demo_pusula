// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'achievement.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$AchievementImpl _$$AchievementImplFromJson(Map<String, dynamic> json) =>
    _$AchievementImpl(
      id: json['id'] as String,
      title: json['title'] as String,
      description: json['description'] as String,
      iconPath: json['iconPath'] as String,
      type: $enumDecode(_$AchievementTypeEnumMap, json['type']),
      requirement: (json['requirement'] as num).toInt(),
    );

Map<String, dynamic> _$$AchievementImplToJson(_$AchievementImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'description': instance.description,
      'iconPath': instance.iconPath,
      'type': _$AchievementTypeEnumMap[instance.type]!,
      'requirement': instance.requirement,
    };

const _$AchievementTypeEnumMap = {
  AchievementType.firstLesson: 'firstLesson',
  AchievementType.streakMilestone: 'streakMilestone',
  AchievementType.courseCompletion: 'courseCompletion',
  AchievementType.xpMilestone: 'xpMilestone',
  AchievementType.perfectQuiz: 'perfectQuiz',
};
