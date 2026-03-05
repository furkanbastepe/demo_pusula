// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'project_context.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

ProjectContext _$ProjectContextFromJson(Map<String, dynamic> json) {
  return _ProjectContext.fromJson(json);
}

/// @nodoc
mixin _$ProjectContext {
  String get companyName => throw _privateConstructorUsedError;
  String get companyType => throw _privateConstructorUsedError;
  String get industry => throw _privateConstructorUsedError;
  String get projectGoal => throw _privateConstructorUsedError;
  String get targetAudience => throw _privateConstructorUsedError;
  String get scenario => throw _privateConstructorUsedError;
  List<String> get deliverables => throw _privateConstructorUsedError;

  /// Serializes this ProjectContext to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of ProjectContext
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $ProjectContextCopyWith<ProjectContext> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ProjectContextCopyWith<$Res> {
  factory $ProjectContextCopyWith(
    ProjectContext value,
    $Res Function(ProjectContext) then,
  ) = _$ProjectContextCopyWithImpl<$Res, ProjectContext>;
  @useResult
  $Res call({
    String companyName,
    String companyType,
    String industry,
    String projectGoal,
    String targetAudience,
    String scenario,
    List<String> deliverables,
  });
}

/// @nodoc
class _$ProjectContextCopyWithImpl<$Res, $Val extends ProjectContext>
    implements $ProjectContextCopyWith<$Res> {
  _$ProjectContextCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of ProjectContext
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? companyName = null,
    Object? companyType = null,
    Object? industry = null,
    Object? projectGoal = null,
    Object? targetAudience = null,
    Object? scenario = null,
    Object? deliverables = null,
  }) {
    return _then(
      _value.copyWith(
            companyName: null == companyName
                ? _value.companyName
                : companyName // ignore: cast_nullable_to_non_nullable
                      as String,
            companyType: null == companyType
                ? _value.companyType
                : companyType // ignore: cast_nullable_to_non_nullable
                      as String,
            industry: null == industry
                ? _value.industry
                : industry // ignore: cast_nullable_to_non_nullable
                      as String,
            projectGoal: null == projectGoal
                ? _value.projectGoal
                : projectGoal // ignore: cast_nullable_to_non_nullable
                      as String,
            targetAudience: null == targetAudience
                ? _value.targetAudience
                : targetAudience // ignore: cast_nullable_to_non_nullable
                      as String,
            scenario: null == scenario
                ? _value.scenario
                : scenario // ignore: cast_nullable_to_non_nullable
                      as String,
            deliverables: null == deliverables
                ? _value.deliverables
                : deliverables // ignore: cast_nullable_to_non_nullable
                      as List<String>,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$ProjectContextImplCopyWith<$Res>
    implements $ProjectContextCopyWith<$Res> {
  factory _$$ProjectContextImplCopyWith(
    _$ProjectContextImpl value,
    $Res Function(_$ProjectContextImpl) then,
  ) = __$$ProjectContextImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String companyName,
    String companyType,
    String industry,
    String projectGoal,
    String targetAudience,
    String scenario,
    List<String> deliverables,
  });
}

/// @nodoc
class __$$ProjectContextImplCopyWithImpl<$Res>
    extends _$ProjectContextCopyWithImpl<$Res, _$ProjectContextImpl>
    implements _$$ProjectContextImplCopyWith<$Res> {
  __$$ProjectContextImplCopyWithImpl(
    _$ProjectContextImpl _value,
    $Res Function(_$ProjectContextImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of ProjectContext
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? companyName = null,
    Object? companyType = null,
    Object? industry = null,
    Object? projectGoal = null,
    Object? targetAudience = null,
    Object? scenario = null,
    Object? deliverables = null,
  }) {
    return _then(
      _$ProjectContextImpl(
        companyName: null == companyName
            ? _value.companyName
            : companyName // ignore: cast_nullable_to_non_nullable
                  as String,
        companyType: null == companyType
            ? _value.companyType
            : companyType // ignore: cast_nullable_to_non_nullable
                  as String,
        industry: null == industry
            ? _value.industry
            : industry // ignore: cast_nullable_to_non_nullable
                  as String,
        projectGoal: null == projectGoal
            ? _value.projectGoal
            : projectGoal // ignore: cast_nullable_to_non_nullable
                  as String,
        targetAudience: null == targetAudience
            ? _value.targetAudience
            : targetAudience // ignore: cast_nullable_to_non_nullable
                  as String,
        scenario: null == scenario
            ? _value.scenario
            : scenario // ignore: cast_nullable_to_non_nullable
                  as String,
        deliverables: null == deliverables
            ? _value._deliverables
            : deliverables // ignore: cast_nullable_to_non_nullable
                  as List<String>,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$ProjectContextImpl implements _ProjectContext {
  const _$ProjectContextImpl({
    required this.companyName,
    required this.companyType,
    required this.industry,
    required this.projectGoal,
    required this.targetAudience,
    required this.scenario,
    required final List<String> deliverables,
  }) : _deliverables = deliverables;

  factory _$ProjectContextImpl.fromJson(Map<String, dynamic> json) =>
      _$$ProjectContextImplFromJson(json);

  @override
  final String companyName;
  @override
  final String companyType;
  @override
  final String industry;
  @override
  final String projectGoal;
  @override
  final String targetAudience;
  @override
  final String scenario;
  final List<String> _deliverables;
  @override
  List<String> get deliverables {
    if (_deliverables is EqualUnmodifiableListView) return _deliverables;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_deliverables);
  }

  @override
  String toString() {
    return 'ProjectContext(companyName: $companyName, companyType: $companyType, industry: $industry, projectGoal: $projectGoal, targetAudience: $targetAudience, scenario: $scenario, deliverables: $deliverables)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ProjectContextImpl &&
            (identical(other.companyName, companyName) ||
                other.companyName == companyName) &&
            (identical(other.companyType, companyType) ||
                other.companyType == companyType) &&
            (identical(other.industry, industry) ||
                other.industry == industry) &&
            (identical(other.projectGoal, projectGoal) ||
                other.projectGoal == projectGoal) &&
            (identical(other.targetAudience, targetAudience) ||
                other.targetAudience == targetAudience) &&
            (identical(other.scenario, scenario) ||
                other.scenario == scenario) &&
            const DeepCollectionEquality().equals(
              other._deliverables,
              _deliverables,
            ));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    companyName,
    companyType,
    industry,
    projectGoal,
    targetAudience,
    scenario,
    const DeepCollectionEquality().hash(_deliverables),
  );

  /// Create a copy of ProjectContext
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ProjectContextImplCopyWith<_$ProjectContextImpl> get copyWith =>
      __$$ProjectContextImplCopyWithImpl<_$ProjectContextImpl>(
        this,
        _$identity,
      );

  @override
  Map<String, dynamic> toJson() {
    return _$$ProjectContextImplToJson(this);
  }
}

abstract class _ProjectContext implements ProjectContext {
  const factory _ProjectContext({
    required final String companyName,
    required final String companyType,
    required final String industry,
    required final String projectGoal,
    required final String targetAudience,
    required final String scenario,
    required final List<String> deliverables,
  }) = _$ProjectContextImpl;

  factory _ProjectContext.fromJson(Map<String, dynamic> json) =
      _$ProjectContextImpl.fromJson;

  @override
  String get companyName;
  @override
  String get companyType;
  @override
  String get industry;
  @override
  String get projectGoal;
  @override
  String get targetAudience;
  @override
  String get scenario;
  @override
  List<String> get deliverables;

  /// Create a copy of ProjectContext
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ProjectContextImplCopyWith<_$ProjectContextImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
