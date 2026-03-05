// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'validation_attempt.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$ValidationAttemptImpl _$$ValidationAttemptImplFromJson(
  Map<String, dynamic> json,
) => _$ValidationAttemptImpl(
  timestamp: DateTime.parse(json['timestamp'] as String),
  answers: (json['answers'] as List<dynamic>)
      .map((e) => ValidationAnswer.fromJson(e as Map<String, dynamic>))
      .toList(),
  passed: json['passed'] as bool,
  feedback: json['feedback'] as String?,
);

Map<String, dynamic> _$$ValidationAttemptImplToJson(
  _$ValidationAttemptImpl instance,
) => <String, dynamic>{
  'timestamp': instance.timestamp.toIso8601String(),
  'answers': instance.answers,
  'passed': instance.passed,
  'feedback': instance.feedback,
};
