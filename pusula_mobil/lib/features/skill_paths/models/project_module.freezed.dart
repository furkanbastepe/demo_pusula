// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'project_module.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

ProjectModule _$ProjectModuleFromJson(Map<String, dynamic> json) {
  return _ProjectModule.fromJson(json);
}

/// @nodoc
mixin _$ProjectModule {
  String get id => throw _privateConstructorUsedError;
  int get order => throw _privateConstructorUsedError;
  String get title => throw _privateConstructorUsedError;
  String get description => throw _privateConstructorUsedError;
  List<LearningStage> get stages => throw _privateConstructorUsedError;
  int get xpReward => throw _privateConstructorUsedError;
  int get estimatedMinutes => throw _privateConstructorUsedError;

  /// Serializes this ProjectModule to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of ProjectModule
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $ProjectModuleCopyWith<ProjectModule> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ProjectModuleCopyWith<$Res> {
  factory $ProjectModuleCopyWith(
    ProjectModule value,
    $Res Function(ProjectModule) then,
  ) = _$ProjectModuleCopyWithImpl<$Res, ProjectModule>;
  @useResult
  $Res call({
    String id,
    int order,
    String title,
    String description,
    List<LearningStage> stages,
    int xpReward,
    int estimatedMinutes,
  });
}

/// @nodoc
class _$ProjectModuleCopyWithImpl<$Res, $Val extends ProjectModule>
    implements $ProjectModuleCopyWith<$Res> {
  _$ProjectModuleCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of ProjectModule
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? order = null,
    Object? title = null,
    Object? description = null,
    Object? stages = null,
    Object? xpReward = null,
    Object? estimatedMinutes = null,
  }) {
    return _then(
      _value.copyWith(
            id: null == id
                ? _value.id
                : id // ignore: cast_nullable_to_non_nullable
                      as String,
            order: null == order
                ? _value.order
                : order // ignore: cast_nullable_to_non_nullable
                      as int,
            title: null == title
                ? _value.title
                : title // ignore: cast_nullable_to_non_nullable
                      as String,
            description: null == description
                ? _value.description
                : description // ignore: cast_nullable_to_non_nullable
                      as String,
            stages: null == stages
                ? _value.stages
                : stages // ignore: cast_nullable_to_non_nullable
                      as List<LearningStage>,
            xpReward: null == xpReward
                ? _value.xpReward
                : xpReward // ignore: cast_nullable_to_non_nullable
                      as int,
            estimatedMinutes: null == estimatedMinutes
                ? _value.estimatedMinutes
                : estimatedMinutes // ignore: cast_nullable_to_non_nullable
                      as int,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$ProjectModuleImplCopyWith<$Res>
    implements $ProjectModuleCopyWith<$Res> {
  factory _$$ProjectModuleImplCopyWith(
    _$ProjectModuleImpl value,
    $Res Function(_$ProjectModuleImpl) then,
  ) = __$$ProjectModuleImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String id,
    int order,
    String title,
    String description,
    List<LearningStage> stages,
    int xpReward,
    int estimatedMinutes,
  });
}

/// @nodoc
class __$$ProjectModuleImplCopyWithImpl<$Res>
    extends _$ProjectModuleCopyWithImpl<$Res, _$ProjectModuleImpl>
    implements _$$ProjectModuleImplCopyWith<$Res> {
  __$$ProjectModuleImplCopyWithImpl(
    _$ProjectModuleImpl _value,
    $Res Function(_$ProjectModuleImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of ProjectModule
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? order = null,
    Object? title = null,
    Object? description = null,
    Object? stages = null,
    Object? xpReward = null,
    Object? estimatedMinutes = null,
  }) {
    return _then(
      _$ProjectModuleImpl(
        id: null == id
            ? _value.id
            : id // ignore: cast_nullable_to_non_nullable
                  as String,
        order: null == order
            ? _value.order
            : order // ignore: cast_nullable_to_non_nullable
                  as int,
        title: null == title
            ? _value.title
            : title // ignore: cast_nullable_to_non_nullable
                  as String,
        description: null == description
            ? _value.description
            : description // ignore: cast_nullable_to_non_nullable
                  as String,
        stages: null == stages
            ? _value._stages
            : stages // ignore: cast_nullable_to_non_nullable
                  as List<LearningStage>,
        xpReward: null == xpReward
            ? _value.xpReward
            : xpReward // ignore: cast_nullable_to_non_nullable
                  as int,
        estimatedMinutes: null == estimatedMinutes
            ? _value.estimatedMinutes
            : estimatedMinutes // ignore: cast_nullable_to_non_nullable
                  as int,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$ProjectModuleImpl extends _ProjectModule {
  const _$ProjectModuleImpl({
    required this.id,
    required this.order,
    required this.title,
    required this.description,
    required final List<LearningStage> stages,
    required this.xpReward,
    required this.estimatedMinutes,
  }) : _stages = stages,
       super._();

  factory _$ProjectModuleImpl.fromJson(Map<String, dynamic> json) =>
      _$$ProjectModuleImplFromJson(json);

  @override
  final String id;
  @override
  final int order;
  @override
  final String title;
  @override
  final String description;
  final List<LearningStage> _stages;
  @override
  List<LearningStage> get stages {
    if (_stages is EqualUnmodifiableListView) return _stages;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_stages);
  }

  @override
  final int xpReward;
  @override
  final int estimatedMinutes;

  @override
  String toString() {
    return 'ProjectModule(id: $id, order: $order, title: $title, description: $description, stages: $stages, xpReward: $xpReward, estimatedMinutes: $estimatedMinutes)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ProjectModuleImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.order, order) || other.order == order) &&
            (identical(other.title, title) || other.title == title) &&
            (identical(other.description, description) ||
                other.description == description) &&
            const DeepCollectionEquality().equals(other._stages, _stages) &&
            (identical(other.xpReward, xpReward) ||
                other.xpReward == xpReward) &&
            (identical(other.estimatedMinutes, estimatedMinutes) ||
                other.estimatedMinutes == estimatedMinutes));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    id,
    order,
    title,
    description,
    const DeepCollectionEquality().hash(_stages),
    xpReward,
    estimatedMinutes,
  );

  /// Create a copy of ProjectModule
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ProjectModuleImplCopyWith<_$ProjectModuleImpl> get copyWith =>
      __$$ProjectModuleImplCopyWithImpl<_$ProjectModuleImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$ProjectModuleImplToJson(this);
  }
}

abstract class _ProjectModule extends ProjectModule {
  const factory _ProjectModule({
    required final String id,
    required final int order,
    required final String title,
    required final String description,
    required final List<LearningStage> stages,
    required final int xpReward,
    required final int estimatedMinutes,
  }) = _$ProjectModuleImpl;
  const _ProjectModule._() : super._();

  factory _ProjectModule.fromJson(Map<String, dynamic> json) =
      _$ProjectModuleImpl.fromJson;

  @override
  String get id;
  @override
  int get order;
  @override
  String get title;
  @override
  String get description;
  @override
  List<LearningStage> get stages;
  @override
  int get xpReward;
  @override
  int get estimatedMinutes;

  /// Create a copy of ProjectModule
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ProjectModuleImplCopyWith<_$ProjectModuleImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
