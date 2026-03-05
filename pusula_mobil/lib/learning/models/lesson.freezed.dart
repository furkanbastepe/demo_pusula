// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'lesson.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

Lesson _$LessonFromJson(Map<String, dynamic> json) {
  return _Lesson.fromJson(json);
}

/// @nodoc
mixin _$Lesson {
  String get id => throw _privateConstructorUsedError;
  String get courseId => throw _privateConstructorUsedError;
  int get order => throw _privateConstructorUsedError;
  String get title => throw _privateConstructorUsedError;
  List<LessonSection> get sections => throw _privateConstructorUsedError;
  int get xpReward => throw _privateConstructorUsedError;
  int get estimatedTime => throw _privateConstructorUsedError;

  /// Serializes this Lesson to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of Lesson
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $LessonCopyWith<Lesson> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $LessonCopyWith<$Res> {
  factory $LessonCopyWith(Lesson value, $Res Function(Lesson) then) =
      _$LessonCopyWithImpl<$Res, Lesson>;
  @useResult
  $Res call({
    String id,
    String courseId,
    int order,
    String title,
    List<LessonSection> sections,
    int xpReward,
    int estimatedTime,
  });
}

/// @nodoc
class _$LessonCopyWithImpl<$Res, $Val extends Lesson>
    implements $LessonCopyWith<$Res> {
  _$LessonCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of Lesson
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? courseId = null,
    Object? order = null,
    Object? title = null,
    Object? sections = null,
    Object? xpReward = null,
    Object? estimatedTime = null,
  }) {
    return _then(
      _value.copyWith(
            id: null == id
                ? _value.id
                : id // ignore: cast_nullable_to_non_nullable
                      as String,
            courseId: null == courseId
                ? _value.courseId
                : courseId // ignore: cast_nullable_to_non_nullable
                      as String,
            order: null == order
                ? _value.order
                : order // ignore: cast_nullable_to_non_nullable
                      as int,
            title: null == title
                ? _value.title
                : title // ignore: cast_nullable_to_non_nullable
                      as String,
            sections: null == sections
                ? _value.sections
                : sections // ignore: cast_nullable_to_non_nullable
                      as List<LessonSection>,
            xpReward: null == xpReward
                ? _value.xpReward
                : xpReward // ignore: cast_nullable_to_non_nullable
                      as int,
            estimatedTime: null == estimatedTime
                ? _value.estimatedTime
                : estimatedTime // ignore: cast_nullable_to_non_nullable
                      as int,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$LessonImplCopyWith<$Res> implements $LessonCopyWith<$Res> {
  factory _$$LessonImplCopyWith(
    _$LessonImpl value,
    $Res Function(_$LessonImpl) then,
  ) = __$$LessonImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String id,
    String courseId,
    int order,
    String title,
    List<LessonSection> sections,
    int xpReward,
    int estimatedTime,
  });
}

/// @nodoc
class __$$LessonImplCopyWithImpl<$Res>
    extends _$LessonCopyWithImpl<$Res, _$LessonImpl>
    implements _$$LessonImplCopyWith<$Res> {
  __$$LessonImplCopyWithImpl(
    _$LessonImpl _value,
    $Res Function(_$LessonImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of Lesson
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? courseId = null,
    Object? order = null,
    Object? title = null,
    Object? sections = null,
    Object? xpReward = null,
    Object? estimatedTime = null,
  }) {
    return _then(
      _$LessonImpl(
        id: null == id
            ? _value.id
            : id // ignore: cast_nullable_to_non_nullable
                  as String,
        courseId: null == courseId
            ? _value.courseId
            : courseId // ignore: cast_nullable_to_non_nullable
                  as String,
        order: null == order
            ? _value.order
            : order // ignore: cast_nullable_to_non_nullable
                  as int,
        title: null == title
            ? _value.title
            : title // ignore: cast_nullable_to_non_nullable
                  as String,
        sections: null == sections
            ? _value._sections
            : sections // ignore: cast_nullable_to_non_nullable
                  as List<LessonSection>,
        xpReward: null == xpReward
            ? _value.xpReward
            : xpReward // ignore: cast_nullable_to_non_nullable
                  as int,
        estimatedTime: null == estimatedTime
            ? _value.estimatedTime
            : estimatedTime // ignore: cast_nullable_to_non_nullable
                  as int,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$LessonImpl extends _Lesson {
  const _$LessonImpl({
    required this.id,
    required this.courseId,
    required this.order,
    required this.title,
    required final List<LessonSection> sections,
    required this.xpReward,
    required this.estimatedTime,
  }) : _sections = sections,
       super._();

  factory _$LessonImpl.fromJson(Map<String, dynamic> json) =>
      _$$LessonImplFromJson(json);

  @override
  final String id;
  @override
  final String courseId;
  @override
  final int order;
  @override
  final String title;
  final List<LessonSection> _sections;
  @override
  List<LessonSection> get sections {
    if (_sections is EqualUnmodifiableListView) return _sections;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_sections);
  }

  @override
  final int xpReward;
  @override
  final int estimatedTime;

  @override
  String toString() {
    return 'Lesson(id: $id, courseId: $courseId, order: $order, title: $title, sections: $sections, xpReward: $xpReward, estimatedTime: $estimatedTime)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$LessonImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.courseId, courseId) ||
                other.courseId == courseId) &&
            (identical(other.order, order) || other.order == order) &&
            (identical(other.title, title) || other.title == title) &&
            const DeepCollectionEquality().equals(other._sections, _sections) &&
            (identical(other.xpReward, xpReward) ||
                other.xpReward == xpReward) &&
            (identical(other.estimatedTime, estimatedTime) ||
                other.estimatedTime == estimatedTime));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    id,
    courseId,
    order,
    title,
    const DeepCollectionEquality().hash(_sections),
    xpReward,
    estimatedTime,
  );

  /// Create a copy of Lesson
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$LessonImplCopyWith<_$LessonImpl> get copyWith =>
      __$$LessonImplCopyWithImpl<_$LessonImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$LessonImplToJson(this);
  }
}

abstract class _Lesson extends Lesson {
  const factory _Lesson({
    required final String id,
    required final String courseId,
    required final int order,
    required final String title,
    required final List<LessonSection> sections,
    required final int xpReward,
    required final int estimatedTime,
  }) = _$LessonImpl;
  const _Lesson._() : super._();

  factory _Lesson.fromJson(Map<String, dynamic> json) = _$LessonImpl.fromJson;

  @override
  String get id;
  @override
  String get courseId;
  @override
  int get order;
  @override
  String get title;
  @override
  List<LessonSection> get sections;
  @override
  int get xpReward;
  @override
  int get estimatedTime;

  /// Create a copy of Lesson
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$LessonImplCopyWith<_$LessonImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

ContentData _$ContentDataFromJson(Map<String, dynamic> json) {
  return _ContentData.fromJson(json);
}

/// @nodoc
mixin _$ContentData {
  String get markdown => throw _privateConstructorUsedError;
  List<String>? get imageUrls => throw _privateConstructorUsedError;
  Map<String, dynamic>? get examples => throw _privateConstructorUsedError;

  /// Serializes this ContentData to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of ContentData
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $ContentDataCopyWith<ContentData> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ContentDataCopyWith<$Res> {
  factory $ContentDataCopyWith(
    ContentData value,
    $Res Function(ContentData) then,
  ) = _$ContentDataCopyWithImpl<$Res, ContentData>;
  @useResult
  $Res call({
    String markdown,
    List<String>? imageUrls,
    Map<String, dynamic>? examples,
  });
}

/// @nodoc
class _$ContentDataCopyWithImpl<$Res, $Val extends ContentData>
    implements $ContentDataCopyWith<$Res> {
  _$ContentDataCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of ContentData
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? markdown = null,
    Object? imageUrls = freezed,
    Object? examples = freezed,
  }) {
    return _then(
      _value.copyWith(
            markdown: null == markdown
                ? _value.markdown
                : markdown // ignore: cast_nullable_to_non_nullable
                      as String,
            imageUrls: freezed == imageUrls
                ? _value.imageUrls
                : imageUrls // ignore: cast_nullable_to_non_nullable
                      as List<String>?,
            examples: freezed == examples
                ? _value.examples
                : examples // ignore: cast_nullable_to_non_nullable
                      as Map<String, dynamic>?,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$ContentDataImplCopyWith<$Res>
    implements $ContentDataCopyWith<$Res> {
  factory _$$ContentDataImplCopyWith(
    _$ContentDataImpl value,
    $Res Function(_$ContentDataImpl) then,
  ) = __$$ContentDataImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String markdown,
    List<String>? imageUrls,
    Map<String, dynamic>? examples,
  });
}

/// @nodoc
class __$$ContentDataImplCopyWithImpl<$Res>
    extends _$ContentDataCopyWithImpl<$Res, _$ContentDataImpl>
    implements _$$ContentDataImplCopyWith<$Res> {
  __$$ContentDataImplCopyWithImpl(
    _$ContentDataImpl _value,
    $Res Function(_$ContentDataImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of ContentData
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? markdown = null,
    Object? imageUrls = freezed,
    Object? examples = freezed,
  }) {
    return _then(
      _$ContentDataImpl(
        markdown: null == markdown
            ? _value.markdown
            : markdown // ignore: cast_nullable_to_non_nullable
                  as String,
        imageUrls: freezed == imageUrls
            ? _value._imageUrls
            : imageUrls // ignore: cast_nullable_to_non_nullable
                  as List<String>?,
        examples: freezed == examples
            ? _value._examples
            : examples // ignore: cast_nullable_to_non_nullable
                  as Map<String, dynamic>?,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$ContentDataImpl implements _ContentData {
  const _$ContentDataImpl({
    required this.markdown,
    final List<String>? imageUrls,
    final Map<String, dynamic>? examples,
  }) : _imageUrls = imageUrls,
       _examples = examples;

  factory _$ContentDataImpl.fromJson(Map<String, dynamic> json) =>
      _$$ContentDataImplFromJson(json);

  @override
  final String markdown;
  final List<String>? _imageUrls;
  @override
  List<String>? get imageUrls {
    final value = _imageUrls;
    if (value == null) return null;
    if (_imageUrls is EqualUnmodifiableListView) return _imageUrls;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  final Map<String, dynamic>? _examples;
  @override
  Map<String, dynamic>? get examples {
    final value = _examples;
    if (value == null) return null;
    if (_examples is EqualUnmodifiableMapView) return _examples;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(value);
  }

  @override
  String toString() {
    return 'ContentData(markdown: $markdown, imageUrls: $imageUrls, examples: $examples)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ContentDataImpl &&
            (identical(other.markdown, markdown) ||
                other.markdown == markdown) &&
            const DeepCollectionEquality().equals(
              other._imageUrls,
              _imageUrls,
            ) &&
            const DeepCollectionEquality().equals(other._examples, _examples));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    markdown,
    const DeepCollectionEquality().hash(_imageUrls),
    const DeepCollectionEquality().hash(_examples),
  );

  /// Create a copy of ContentData
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ContentDataImplCopyWith<_$ContentDataImpl> get copyWith =>
      __$$ContentDataImplCopyWithImpl<_$ContentDataImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$ContentDataImplToJson(this);
  }
}

abstract class _ContentData implements ContentData {
  const factory _ContentData({
    required final String markdown,
    final List<String>? imageUrls,
    final Map<String, dynamic>? examples,
  }) = _$ContentDataImpl;

  factory _ContentData.fromJson(Map<String, dynamic> json) =
      _$ContentDataImpl.fromJson;

  @override
  String get markdown;
  @override
  List<String>? get imageUrls;
  @override
  Map<String, dynamic>? get examples;

  /// Create a copy of ContentData
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ContentDataImplCopyWith<_$ContentDataImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

QuizData _$QuizDataFromJson(Map<String, dynamic> json) {
  return _QuizData.fromJson(json);
}

/// @nodoc
mixin _$QuizData {
  String get question => throw _privateConstructorUsedError;
  List<String> get options => throw _privateConstructorUsedError;
  int get correctAnswerIndex => throw _privateConstructorUsedError;
  String get explanation => throw _privateConstructorUsedError;
  int get xpReward => throw _privateConstructorUsedError;

  /// Serializes this QuizData to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of QuizData
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $QuizDataCopyWith<QuizData> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $QuizDataCopyWith<$Res> {
  factory $QuizDataCopyWith(QuizData value, $Res Function(QuizData) then) =
      _$QuizDataCopyWithImpl<$Res, QuizData>;
  @useResult
  $Res call({
    String question,
    List<String> options,
    int correctAnswerIndex,
    String explanation,
    int xpReward,
  });
}

/// @nodoc
class _$QuizDataCopyWithImpl<$Res, $Val extends QuizData>
    implements $QuizDataCopyWith<$Res> {
  _$QuizDataCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of QuizData
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? question = null,
    Object? options = null,
    Object? correctAnswerIndex = null,
    Object? explanation = null,
    Object? xpReward = null,
  }) {
    return _then(
      _value.copyWith(
            question: null == question
                ? _value.question
                : question // ignore: cast_nullable_to_non_nullable
                      as String,
            options: null == options
                ? _value.options
                : options // ignore: cast_nullable_to_non_nullable
                      as List<String>,
            correctAnswerIndex: null == correctAnswerIndex
                ? _value.correctAnswerIndex
                : correctAnswerIndex // ignore: cast_nullable_to_non_nullable
                      as int,
            explanation: null == explanation
                ? _value.explanation
                : explanation // ignore: cast_nullable_to_non_nullable
                      as String,
            xpReward: null == xpReward
                ? _value.xpReward
                : xpReward // ignore: cast_nullable_to_non_nullable
                      as int,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$QuizDataImplCopyWith<$Res>
    implements $QuizDataCopyWith<$Res> {
  factory _$$QuizDataImplCopyWith(
    _$QuizDataImpl value,
    $Res Function(_$QuizDataImpl) then,
  ) = __$$QuizDataImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String question,
    List<String> options,
    int correctAnswerIndex,
    String explanation,
    int xpReward,
  });
}

/// @nodoc
class __$$QuizDataImplCopyWithImpl<$Res>
    extends _$QuizDataCopyWithImpl<$Res, _$QuizDataImpl>
    implements _$$QuizDataImplCopyWith<$Res> {
  __$$QuizDataImplCopyWithImpl(
    _$QuizDataImpl _value,
    $Res Function(_$QuizDataImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of QuizData
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? question = null,
    Object? options = null,
    Object? correctAnswerIndex = null,
    Object? explanation = null,
    Object? xpReward = null,
  }) {
    return _then(
      _$QuizDataImpl(
        question: null == question
            ? _value.question
            : question // ignore: cast_nullable_to_non_nullable
                  as String,
        options: null == options
            ? _value._options
            : options // ignore: cast_nullable_to_non_nullable
                  as List<String>,
        correctAnswerIndex: null == correctAnswerIndex
            ? _value.correctAnswerIndex
            : correctAnswerIndex // ignore: cast_nullable_to_non_nullable
                  as int,
        explanation: null == explanation
            ? _value.explanation
            : explanation // ignore: cast_nullable_to_non_nullable
                  as String,
        xpReward: null == xpReward
            ? _value.xpReward
            : xpReward // ignore: cast_nullable_to_non_nullable
                  as int,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$QuizDataImpl implements _QuizData {
  const _$QuizDataImpl({
    required this.question,
    required final List<String> options,
    required this.correctAnswerIndex,
    required this.explanation,
    this.xpReward = 10,
  }) : _options = options;

  factory _$QuizDataImpl.fromJson(Map<String, dynamic> json) =>
      _$$QuizDataImplFromJson(json);

  @override
  final String question;
  final List<String> _options;
  @override
  List<String> get options {
    if (_options is EqualUnmodifiableListView) return _options;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_options);
  }

  @override
  final int correctAnswerIndex;
  @override
  final String explanation;
  @override
  @JsonKey()
  final int xpReward;

  @override
  String toString() {
    return 'QuizData(question: $question, options: $options, correctAnswerIndex: $correctAnswerIndex, explanation: $explanation, xpReward: $xpReward)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$QuizDataImpl &&
            (identical(other.question, question) ||
                other.question == question) &&
            const DeepCollectionEquality().equals(other._options, _options) &&
            (identical(other.correctAnswerIndex, correctAnswerIndex) ||
                other.correctAnswerIndex == correctAnswerIndex) &&
            (identical(other.explanation, explanation) ||
                other.explanation == explanation) &&
            (identical(other.xpReward, xpReward) ||
                other.xpReward == xpReward));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    question,
    const DeepCollectionEquality().hash(_options),
    correctAnswerIndex,
    explanation,
    xpReward,
  );

  /// Create a copy of QuizData
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$QuizDataImplCopyWith<_$QuizDataImpl> get copyWith =>
      __$$QuizDataImplCopyWithImpl<_$QuizDataImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$QuizDataImplToJson(this);
  }
}

abstract class _QuizData implements QuizData {
  const factory _QuizData({
    required final String question,
    required final List<String> options,
    required final int correctAnswerIndex,
    required final String explanation,
    final int xpReward,
  }) = _$QuizDataImpl;

  factory _QuizData.fromJson(Map<String, dynamic> json) =
      _$QuizDataImpl.fromJson;

  @override
  String get question;
  @override
  List<String> get options;
  @override
  int get correctAnswerIndex;
  @override
  String get explanation;
  @override
  int get xpReward;

  /// Create a copy of QuizData
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$QuizDataImplCopyWith<_$QuizDataImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

CodeChallengeData _$CodeChallengeDataFromJson(Map<String, dynamic> json) {
  return _CodeChallengeData.fromJson(json);
}

/// @nodoc
mixin _$CodeChallengeData {
  String get description => throw _privateConstructorUsedError;
  String get codeExample => throw _privateConstructorUsedError;
  List<String> get options => throw _privateConstructorUsedError;
  int get correctAnswerIndex => throw _privateConstructorUsedError;
  String get explanation => throw _privateConstructorUsedError;
  String get detailedSolution => throw _privateConstructorUsedError;
  int get xpReward => throw _privateConstructorUsedError;

  /// Serializes this CodeChallengeData to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of CodeChallengeData
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $CodeChallengeDataCopyWith<CodeChallengeData> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $CodeChallengeDataCopyWith<$Res> {
  factory $CodeChallengeDataCopyWith(
    CodeChallengeData value,
    $Res Function(CodeChallengeData) then,
  ) = _$CodeChallengeDataCopyWithImpl<$Res, CodeChallengeData>;
  @useResult
  $Res call({
    String description,
    String codeExample,
    List<String> options,
    int correctAnswerIndex,
    String explanation,
    String detailedSolution,
    int xpReward,
  });
}

/// @nodoc
class _$CodeChallengeDataCopyWithImpl<$Res, $Val extends CodeChallengeData>
    implements $CodeChallengeDataCopyWith<$Res> {
  _$CodeChallengeDataCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of CodeChallengeData
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? description = null,
    Object? codeExample = null,
    Object? options = null,
    Object? correctAnswerIndex = null,
    Object? explanation = null,
    Object? detailedSolution = null,
    Object? xpReward = null,
  }) {
    return _then(
      _value.copyWith(
            description: null == description
                ? _value.description
                : description // ignore: cast_nullable_to_non_nullable
                      as String,
            codeExample: null == codeExample
                ? _value.codeExample
                : codeExample // ignore: cast_nullable_to_non_nullable
                      as String,
            options: null == options
                ? _value.options
                : options // ignore: cast_nullable_to_non_nullable
                      as List<String>,
            correctAnswerIndex: null == correctAnswerIndex
                ? _value.correctAnswerIndex
                : correctAnswerIndex // ignore: cast_nullable_to_non_nullable
                      as int,
            explanation: null == explanation
                ? _value.explanation
                : explanation // ignore: cast_nullable_to_non_nullable
                      as String,
            detailedSolution: null == detailedSolution
                ? _value.detailedSolution
                : detailedSolution // ignore: cast_nullable_to_non_nullable
                      as String,
            xpReward: null == xpReward
                ? _value.xpReward
                : xpReward // ignore: cast_nullable_to_non_nullable
                      as int,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$CodeChallengeDataImplCopyWith<$Res>
    implements $CodeChallengeDataCopyWith<$Res> {
  factory _$$CodeChallengeDataImplCopyWith(
    _$CodeChallengeDataImpl value,
    $Res Function(_$CodeChallengeDataImpl) then,
  ) = __$$CodeChallengeDataImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String description,
    String codeExample,
    List<String> options,
    int correctAnswerIndex,
    String explanation,
    String detailedSolution,
    int xpReward,
  });
}

/// @nodoc
class __$$CodeChallengeDataImplCopyWithImpl<$Res>
    extends _$CodeChallengeDataCopyWithImpl<$Res, _$CodeChallengeDataImpl>
    implements _$$CodeChallengeDataImplCopyWith<$Res> {
  __$$CodeChallengeDataImplCopyWithImpl(
    _$CodeChallengeDataImpl _value,
    $Res Function(_$CodeChallengeDataImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of CodeChallengeData
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? description = null,
    Object? codeExample = null,
    Object? options = null,
    Object? correctAnswerIndex = null,
    Object? explanation = null,
    Object? detailedSolution = null,
    Object? xpReward = null,
  }) {
    return _then(
      _$CodeChallengeDataImpl(
        description: null == description
            ? _value.description
            : description // ignore: cast_nullable_to_non_nullable
                  as String,
        codeExample: null == codeExample
            ? _value.codeExample
            : codeExample // ignore: cast_nullable_to_non_nullable
                  as String,
        options: null == options
            ? _value._options
            : options // ignore: cast_nullable_to_non_nullable
                  as List<String>,
        correctAnswerIndex: null == correctAnswerIndex
            ? _value.correctAnswerIndex
            : correctAnswerIndex // ignore: cast_nullable_to_non_nullable
                  as int,
        explanation: null == explanation
            ? _value.explanation
            : explanation // ignore: cast_nullable_to_non_nullable
                  as String,
        detailedSolution: null == detailedSolution
            ? _value.detailedSolution
            : detailedSolution // ignore: cast_nullable_to_non_nullable
                  as String,
        xpReward: null == xpReward
            ? _value.xpReward
            : xpReward // ignore: cast_nullable_to_non_nullable
                  as int,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$CodeChallengeDataImpl implements _CodeChallengeData {
  const _$CodeChallengeDataImpl({
    required this.description,
    required this.codeExample,
    required final List<String> options,
    required this.correctAnswerIndex,
    required this.explanation,
    required this.detailedSolution,
    this.xpReward = 30,
  }) : _options = options;

  factory _$CodeChallengeDataImpl.fromJson(Map<String, dynamic> json) =>
      _$$CodeChallengeDataImplFromJson(json);

  @override
  final String description;
  @override
  final String codeExample;
  final List<String> _options;
  @override
  List<String> get options {
    if (_options is EqualUnmodifiableListView) return _options;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_options);
  }

  @override
  final int correctAnswerIndex;
  @override
  final String explanation;
  @override
  final String detailedSolution;
  @override
  @JsonKey()
  final int xpReward;

  @override
  String toString() {
    return 'CodeChallengeData(description: $description, codeExample: $codeExample, options: $options, correctAnswerIndex: $correctAnswerIndex, explanation: $explanation, detailedSolution: $detailedSolution, xpReward: $xpReward)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$CodeChallengeDataImpl &&
            (identical(other.description, description) ||
                other.description == description) &&
            (identical(other.codeExample, codeExample) ||
                other.codeExample == codeExample) &&
            const DeepCollectionEquality().equals(other._options, _options) &&
            (identical(other.correctAnswerIndex, correctAnswerIndex) ||
                other.correctAnswerIndex == correctAnswerIndex) &&
            (identical(other.explanation, explanation) ||
                other.explanation == explanation) &&
            (identical(other.detailedSolution, detailedSolution) ||
                other.detailedSolution == detailedSolution) &&
            (identical(other.xpReward, xpReward) ||
                other.xpReward == xpReward));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    description,
    codeExample,
    const DeepCollectionEquality().hash(_options),
    correctAnswerIndex,
    explanation,
    detailedSolution,
    xpReward,
  );

  /// Create a copy of CodeChallengeData
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$CodeChallengeDataImplCopyWith<_$CodeChallengeDataImpl> get copyWith =>
      __$$CodeChallengeDataImplCopyWithImpl<_$CodeChallengeDataImpl>(
        this,
        _$identity,
      );

  @override
  Map<String, dynamic> toJson() {
    return _$$CodeChallengeDataImplToJson(this);
  }
}

abstract class _CodeChallengeData implements CodeChallengeData {
  const factory _CodeChallengeData({
    required final String description,
    required final String codeExample,
    required final List<String> options,
    required final int correctAnswerIndex,
    required final String explanation,
    required final String detailedSolution,
    final int xpReward,
  }) = _$CodeChallengeDataImpl;

  factory _CodeChallengeData.fromJson(Map<String, dynamic> json) =
      _$CodeChallengeDataImpl.fromJson;

  @override
  String get description;
  @override
  String get codeExample;
  @override
  List<String> get options;
  @override
  int get correctAnswerIndex;
  @override
  String get explanation;
  @override
  String get detailedSolution;
  @override
  int get xpReward;

  /// Create a copy of CodeChallengeData
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$CodeChallengeDataImplCopyWith<_$CodeChallengeDataImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
