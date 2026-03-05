// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'validation_attempt.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

ValidationAttempt _$ValidationAttemptFromJson(Map<String, dynamic> json) {
  return _ValidationAttempt.fromJson(json);
}

/// @nodoc
mixin _$ValidationAttempt {
  DateTime get timestamp => throw _privateConstructorUsedError;
  List<ValidationAnswer> get answers => throw _privateConstructorUsedError;
  bool get passed => throw _privateConstructorUsedError;
  String? get feedback => throw _privateConstructorUsedError;

  /// Serializes this ValidationAttempt to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of ValidationAttempt
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $ValidationAttemptCopyWith<ValidationAttempt> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ValidationAttemptCopyWith<$Res> {
  factory $ValidationAttemptCopyWith(
    ValidationAttempt value,
    $Res Function(ValidationAttempt) then,
  ) = _$ValidationAttemptCopyWithImpl<$Res, ValidationAttempt>;
  @useResult
  $Res call({
    DateTime timestamp,
    List<ValidationAnswer> answers,
    bool passed,
    String? feedback,
  });
}

/// @nodoc
class _$ValidationAttemptCopyWithImpl<$Res, $Val extends ValidationAttempt>
    implements $ValidationAttemptCopyWith<$Res> {
  _$ValidationAttemptCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of ValidationAttempt
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? timestamp = null,
    Object? answers = null,
    Object? passed = null,
    Object? feedback = freezed,
  }) {
    return _then(
      _value.copyWith(
            timestamp: null == timestamp
                ? _value.timestamp
                : timestamp // ignore: cast_nullable_to_non_nullable
                      as DateTime,
            answers: null == answers
                ? _value.answers
                : answers // ignore: cast_nullable_to_non_nullable
                      as List<ValidationAnswer>,
            passed: null == passed
                ? _value.passed
                : passed // ignore: cast_nullable_to_non_nullable
                      as bool,
            feedback: freezed == feedback
                ? _value.feedback
                : feedback // ignore: cast_nullable_to_non_nullable
                      as String?,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$ValidationAttemptImplCopyWith<$Res>
    implements $ValidationAttemptCopyWith<$Res> {
  factory _$$ValidationAttemptImplCopyWith(
    _$ValidationAttemptImpl value,
    $Res Function(_$ValidationAttemptImpl) then,
  ) = __$$ValidationAttemptImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    DateTime timestamp,
    List<ValidationAnswer> answers,
    bool passed,
    String? feedback,
  });
}

/// @nodoc
class __$$ValidationAttemptImplCopyWithImpl<$Res>
    extends _$ValidationAttemptCopyWithImpl<$Res, _$ValidationAttemptImpl>
    implements _$$ValidationAttemptImplCopyWith<$Res> {
  __$$ValidationAttemptImplCopyWithImpl(
    _$ValidationAttemptImpl _value,
    $Res Function(_$ValidationAttemptImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of ValidationAttempt
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? timestamp = null,
    Object? answers = null,
    Object? passed = null,
    Object? feedback = freezed,
  }) {
    return _then(
      _$ValidationAttemptImpl(
        timestamp: null == timestamp
            ? _value.timestamp
            : timestamp // ignore: cast_nullable_to_non_nullable
                  as DateTime,
        answers: null == answers
            ? _value._answers
            : answers // ignore: cast_nullable_to_non_nullable
                  as List<ValidationAnswer>,
        passed: null == passed
            ? _value.passed
            : passed // ignore: cast_nullable_to_non_nullable
                  as bool,
        feedback: freezed == feedback
            ? _value.feedback
            : feedback // ignore: cast_nullable_to_non_nullable
                  as String?,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$ValidationAttemptImpl implements _ValidationAttempt {
  const _$ValidationAttemptImpl({
    required this.timestamp,
    required final List<ValidationAnswer> answers,
    required this.passed,
    this.feedback,
  }) : _answers = answers;

  factory _$ValidationAttemptImpl.fromJson(Map<String, dynamic> json) =>
      _$$ValidationAttemptImplFromJson(json);

  @override
  final DateTime timestamp;
  final List<ValidationAnswer> _answers;
  @override
  List<ValidationAnswer> get answers {
    if (_answers is EqualUnmodifiableListView) return _answers;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_answers);
  }

  @override
  final bool passed;
  @override
  final String? feedback;

  @override
  String toString() {
    return 'ValidationAttempt(timestamp: $timestamp, answers: $answers, passed: $passed, feedback: $feedback)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ValidationAttemptImpl &&
            (identical(other.timestamp, timestamp) ||
                other.timestamp == timestamp) &&
            const DeepCollectionEquality().equals(other._answers, _answers) &&
            (identical(other.passed, passed) || other.passed == passed) &&
            (identical(other.feedback, feedback) ||
                other.feedback == feedback));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    timestamp,
    const DeepCollectionEquality().hash(_answers),
    passed,
    feedback,
  );

  /// Create a copy of ValidationAttempt
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ValidationAttemptImplCopyWith<_$ValidationAttemptImpl> get copyWith =>
      __$$ValidationAttemptImplCopyWithImpl<_$ValidationAttemptImpl>(
        this,
        _$identity,
      );

  @override
  Map<String, dynamic> toJson() {
    return _$$ValidationAttemptImplToJson(this);
  }
}

abstract class _ValidationAttempt implements ValidationAttempt {
  const factory _ValidationAttempt({
    required final DateTime timestamp,
    required final List<ValidationAnswer> answers,
    required final bool passed,
    final String? feedback,
  }) = _$ValidationAttemptImpl;

  factory _ValidationAttempt.fromJson(Map<String, dynamic> json) =
      _$ValidationAttemptImpl.fromJson;

  @override
  DateTime get timestamp;
  @override
  List<ValidationAnswer> get answers;
  @override
  bool get passed;
  @override
  String? get feedback;

  /// Create a copy of ValidationAttempt
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ValidationAttemptImplCopyWith<_$ValidationAttemptImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
