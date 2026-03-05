// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'stage_progress.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

StageProgress _$StageProgressFromJson(Map<String, dynamic> json) {
  return _StageProgress.fromJson(json);
}

/// @nodoc
mixin _$StageProgress {
  String get stageId => throw _privateConstructorUsedError;
  StageStatus get status => throw _privateConstructorUsedError;
  DateTime? get startedAt => throw _privateConstructorUsedError;
  DateTime? get completedAt => throw _privateConstructorUsedError;
  int get earnedXP => throw _privateConstructorUsedError; // Validation data
  List<ValidationAttempt> get validationAttempts =>
      throw _privateConstructorUsedError;
  bool get validationPassed =>
      throw _privateConstructorUsedError; // AI interaction
  int get aiInteractionCount => throw _privateConstructorUsedError;
  List<String> get aiConversationIds => throw _privateConstructorUsedError;

  /// Serializes this StageProgress to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of StageProgress
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $StageProgressCopyWith<StageProgress> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $StageProgressCopyWith<$Res> {
  factory $StageProgressCopyWith(
    StageProgress value,
    $Res Function(StageProgress) then,
  ) = _$StageProgressCopyWithImpl<$Res, StageProgress>;
  @useResult
  $Res call({
    String stageId,
    StageStatus status,
    DateTime? startedAt,
    DateTime? completedAt,
    int earnedXP,
    List<ValidationAttempt> validationAttempts,
    bool validationPassed,
    int aiInteractionCount,
    List<String> aiConversationIds,
  });
}

/// @nodoc
class _$StageProgressCopyWithImpl<$Res, $Val extends StageProgress>
    implements $StageProgressCopyWith<$Res> {
  _$StageProgressCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of StageProgress
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? stageId = null,
    Object? status = null,
    Object? startedAt = freezed,
    Object? completedAt = freezed,
    Object? earnedXP = null,
    Object? validationAttempts = null,
    Object? validationPassed = null,
    Object? aiInteractionCount = null,
    Object? aiConversationIds = null,
  }) {
    return _then(
      _value.copyWith(
            stageId: null == stageId
                ? _value.stageId
                : stageId // ignore: cast_nullable_to_non_nullable
                      as String,
            status: null == status
                ? _value.status
                : status // ignore: cast_nullable_to_non_nullable
                      as StageStatus,
            startedAt: freezed == startedAt
                ? _value.startedAt
                : startedAt // ignore: cast_nullable_to_non_nullable
                      as DateTime?,
            completedAt: freezed == completedAt
                ? _value.completedAt
                : completedAt // ignore: cast_nullable_to_non_nullable
                      as DateTime?,
            earnedXP: null == earnedXP
                ? _value.earnedXP
                : earnedXP // ignore: cast_nullable_to_non_nullable
                      as int,
            validationAttempts: null == validationAttempts
                ? _value.validationAttempts
                : validationAttempts // ignore: cast_nullable_to_non_nullable
                      as List<ValidationAttempt>,
            validationPassed: null == validationPassed
                ? _value.validationPassed
                : validationPassed // ignore: cast_nullable_to_non_nullable
                      as bool,
            aiInteractionCount: null == aiInteractionCount
                ? _value.aiInteractionCount
                : aiInteractionCount // ignore: cast_nullable_to_non_nullable
                      as int,
            aiConversationIds: null == aiConversationIds
                ? _value.aiConversationIds
                : aiConversationIds // ignore: cast_nullable_to_non_nullable
                      as List<String>,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$StageProgressImplCopyWith<$Res>
    implements $StageProgressCopyWith<$Res> {
  factory _$$StageProgressImplCopyWith(
    _$StageProgressImpl value,
    $Res Function(_$StageProgressImpl) then,
  ) = __$$StageProgressImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String stageId,
    StageStatus status,
    DateTime? startedAt,
    DateTime? completedAt,
    int earnedXP,
    List<ValidationAttempt> validationAttempts,
    bool validationPassed,
    int aiInteractionCount,
    List<String> aiConversationIds,
  });
}

/// @nodoc
class __$$StageProgressImplCopyWithImpl<$Res>
    extends _$StageProgressCopyWithImpl<$Res, _$StageProgressImpl>
    implements _$$StageProgressImplCopyWith<$Res> {
  __$$StageProgressImplCopyWithImpl(
    _$StageProgressImpl _value,
    $Res Function(_$StageProgressImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of StageProgress
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? stageId = null,
    Object? status = null,
    Object? startedAt = freezed,
    Object? completedAt = freezed,
    Object? earnedXP = null,
    Object? validationAttempts = null,
    Object? validationPassed = null,
    Object? aiInteractionCount = null,
    Object? aiConversationIds = null,
  }) {
    return _then(
      _$StageProgressImpl(
        stageId: null == stageId
            ? _value.stageId
            : stageId // ignore: cast_nullable_to_non_nullable
                  as String,
        status: null == status
            ? _value.status
            : status // ignore: cast_nullable_to_non_nullable
                  as StageStatus,
        startedAt: freezed == startedAt
            ? _value.startedAt
            : startedAt // ignore: cast_nullable_to_non_nullable
                  as DateTime?,
        completedAt: freezed == completedAt
            ? _value.completedAt
            : completedAt // ignore: cast_nullable_to_non_nullable
                  as DateTime?,
        earnedXP: null == earnedXP
            ? _value.earnedXP
            : earnedXP // ignore: cast_nullable_to_non_nullable
                  as int,
        validationAttempts: null == validationAttempts
            ? _value._validationAttempts
            : validationAttempts // ignore: cast_nullable_to_non_nullable
                  as List<ValidationAttempt>,
        validationPassed: null == validationPassed
            ? _value.validationPassed
            : validationPassed // ignore: cast_nullable_to_non_nullable
                  as bool,
        aiInteractionCount: null == aiInteractionCount
            ? _value.aiInteractionCount
            : aiInteractionCount // ignore: cast_nullable_to_non_nullable
                  as int,
        aiConversationIds: null == aiConversationIds
            ? _value._aiConversationIds
            : aiConversationIds // ignore: cast_nullable_to_non_nullable
                  as List<String>,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$StageProgressImpl implements _StageProgress {
  const _$StageProgressImpl({
    required this.stageId,
    required this.status,
    this.startedAt,
    this.completedAt,
    required this.earnedXP,
    final List<ValidationAttempt> validationAttempts = const [],
    this.validationPassed = false,
    this.aiInteractionCount = 0,
    final List<String> aiConversationIds = const [],
  }) : _validationAttempts = validationAttempts,
       _aiConversationIds = aiConversationIds;

  factory _$StageProgressImpl.fromJson(Map<String, dynamic> json) =>
      _$$StageProgressImplFromJson(json);

  @override
  final String stageId;
  @override
  final StageStatus status;
  @override
  final DateTime? startedAt;
  @override
  final DateTime? completedAt;
  @override
  final int earnedXP;
  // Validation data
  final List<ValidationAttempt> _validationAttempts;
  // Validation data
  @override
  @JsonKey()
  List<ValidationAttempt> get validationAttempts {
    if (_validationAttempts is EqualUnmodifiableListView)
      return _validationAttempts;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_validationAttempts);
  }

  @override
  @JsonKey()
  final bool validationPassed;
  // AI interaction
  @override
  @JsonKey()
  final int aiInteractionCount;
  final List<String> _aiConversationIds;
  @override
  @JsonKey()
  List<String> get aiConversationIds {
    if (_aiConversationIds is EqualUnmodifiableListView)
      return _aiConversationIds;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_aiConversationIds);
  }

  @override
  String toString() {
    return 'StageProgress(stageId: $stageId, status: $status, startedAt: $startedAt, completedAt: $completedAt, earnedXP: $earnedXP, validationAttempts: $validationAttempts, validationPassed: $validationPassed, aiInteractionCount: $aiInteractionCount, aiConversationIds: $aiConversationIds)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$StageProgressImpl &&
            (identical(other.stageId, stageId) || other.stageId == stageId) &&
            (identical(other.status, status) || other.status == status) &&
            (identical(other.startedAt, startedAt) ||
                other.startedAt == startedAt) &&
            (identical(other.completedAt, completedAt) ||
                other.completedAt == completedAt) &&
            (identical(other.earnedXP, earnedXP) ||
                other.earnedXP == earnedXP) &&
            const DeepCollectionEquality().equals(
              other._validationAttempts,
              _validationAttempts,
            ) &&
            (identical(other.validationPassed, validationPassed) ||
                other.validationPassed == validationPassed) &&
            (identical(other.aiInteractionCount, aiInteractionCount) ||
                other.aiInteractionCount == aiInteractionCount) &&
            const DeepCollectionEquality().equals(
              other._aiConversationIds,
              _aiConversationIds,
            ));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    stageId,
    status,
    startedAt,
    completedAt,
    earnedXP,
    const DeepCollectionEquality().hash(_validationAttempts),
    validationPassed,
    aiInteractionCount,
    const DeepCollectionEquality().hash(_aiConversationIds),
  );

  /// Create a copy of StageProgress
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$StageProgressImplCopyWith<_$StageProgressImpl> get copyWith =>
      __$$StageProgressImplCopyWithImpl<_$StageProgressImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$StageProgressImplToJson(this);
  }
}

abstract class _StageProgress implements StageProgress {
  const factory _StageProgress({
    required final String stageId,
    required final StageStatus status,
    final DateTime? startedAt,
    final DateTime? completedAt,
    required final int earnedXP,
    final List<ValidationAttempt> validationAttempts,
    final bool validationPassed,
    final int aiInteractionCount,
    final List<String> aiConversationIds,
  }) = _$StageProgressImpl;

  factory _StageProgress.fromJson(Map<String, dynamic> json) =
      _$StageProgressImpl.fromJson;

  @override
  String get stageId;
  @override
  StageStatus get status;
  @override
  DateTime? get startedAt;
  @override
  DateTime? get completedAt;
  @override
  int get earnedXP; // Validation data
  @override
  List<ValidationAttempt> get validationAttempts;
  @override
  bool get validationPassed; // AI interaction
  @override
  int get aiInteractionCount;
  @override
  List<String> get aiConversationIds;

  /// Create a copy of StageProgress
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$StageProgressImplCopyWith<_$StageProgressImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
