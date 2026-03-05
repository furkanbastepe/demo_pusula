// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'validation_question.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$ValidationQuestionImpl _$$ValidationQuestionImplFromJson(
  Map<String, dynamic> json,
) => _$ValidationQuestionImpl(
  question: json['question'] as String,
  expectedKeywords: json['expectedKeywords'] as String,
  hint: json['hint'] as String,
);

Map<String, dynamic> _$$ValidationQuestionImplToJson(
  _$ValidationQuestionImpl instance,
) => <String, dynamic>{
  'question': instance.question,
  'expectedKeywords': instance.expectedKeywords,
  'hint': instance.hint,
};
