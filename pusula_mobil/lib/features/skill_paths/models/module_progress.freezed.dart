// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'module_progress.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

ModuleProgress _$ModuleProgressFromJson(Map<String, dynamic> json) {
  return _ModuleProgress.fromJson(json);
}

/// @nodoc
mixin _$ModuleProgress {
  String get moduleId => throw _privateConstructorUsedError;
  Map<String, StageProgress> get stageProgress =>
      throw _privateConstructorUsedError; // stageId → progress
  bool get isCompleted => throw _privateConstructorUsedError;
  DateTime? get completedAt => throw _privateConstructorUsedError;
  int get earnedXP => throw _privateConstructorUsedError;

  /// Serializes this ModuleProgress to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of ModuleProgress
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $ModuleProgressCopyWith<ModuleProgress> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ModuleProgressCopyWith<$Res> {
  factory $ModuleProgressCopyWith(
    ModuleProgress value,
    $Res Function(ModuleProgress) then,
  ) = _$ModuleProgressCopyWithImpl<$Res, ModuleProgress>;
  @useResult
  $Res call({
    String moduleId,
    Map<String, StageProgress> stageProgress,
    bool isCompleted,
    DateTime? completedAt,
    int earnedXP,
  });
}

/// @nodoc
class _$ModuleProgressCopyWithImpl<$Res, $Val extends ModuleProgress>
    implements $ModuleProgressCopyWith<$Res> {
  _$ModuleProgressCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of ModuleProgress
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? moduleId = null,
    Object? stageProgress = null,
    Object? isCompleted = null,
    Object? completedAt = freezed,
    Object? earnedXP = null,
  }) {
    return _then(
      _value.copyWith(
            moduleId: null == moduleId
                ? _value.moduleId
                : moduleId // ignore: cast_nullable_to_non_nullable
                      as String,
            stageProgress: null == stageProgress
                ? _value.stageProgress
                : stageProgress // ignore: cast_nullable_to_non_nullable
                      as Map<String, StageProgress>,
            isCompleted: null == isCompleted
                ? _value.isCompleted
                : isCompleted // ignore: cast_nullable_to_non_nullable
                      as bool,
            completedAt: freezed == completedAt
                ? _value.completedAt
                : completedAt // ignore: cast_nullable_to_non_nullable
                      as DateTime?,
            earnedXP: null == earnedXP
                ? _value.earnedXP
                : earnedXP // ignore: cast_nullable_to_non_nullable
                      as int,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$ModuleProgressImplCopyWith<$Res>
    implements $ModuleProgressCopyWith<$Res> {
  factory _$$ModuleProgressImplCopyWith(
    _$ModuleProgressImpl value,
    $Res Function(_$ModuleProgressImpl) then,
  ) = __$$ModuleProgressImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String moduleId,
    Map<String, StageProgress> stageProgress,
    bool isCompleted,
    DateTime? completedAt,
    int earnedXP,
  });
}

/// @nodoc
class __$$ModuleProgressImplCopyWithImpl<$Res>
    extends _$ModuleProgressCopyWithImpl<$Res, _$ModuleProgressImpl>
    implements _$$ModuleProgressImplCopyWith<$Res> {
  __$$ModuleProgressImplCopyWithImpl(
    _$ModuleProgressImpl _value,
    $Res Function(_$ModuleProgressImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of ModuleProgress
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? moduleId = null,
    Object? stageProgress = null,
    Object? isCompleted = null,
    Object? completedAt = freezed,
    Object? earnedXP = null,
  }) {
    return _then(
      _$ModuleProgressImpl(
        moduleId: null == moduleId
            ? _value.moduleId
            : moduleId // ignore: cast_nullable_to_non_nullable
                  as String,
        stageProgress: null == stageProgress
            ? _value._stageProgress
            : stageProgress // ignore: cast_nullable_to_non_nullable
                  as Map<String, StageProgress>,
        isCompleted: null == isCompleted
            ? _value.isCompleted
            : isCompleted // ignore: cast_nullable_to_non_nullable
                  as bool,
        completedAt: freezed == completedAt
            ? _value.completedAt
            : completedAt // ignore: cast_nullable_to_non_nullable
                  as DateTime?,
        earnedXP: null == earnedXP
            ? _value.earnedXP
            : earnedXP // ignore: cast_nullable_to_non_nullable
                  as int,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$ModuleProgressImpl extends _ModuleProgress {
  const _$ModuleProgressImpl({
    required this.moduleId,
    final Map<String, StageProgress> stageProgress = const {},
    this.isCompleted = false,
    this.completedAt,
    required this.earnedXP,
  }) : _stageProgress = stageProgress,
       super._();

  factory _$ModuleProgressImpl.fromJson(Map<String, dynamic> json) =>
      _$$ModuleProgressImplFromJson(json);

  @override
  final String moduleId;
  final Map<String, StageProgress> _stageProgress;
  @override
  @JsonKey()
  Map<String, StageProgress> get stageProgress {
    if (_stageProgress is EqualUnmodifiableMapView) return _stageProgress;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(_stageProgress);
  }

  // stageId → progress
  @override
  @JsonKey()
  final bool isCompleted;
  @override
  final DateTime? completedAt;
  @override
  final int earnedXP;

  @override
  String toString() {
    return 'ModuleProgress(moduleId: $moduleId, stageProgress: $stageProgress, isCompleted: $isCompleted, completedAt: $completedAt, earnedXP: $earnedXP)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ModuleProgressImpl &&
            (identical(other.moduleId, moduleId) ||
                other.moduleId == moduleId) &&
            const DeepCollectionEquality().equals(
              other._stageProgress,
              _stageProgress,
            ) &&
            (identical(other.isCompleted, isCompleted) ||
                other.isCompleted == isCompleted) &&
            (identical(other.completedAt, completedAt) ||
                other.completedAt == completedAt) &&
            (identical(other.earnedXP, earnedXP) ||
                other.earnedXP == earnedXP));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    moduleId,
    const DeepCollectionEquality().hash(_stageProgress),
    isCompleted,
    completedAt,
    earnedXP,
  );

  /// Create a copy of ModuleProgress
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ModuleProgressImplCopyWith<_$ModuleProgressImpl> get copyWith =>
      __$$ModuleProgressImplCopyWithImpl<_$ModuleProgressImpl>(
        this,
        _$identity,
      );

  @override
  Map<String, dynamic> toJson() {
    return _$$ModuleProgressImplToJson(this);
  }
}

abstract class _ModuleProgress extends ModuleProgress {
  const factory _ModuleProgress({
    required final String moduleId,
    final Map<String, StageProgress> stageProgress,
    final bool isCompleted,
    final DateTime? completedAt,
    required final int earnedXP,
  }) = _$ModuleProgressImpl;
  const _ModuleProgress._() : super._();

  factory _ModuleProgress.fromJson(Map<String, dynamic> json) =
      _$ModuleProgressImpl.fromJson;

  @override
  String get moduleId;
  @override
  Map<String, StageProgress> get stageProgress; // stageId → progress
  @override
  bool get isCompleted;
  @override
  DateTime? get completedAt;
  @override
  int get earnedXP;

  /// Create a copy of ModuleProgress
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ModuleProgressImplCopyWith<_$ModuleProgressImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
