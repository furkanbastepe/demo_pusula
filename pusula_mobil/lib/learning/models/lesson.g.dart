// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'lesson.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$LessonImpl _$$LessonImplFromJson(Map<String, dynamic> json) => _$LessonImpl(
  id: json['id'] as String,
  courseId: json['courseId'] as String,
  order: (json['order'] as num).toInt(),
  title: json['title'] as String,
  sections: (json['sections'] as List<dynamic>)
      .map((e) => LessonSection.fromJson(e as Map<String, dynamic>))
      .toList(),
  xpReward: (json['xpReward'] as num).toInt(),
  estimatedTime: (json['estimatedTime'] as num).toInt(),
);

Map<String, dynamic> _$$LessonImplToJson(_$LessonImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'courseId': instance.courseId,
      'order': instance.order,
      'title': instance.title,
      'sections': instance.sections,
      'xpReward': instance.xpReward,
      'estimatedTime': instance.estimatedTime,
    };

_$ContentDataImpl _$$ContentDataImplFromJson(Map<String, dynamic> json) =>
    _$ContentDataImpl(
      markdown: json['markdown'] as String,
      imageUrls: (json['imageUrls'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
      examples: json['examples'] as Map<String, dynamic>?,
    );

Map<String, dynamic> _$$ContentDataImplToJson(_$ContentDataImpl instance) =>
    <String, dynamic>{
      'markdown': instance.markdown,
      'imageUrls': instance.imageUrls,
      'examples': instance.examples,
    };

_$QuizDataImpl _$$QuizDataImplFromJson(Map<String, dynamic> json) =>
    _$QuizDataImpl(
      question: json['question'] as String,
      options: (json['options'] as List<dynamic>)
          .map((e) => e as String)
          .toList(),
      correctAnswerIndex: (json['correctAnswerIndex'] as num).toInt(),
      explanation: json['explanation'] as String,
      xpReward: (json['xpReward'] as num?)?.toInt() ?? 10,
    );

Map<String, dynamic> _$$QuizDataImplToJson(_$QuizDataImpl instance) =>
    <String, dynamic>{
      'question': instance.question,
      'options': instance.options,
      'correctAnswerIndex': instance.correctAnswerIndex,
      'explanation': instance.explanation,
      'xpReward': instance.xpReward,
    };

_$CodeChallengeDataImpl _$$CodeChallengeDataImplFromJson(
  Map<String, dynamic> json,
) => _$CodeChallengeDataImpl(
  description: json['description'] as String,
  codeExample: json['codeExample'] as String,
  options: (json['options'] as List<dynamic>).map((e) => e as String).toList(),
  correctAnswerIndex: (json['correctAnswerIndex'] as num).toInt(),
  explanation: json['explanation'] as String,
  detailedSolution: json['detailedSolution'] as String,
  xpReward: (json['xpReward'] as num?)?.toInt() ?? 30,
);

Map<String, dynamic> _$$CodeChallengeDataImplToJson(
  _$CodeChallengeDataImpl instance,
) => <String, dynamic>{
  'description': instance.description,
  'codeExample': instance.codeExample,
  'options': instance.options,
  'correctAnswerIndex': instance.correctAnswerIndex,
  'explanation': instance.explanation,
  'detailedSolution': instance.detailedSolution,
  'xpReward': instance.xpReward,
};
