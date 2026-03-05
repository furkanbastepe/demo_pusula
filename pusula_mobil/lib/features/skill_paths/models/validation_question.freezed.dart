// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'validation_question.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

ValidationQuestion _$ValidationQuestionFromJson(Map<String, dynamic> json) {
  return _ValidationQuestion.fromJson(json);
}

/// @nodoc
mixin _$ValidationQuestion {
  String get question => throw _privateConstructorUsedError;
  String get expectedKeywords =>
      throw _privateConstructorUsedError; // Keywords AI should look for
  String get hint => throw _privateConstructorUsedError;

  /// Serializes this ValidationQuestion to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of ValidationQuestion
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $ValidationQuestionCopyWith<ValidationQuestion> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ValidationQuestionCopyWith<$Res> {
  factory $ValidationQuestionCopyWith(
    ValidationQuestion value,
    $Res Function(ValidationQuestion) then,
  ) = _$ValidationQuestionCopyWithImpl<$Res, ValidationQuestion>;
  @useResult
  $Res call({String question, String expectedKeywords, String hint});
}

/// @nodoc
class _$ValidationQuestionCopyWithImpl<$Res, $Val extends ValidationQuestion>
    implements $ValidationQuestionCopyWith<$Res> {
  _$ValidationQuestionCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of ValidationQuestion
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? question = null,
    Object? expectedKeywords = null,
    Object? hint = null,
  }) {
    return _then(
      _value.copyWith(
            question: null == question
                ? _value.question
                : question // ignore: cast_nullable_to_non_nullable
                      as String,
            expectedKeywords: null == expectedKeywords
                ? _value.expectedKeywords
                : expectedKeywords // ignore: cast_nullable_to_non_nullable
                      as String,
            hint: null == hint
                ? _value.hint
                : hint // ignore: cast_nullable_to_non_nullable
                      as String,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$ValidationQuestionImplCopyWith<$Res>
    implements $ValidationQuestionCopyWith<$Res> {
  factory _$$ValidationQuestionImplCopyWith(
    _$ValidationQuestionImpl value,
    $Res Function(_$ValidationQuestionImpl) then,
  ) = __$$ValidationQuestionImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String question, String expectedKeywords, String hint});
}

/// @nodoc
class __$$ValidationQuestionImplCopyWithImpl<$Res>
    extends _$ValidationQuestionCopyWithImpl<$Res, _$ValidationQuestionImpl>
    implements _$$ValidationQuestionImplCopyWith<$Res> {
  __$$ValidationQuestionImplCopyWithImpl(
    _$ValidationQuestionImpl _value,
    $Res Function(_$ValidationQuestionImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of ValidationQuestion
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? question = null,
    Object? expectedKeywords = null,
    Object? hint = null,
  }) {
    return _then(
      _$ValidationQuestionImpl(
        question: null == question
            ? _value.question
            : question // ignore: cast_nullable_to_non_nullable
                  as String,
        expectedKeywords: null == expectedKeywords
            ? _value.expectedKeywords
            : expectedKeywords // ignore: cast_nullable_to_non_nullable
                  as String,
        hint: null == hint
            ? _value.hint
            : hint // ignore: cast_nullable_to_non_nullable
                  as String,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$ValidationQuestionImpl implements _ValidationQuestion {
  const _$ValidationQuestionImpl({
    required this.question,
    required this.expectedKeywords,
    required this.hint,
  });

  factory _$ValidationQuestionImpl.fromJson(Map<String, dynamic> json) =>
      _$$ValidationQuestionImplFromJson(json);

  @override
  final String question;
  @override
  final String expectedKeywords;
  // Keywords AI should look for
  @override
  final String hint;

  @override
  String toString() {
    return 'ValidationQuestion(question: $question, expectedKeywords: $expectedKeywords, hint: $hint)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ValidationQuestionImpl &&
            (identical(other.question, question) ||
                other.question == question) &&
            (identical(other.expectedKeywords, expectedKeywords) ||
                other.expectedKeywords == expectedKeywords) &&
            (identical(other.hint, hint) || other.hint == hint));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode =>
      Object.hash(runtimeType, question, expectedKeywords, hint);

  /// Create a copy of ValidationQuestion
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ValidationQuestionImplCopyWith<_$ValidationQuestionImpl> get copyWith =>
      __$$ValidationQuestionImplCopyWithImpl<_$ValidationQuestionImpl>(
        this,
        _$identity,
      );

  @override
  Map<String, dynamic> toJson() {
    return _$$ValidationQuestionImplToJson(this);
  }
}

abstract class _ValidationQuestion implements ValidationQuestion {
  const factory _ValidationQuestion({
    required final String question,
    required final String expectedKeywords,
    required final String hint,
  }) = _$ValidationQuestionImpl;

  factory _ValidationQuestion.fromJson(Map<String, dynamic> json) =
      _$ValidationQuestionImpl.fromJson;

  @override
  String get question;
  @override
  String get expectedKeywords; // Keywords AI should look for
  @override
  String get hint;

  /// Create a copy of ValidationQuestion
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ValidationQuestionImplCopyWith<_$ValidationQuestionImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
