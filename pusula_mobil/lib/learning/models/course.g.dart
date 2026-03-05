// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'course.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$CourseImpl _$$CourseImplFromJson(Map<String, dynamic> json) => _$CourseImpl(
  id: json['id'] as String,
  title: json['title'] as String,
  description: json['description'] as String,
  iconPath: json['iconPath'] as String,
  lessonIds: (json['lessonIds'] as List<dynamic>)
      .map((e) => e as String)
      .toList(),
  totalXP: (json['totalXP'] as num).toInt(),
  difficulty: json['difficulty'] as String? ?? 'beginner',
);

Map<String, dynamic> _$$CourseImplToJson(_$CourseImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'description': instance.description,
      'iconPath': instance.iconPath,
      'lessonIds': instance.lessonIds,
      'totalXP': instance.totalXP,
      'difficulty': instance.difficulty,
    };
