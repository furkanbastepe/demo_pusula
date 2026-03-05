// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'project_context.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$ProjectContextImpl _$$ProjectContextImplFromJson(Map<String, dynamic> json) =>
    _$ProjectContextImpl(
      companyName: json['companyName'] as String,
      companyType: json['companyType'] as String,
      industry: json['industry'] as String,
      projectGoal: json['projectGoal'] as String,
      targetAudience: json['targetAudience'] as String,
      scenario: json['scenario'] as String,
      deliverables: (json['deliverables'] as List<dynamic>)
          .map((e) => e as String)
          .toList(),
    );

Map<String, dynamic> _$$ProjectContextImplToJson(
  _$ProjectContextImpl instance,
) => <String, dynamic>{
  'companyName': instance.companyName,
  'companyType': instance.companyType,
  'industry': instance.industry,
  'projectGoal': instance.projectGoal,
  'targetAudience': instance.targetAudience,
  'scenario': instance.scenario,
  'deliverables': instance.deliverables,
};
