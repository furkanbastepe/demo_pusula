// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'validation_answer.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

ValidationAnswer _$ValidationAnswerFromJson(Map<String, dynamic> json) {
  return _ValidationAnswer.fromJson(json);
}

/// @nodoc
mixin _$ValidationAnswer {
  String get question => throw _privateConstructorUsedError;
  String get userAnswer => throw _privateConstructorUsedError;
  bool get isCorrect => throw _privateConstructorUsedError;
  String? get hint => throw _privateConstructorUsedError;

  /// Serializes this ValidationAnswer to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of ValidationAnswer
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $ValidationAnswerCopyWith<ValidationAnswer> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ValidationAnswerCopyWith<$Res> {
  factory $ValidationAnswerCopyWith(
    ValidationAnswer value,
    $Res Function(ValidationAnswer) then,
  ) = _$ValidationAnswerCopyWithImpl<$Res, ValidationAnswer>;
  @useResult
  $Res call({String question, String userAnswer, bool isCorrect, String? hint});
}

/// @nodoc
class _$ValidationAnswerCopyWithImpl<$Res, $Val extends ValidationAnswer>
    implements $ValidationAnswerCopyWith<$Res> {
  _$ValidationAnswerCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of ValidationAnswer
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? question = null,
    Object? userAnswer = null,
    Object? isCorrect = null,
    Object? hint = freezed,
  }) {
    return _then(
      _value.copyWith(
            question: null == question
                ? _value.question
                : question // ignore: cast_nullable_to_non_nullable
                      as String,
            userAnswer: null == userAnswer
                ? _value.userAnswer
                : userAnswer // ignore: cast_nullable_to_non_nullable
                      as String,
            isCorrect: null == isCorrect
                ? _value.isCorrect
                : isCorrect // ignore: cast_nullable_to_non_nullable
                      as bool,
            hint: freezed == hint
                ? _value.hint
                : hint // ignore: cast_nullable_to_non_nullable
                      as String?,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$ValidationAnswerImplCopyWith<$Res>
    implements $ValidationAnswerCopyWith<$Res> {
  factory _$$ValidationAnswerImplCopyWith(
    _$ValidationAnswerImpl value,
    $Res Function(_$ValidationAnswerImpl) then,
  ) = __$$ValidationAnswerImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String question, String userAnswer, bool isCorrect, String? hint});
}

/// @nodoc
class __$$ValidationAnswerImplCopyWithImpl<$Res>
    extends _$ValidationAnswerCopyWithImpl<$Res, _$ValidationAnswerImpl>
    implements _$$ValidationAnswerImplCopyWith<$Res> {
  __$$ValidationAnswerImplCopyWithImpl(
    _$ValidationAnswerImpl _value,
    $Res Function(_$ValidationAnswerImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of ValidationAnswer
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? question = null,
    Object? userAnswer = null,
    Object? isCorrect = null,
    Object? hint = freezed,
  }) {
    return _then(
      _$ValidationAnswerImpl(
        question: null == question
            ? _value.question
            : question // ignore: cast_nullable_to_non_nullable
                  as String,
        userAnswer: null == userAnswer
            ? _value.userAnswer
            : userAnswer // ignore: cast_nullable_to_non_nullable
                  as String,
        isCorrect: null == isCorrect
            ? _value.isCorrect
            : isCorrect // ignore: cast_nullable_to_non_nullable
                  as bool,
        hint: freezed == hint
            ? _value.hint
            : hint // ignore: cast_nullable_to_non_nullable
                  as String?,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$ValidationAnswerImpl implements _ValidationAnswer {
  const _$ValidationAnswerImpl({
    required this.question,
    required this.userAnswer,
    required this.isCorrect,
    this.hint,
  });

  factory _$ValidationAnswerImpl.fromJson(Map<String, dynamic> json) =>
      _$$ValidationAnswerImplFromJson(json);

  @override
  final String question;
  @override
  final String userAnswer;
  @override
  final bool isCorrect;
  @override
  final String? hint;

  @override
  String toString() {
    return 'ValidationAnswer(question: $question, userAnswer: $userAnswer, isCorrect: $isCorrect, hint: $hint)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ValidationAnswerImpl &&
            (identical(other.question, question) ||
                other.question == question) &&
            (identical(other.userAnswer, userAnswer) ||
                other.userAnswer == userAnswer) &&
            (identical(other.isCorrect, isCorrect) ||
                other.isCorrect == isCorrect) &&
            (identical(other.hint, hint) || other.hint == hint));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode =>
      Object.hash(runtimeType, question, userAnswer, isCorrect, hint);

  /// Create a copy of ValidationAnswer
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ValidationAnswerImplCopyWith<_$ValidationAnswerImpl> get copyWith =>
      __$$ValidationAnswerImplCopyWithImpl<_$ValidationAnswerImpl>(
        this,
        _$identity,
      );

  @override
  Map<String, dynamic> toJson() {
    return _$$ValidationAnswerImplToJson(this);
  }
}

abstract class _ValidationAnswer implements ValidationAnswer {
  const factory _ValidationAnswer({
    required final String question,
    required final String userAnswer,
    required final bool isCorrect,
    final String? hint,
  }) = _$ValidationAnswerImpl;

  factory _ValidationAnswer.fromJson(Map<String, dynamic> json) =
      _$ValidationAnswerImpl.fromJson;

  @override
  String get question;
  @override
  String get userAnswer;
  @override
  bool get isCorrect;
  @override
  String? get hint;

  /// Create a copy of ValidationAnswer
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ValidationAnswerImplCopyWith<_$ValidationAnswerImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
