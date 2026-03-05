// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'learning_stage.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

LearningStage _$LearningStageFromJson(Map<String, dynamic> json) {
  return _LearningStage.fromJson(json);
}

/// @nodoc
mixin _$LearningStage {
  String get id => throw _privateConstructorUsedError;
  int get order => throw _privateConstructorUsedError;
  StageType get type =>
      throw _privateConstructorUsedError; // "learn" or "apply"
  String get title => throw _privateConstructorUsedError;
  StageContent get content => throw _privateConstructorUsedError;
  int get xpReward => throw _privateConstructorUsedError;
  int get estimatedMinutes => throw _privateConstructorUsedError;

  /// Serializes this LearningStage to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of LearningStage
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $LearningStageCopyWith<LearningStage> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $LearningStageCopyWith<$Res> {
  factory $LearningStageCopyWith(
    LearningStage value,
    $Res Function(LearningStage) then,
  ) = _$LearningStageCopyWithImpl<$Res, LearningStage>;
  @useResult
  $Res call({
    String id,
    int order,
    StageType type,
    String title,
    StageContent content,
    int xpReward,
    int estimatedMinutes,
  });

  $StageContentCopyWith<$Res> get content;
}

/// @nodoc
class _$LearningStageCopyWithImpl<$Res, $Val extends LearningStage>
    implements $LearningStageCopyWith<$Res> {
  _$LearningStageCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of LearningStage
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? order = null,
    Object? type = null,
    Object? title = null,
    Object? content = null,
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
            type: null == type
                ? _value.type
                : type // ignore: cast_nullable_to_non_nullable
                      as StageType,
            title: null == title
                ? _value.title
                : title // ignore: cast_nullable_to_non_nullable
                      as String,
            content: null == content
                ? _value.content
                : content // ignore: cast_nullable_to_non_nullable
                      as StageContent,
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

  /// Create a copy of LearningStage
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $StageContentCopyWith<$Res> get content {
    return $StageContentCopyWith<$Res>(_value.content, (value) {
      return _then(_value.copyWith(content: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$LearningStageImplCopyWith<$Res>
    implements $LearningStageCopyWith<$Res> {
  factory _$$LearningStageImplCopyWith(
    _$LearningStageImpl value,
    $Res Function(_$LearningStageImpl) then,
  ) = __$$LearningStageImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String id,
    int order,
    StageType type,
    String title,
    StageContent content,
    int xpReward,
    int estimatedMinutes,
  });

  @override
  $StageContentCopyWith<$Res> get content;
}

/// @nodoc
class __$$LearningStageImplCopyWithImpl<$Res>
    extends _$LearningStageCopyWithImpl<$Res, _$LearningStageImpl>
    implements _$$LearningStageImplCopyWith<$Res> {
  __$$LearningStageImplCopyWithImpl(
    _$LearningStageImpl _value,
    $Res Function(_$LearningStageImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of LearningStage
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? order = null,
    Object? type = null,
    Object? title = null,
    Object? content = null,
    Object? xpReward = null,
    Object? estimatedMinutes = null,
  }) {
    return _then(
      _$LearningStageImpl(
        id: null == id
            ? _value.id
            : id // ignore: cast_nullable_to_non_nullable
                  as String,
        order: null == order
            ? _value.order
            : order // ignore: cast_nullable_to_non_nullable
                  as int,
        type: null == type
            ? _value.type
            : type // ignore: cast_nullable_to_non_nullable
                  as StageType,
        title: null == title
            ? _value.title
            : title // ignore: cast_nullable_to_non_nullable
                  as String,
        content: null == content
            ? _value.content
            : content // ignore: cast_nullable_to_non_nullable
                  as StageContent,
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
class _$LearningStageImpl implements _LearningStage {
  const _$LearningStageImpl({
    required this.id,
    required this.order,
    required this.type,
    required this.title,
    required this.content,
    required this.xpReward,
    required this.estimatedMinutes,
  });

  factory _$LearningStageImpl.fromJson(Map<String, dynamic> json) =>
      _$$LearningStageImplFromJson(json);

  @override
  final String id;
  @override
  final int order;
  @override
  final StageType type;
  // "learn" or "apply"
  @override
  final String title;
  @override
  final StageContent content;
  @override
  final int xpReward;
  @override
  final int estimatedMinutes;

  @override
  String toString() {
    return 'LearningStage(id: $id, order: $order, type: $type, title: $title, content: $content, xpReward: $xpReward, estimatedMinutes: $estimatedMinutes)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$LearningStageImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.order, order) || other.order == order) &&
            (identical(other.type, type) || other.type == type) &&
            (identical(other.title, title) || other.title == title) &&
            (identical(other.content, content) || other.content == content) &&
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
    type,
    title,
    content,
    xpReward,
    estimatedMinutes,
  );

  /// Create a copy of LearningStage
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$LearningStageImplCopyWith<_$LearningStageImpl> get copyWith =>
      __$$LearningStageImplCopyWithImpl<_$LearningStageImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$LearningStageImplToJson(this);
  }
}

abstract class _LearningStage implements LearningStage {
  const factory _LearningStage({
    required final String id,
    required final int order,
    required final StageType type,
    required final String title,
    required final StageContent content,
    required final int xpReward,
    required final int estimatedMinutes,
  }) = _$LearningStageImpl;

  factory _LearningStage.fromJson(Map<String, dynamic> json) =
      _$LearningStageImpl.fromJson;

  @override
  String get id;
  @override
  int get order;
  @override
  StageType get type; // "learn" or "apply"
  @override
  String get title;
  @override
  StageContent get content;
  @override
  int get xpReward;
  @override
  int get estimatedMinutes;

  /// Create a copy of LearningStage
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$LearningStageImplCopyWith<_$LearningStageImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
