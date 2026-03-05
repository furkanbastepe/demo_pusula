// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'stage_content.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$LearnContentImpl _$$LearnContentImplFromJson(Map<String, dynamic> json) =>
    _$LearnContentImpl(
      concept: json['concept'] as String,
      definition: json['definition'] as String,
      whyImportant: json['whyImportant'] as String,
      howItWorks: json['howItWorks'] as String,
      examples: (json['examples'] as List<dynamic>)
          .map((e) => e as String)
          .toList(),
      visualAid: json['visualAid'] as String?,
      $type: json['type'] as String?,
    );

Map<String, dynamic> _$$LearnContentImplToJson(_$LearnContentImpl instance) =>
    <String, dynamic>{
      'concept': instance.concept,
      'definition': instance.definition,
      'whyImportant': instance.whyImportant,
      'howItWorks': instance.howItWorks,
      'examples': instance.examples,
      'visualAid': instance.visualAid,
      'type': instance.$type,
    };

_$ApplyContentImpl _$$ApplyContentImplFromJson(Map<String, dynamic> json) =>
    _$ApplyContentImpl(
      task: json['task'] as String,
      deliverable: json['deliverable'] as String,
      steps: (json['steps'] as List<dynamic>).map((e) => e as String).toList(),
      tools: (json['tools'] as List<dynamic>).map((e) => e as String).toList(),
      exampleOutput: json['exampleOutput'] as String,
      commonMistakes: (json['commonMistakes'] as List<dynamic>)
          .map((e) => e as String)
          .toList(),
      validationQuestions: (json['validationQuestions'] as List<dynamic>)
          .map((e) => ValidationQuestion.fromJson(e as Map<String, dynamic>))
          .toList(),
      $type: json['type'] as String?,
    );

Map<String, dynamic> _$$ApplyContentImplToJson(_$ApplyContentImpl instance) =>
    <String, dynamic>{
      'task': instance.task,
      'deliverable': instance.deliverable,
      'steps': instance.steps,
      'tools': instance.tools,
      'exampleOutput': instance.exampleOutput,
      'commonMistakes': instance.commonMistakes,
      'validationQuestions': instance.validationQuestions,
      'type': instance.$type,
    };
