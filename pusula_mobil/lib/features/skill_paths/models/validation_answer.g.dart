// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'validation_answer.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$ValidationAnswerImpl _$$ValidationAnswerImplFromJson(
  Map<String, dynamic> json,
) => _$ValidationAnswerImpl(
  question: json['question'] as String,
  userAnswer: json['userAnswer'] as String,
  isCorrect: json['isCorrect'] as bool,
  hint: json['hint'] as String?,
);

Map<String, dynamic> _$$ValidationAnswerImplToJson(
  _$ValidationAnswerImpl instance,
) => <String, dynamic>{
  'question': instance.question,
  'userAnswer': instance.userAnswer,
  'isCorrect': instance.isCorrect,
  'hint': instance.hint,
};
