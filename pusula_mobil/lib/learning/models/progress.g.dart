// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'progress.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$LearningProgressImpl _$$LearningProgressImplFromJson(
  Map<String, dynamic> json,
) => _$LearningProgressImpl(
  userId: json['userId'] as String,
  courseProgress:
      (json['courseProgress'] as Map<String, dynamic>?)?.map(
        (k, e) =>
            MapEntry(k, CourseProgress.fromJson(e as Map<String, dynamic>)),
      ) ??
      const {},
  totalXP: (json['totalXP'] as num?)?.toInt() ?? 0,
  currentStreak: (json['currentStreak'] as num?)?.toInt() ?? 0,
  lastActivityDate: DateTime.parse(json['lastActivityDate'] as String),
  earnedAchievements:
      (json['earnedAchievements'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList() ??
      const [],
);

Map<String, dynamic> _$$LearningProgressImplToJson(
  _$LearningProgressImpl instance,
) => <String, dynamic>{
  'userId': instance.userId,
  'courseProgress': instance.courseProgress,
  'totalXP': instance.totalXP,
  'currentStreak': instance.currentStreak,
  'lastActivityDate': instance.lastActivityDate.toIso8601String(),
  'earnedAchievements': instance.earnedAchievements,
};

_$CourseProgressImpl _$$CourseProgressImplFromJson(Map<String, dynamic> json) =>
    _$CourseProgressImpl(
      courseId: json['courseId'] as String,
      completedLessonIds:
          (json['completedLessonIds'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          const [],
      earnedXP: (json['earnedXP'] as num?)?.toInt() ?? 0,
      lastAccessDate: DateTime.parse(json['lastAccessDate'] as String),
    );

Map<String, dynamic> _$$CourseProgressImplToJson(
  _$CourseProgressImpl instance,
) => <String, dynamic>{
  'courseId': instance.courseId,
  'completedLessonIds': instance.completedLessonIds,
  'earnedXP': instance.earnedXP,
  'lastAccessDate': instance.lastAccessDate.toIso8601String(),
};
