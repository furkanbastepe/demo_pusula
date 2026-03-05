// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'stage_content.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

StageContent _$StageContentFromJson(Map<String, dynamic> json) {
  switch (json['type']) {
    case 'learn':
      return LearnContent.fromJson(json);
    case 'apply':
      return ApplyContent.fromJson(json);

    default:
      throw CheckedFromJsonException(
        json,
        'type',
        'StageContent',
        'Invalid union type "${json['type']}"!',
      );
  }
}

/// @nodoc
mixin _$StageContent {
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(
      String concept,
      String definition,
      String whyImportant,
      String howItWorks,
      List<String> examples,
      String? visualAid,
    )
    learn,
    required TResult Function(
      String task,
      String deliverable,
      List<String> steps,
      List<String> tools,
      String exampleOutput,
      List<String> commonMistakes,
      List<ValidationQuestion> validationQuestions,
    )
    apply,
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(
      String concept,
      String definition,
      String whyImportant,
      String howItWorks,
      List<String> examples,
      String? visualAid,
    )?
    learn,
    TResult? Function(
      String task,
      String deliverable,
      List<String> steps,
      List<String> tools,
      String exampleOutput,
      List<String> commonMistakes,
      List<ValidationQuestion> validationQuestions,
    )?
    apply,
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(
      String concept,
      String definition,
      String whyImportant,
      String howItWorks,
      List<String> examples,
      String? visualAid,
    )?
    learn,
    TResult Function(
      String task,
      String deliverable,
      List<String> steps,
      List<String> tools,
      String exampleOutput,
      List<String> commonMistakes,
      List<ValidationQuestion> validationQuestions,
    )?
    apply,
    required TResult orElse(),
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(LearnContent value) learn,
    required TResult Function(ApplyContent value) apply,
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(LearnContent value)? learn,
    TResult? Function(ApplyContent value)? apply,
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(LearnContent value)? learn,
    TResult Function(ApplyContent value)? apply,
    required TResult orElse(),
  }) => throw _privateConstructorUsedError;

  /// Serializes this StageContent to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $StageContentCopyWith<$Res> {
  factory $StageContentCopyWith(
    StageContent value,
    $Res Function(StageContent) then,
  ) = _$StageContentCopyWithImpl<$Res, StageContent>;
}

/// @nodoc
class _$StageContentCopyWithImpl<$Res, $Val extends StageContent>
    implements $StageContentCopyWith<$Res> {
  _$StageContentCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of StageContent
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc
abstract class _$$LearnContentImplCopyWith<$Res> {
  factory _$$LearnContentImplCopyWith(
    _$LearnContentImpl value,
    $Res Function(_$LearnContentImpl) then,
  ) = __$$LearnContentImplCopyWithImpl<$Res>;
  @useResult
  $Res call({
    String concept,
    String definition,
    String whyImportant,
    String howItWorks,
    List<String> examples,
    String? visualAid,
  });
}

/// @nodoc
class __$$LearnContentImplCopyWithImpl<$Res>
    extends _$StageContentCopyWithImpl<$Res, _$LearnContentImpl>
    implements _$$LearnContentImplCopyWith<$Res> {
  __$$LearnContentImplCopyWithImpl(
    _$LearnContentImpl _value,
    $Res Function(_$LearnContentImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of StageContent
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? concept = null,
    Object? definition = null,
    Object? whyImportant = null,
    Object? howItWorks = null,
    Object? examples = null,
    Object? visualAid = freezed,
  }) {
    return _then(
      _$LearnContentImpl(
        concept: null == concept
            ? _value.concept
            : concept // ignore: cast_nullable_to_non_nullable
                  as String,
        definition: null == definition
            ? _value.definition
            : definition // ignore: cast_nullable_to_non_nullable
                  as String,
        whyImportant: null == whyImportant
            ? _value.whyImportant
            : whyImportant // ignore: cast_nullable_to_non_nullable
                  as String,
        howItWorks: null == howItWorks
            ? _value.howItWorks
            : howItWorks // ignore: cast_nullable_to_non_nullable
                  as String,
        examples: null == examples
            ? _value._examples
            : examples // ignore: cast_nullable_to_non_nullable
                  as List<String>,
        visualAid: freezed == visualAid
            ? _value.visualAid
            : visualAid // ignore: cast_nullable_to_non_nullable
                  as String?,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$LearnContentImpl implements LearnContent {
  const _$LearnContentImpl({
    required this.concept,
    required this.definition,
    required this.whyImportant,
    required this.howItWorks,
    required final List<String> examples,
    this.visualAid,
    final String? $type,
  }) : _examples = examples,
       $type = $type ?? 'learn';

  factory _$LearnContentImpl.fromJson(Map<String, dynamic> json) =>
      _$$LearnContentImplFromJson(json);

  @override
  final String concept;
  @override
  final String definition;
  @override
  final String whyImportant;
  @override
  final String howItWorks;
  final List<String> _examples;
  @override
  List<String> get examples {
    if (_examples is EqualUnmodifiableListView) return _examples;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_examples);
  }

  @override
  final String? visualAid;

  @JsonKey(name: 'type')
  final String $type;

  @override
  String toString() {
    return 'StageContent.learn(concept: $concept, definition: $definition, whyImportant: $whyImportant, howItWorks: $howItWorks, examples: $examples, visualAid: $visualAid)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$LearnContentImpl &&
            (identical(other.concept, concept) || other.concept == concept) &&
            (identical(other.definition, definition) ||
                other.definition == definition) &&
            (identical(other.whyImportant, whyImportant) ||
                other.whyImportant == whyImportant) &&
            (identical(other.howItWorks, howItWorks) ||
                other.howItWorks == howItWorks) &&
            const DeepCollectionEquality().equals(other._examples, _examples) &&
            (identical(other.visualAid, visualAid) ||
                other.visualAid == visualAid));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    concept,
    definition,
    whyImportant,
    howItWorks,
    const DeepCollectionEquality().hash(_examples),
    visualAid,
  );

  /// Create a copy of StageContent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$LearnContentImplCopyWith<_$LearnContentImpl> get copyWith =>
      __$$LearnContentImplCopyWithImpl<_$LearnContentImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(
      String concept,
      String definition,
      String whyImportant,
      String howItWorks,
      List<String> examples,
      String? visualAid,
    )
    learn,
    required TResult Function(
      String task,
      String deliverable,
      List<String> steps,
      List<String> tools,
      String exampleOutput,
      List<String> commonMistakes,
      List<ValidationQuestion> validationQuestions,
    )
    apply,
  }) {
    return learn(
      concept,
      definition,
      whyImportant,
      howItWorks,
      examples,
      visualAid,
    );
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(
      String concept,
      String definition,
      String whyImportant,
      String howItWorks,
      List<String> examples,
      String? visualAid,
    )?
    learn,
    TResult? Function(
      String task,
      String deliverable,
      List<String> steps,
      List<String> tools,
      String exampleOutput,
      List<String> commonMistakes,
      List<ValidationQuestion> validationQuestions,
    )?
    apply,
  }) {
    return learn?.call(
      concept,
      definition,
      whyImportant,
      howItWorks,
      examples,
      visualAid,
    );
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(
      String concept,
      String definition,
      String whyImportant,
      String howItWorks,
      List<String> examples,
      String? visualAid,
    )?
    learn,
    TResult Function(
      String task,
      String deliverable,
      List<String> steps,
      List<String> tools,
      String exampleOutput,
      List<String> commonMistakes,
      List<ValidationQuestion> validationQuestions,
    )?
    apply,
    required TResult orElse(),
  }) {
    if (learn != null) {
      return learn(
        concept,
        definition,
        whyImportant,
        howItWorks,
        examples,
        visualAid,
      );
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(LearnContent value) learn,
    required TResult Function(ApplyContent value) apply,
  }) {
    return learn(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(LearnContent value)? learn,
    TResult? Function(ApplyContent value)? apply,
  }) {
    return learn?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(LearnContent value)? learn,
    TResult Function(ApplyContent value)? apply,
    required TResult orElse(),
  }) {
    if (learn != null) {
      return learn(this);
    }
    return orElse();
  }

  @override
  Map<String, dynamic> toJson() {
    return _$$LearnContentImplToJson(this);
  }
}

abstract class LearnContent implements StageContent {
  const factory LearnContent({
    required final String concept,
    required final String definition,
    required final String whyImportant,
    required final String howItWorks,
    required final List<String> examples,
    final String? visualAid,
  }) = _$LearnContentImpl;

  factory LearnContent.fromJson(Map<String, dynamic> json) =
      _$LearnContentImpl.fromJson;

  String get concept;
  String get definition;
  String get whyImportant;
  String get howItWorks;
  List<String> get examples;
  String? get visualAid;

  /// Create a copy of StageContent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$LearnContentImplCopyWith<_$LearnContentImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$ApplyContentImplCopyWith<$Res> {
  factory _$$ApplyContentImplCopyWith(
    _$ApplyContentImpl value,
    $Res Function(_$ApplyContentImpl) then,
  ) = __$$ApplyContentImplCopyWithImpl<$Res>;
  @useResult
  $Res call({
    String task,
    String deliverable,
    List<String> steps,
    List<String> tools,
    String exampleOutput,
    List<String> commonMistakes,
    List<ValidationQuestion> validationQuestions,
  });
}

/// @nodoc
class __$$ApplyContentImplCopyWithImpl<$Res>
    extends _$StageContentCopyWithImpl<$Res, _$ApplyContentImpl>
    implements _$$ApplyContentImplCopyWith<$Res> {
  __$$ApplyContentImplCopyWithImpl(
    _$ApplyContentImpl _value,
    $Res Function(_$ApplyContentImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of StageContent
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? task = null,
    Object? deliverable = null,
    Object? steps = null,
    Object? tools = null,
    Object? exampleOutput = null,
    Object? commonMistakes = null,
    Object? validationQuestions = null,
  }) {
    return _then(
      _$ApplyContentImpl(
        task: null == task
            ? _value.task
            : task // ignore: cast_nullable_to_non_nullable
                  as String,
        deliverable: null == deliverable
            ? _value.deliverable
            : deliverable // ignore: cast_nullable_to_non_nullable
                  as String,
        steps: null == steps
            ? _value._steps
            : steps // ignore: cast_nullable_to_non_nullable
                  as List<String>,
        tools: null == tools
            ? _value._tools
            : tools // ignore: cast_nullable_to_non_nullable
                  as List<String>,
        exampleOutput: null == exampleOutput
            ? _value.exampleOutput
            : exampleOutput // ignore: cast_nullable_to_non_nullable
                  as String,
        commonMistakes: null == commonMistakes
            ? _value._commonMistakes
            : commonMistakes // ignore: cast_nullable_to_non_nullable
                  as List<String>,
        validationQuestions: null == validationQuestions
            ? _value._validationQuestions
            : validationQuestions // ignore: cast_nullable_to_non_nullable
                  as List<ValidationQuestion>,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$ApplyContentImpl implements ApplyContent {
  const _$ApplyContentImpl({
    required this.task,
    required this.deliverable,
    required final List<String> steps,
    required final List<String> tools,
    required this.exampleOutput,
    required final List<String> commonMistakes,
    required final List<ValidationQuestion> validationQuestions,
    final String? $type,
  }) : _steps = steps,
       _tools = tools,
       _commonMistakes = commonMistakes,
       _validationQuestions = validationQuestions,
       $type = $type ?? 'apply';

  factory _$ApplyContentImpl.fromJson(Map<String, dynamic> json) =>
      _$$ApplyContentImplFromJson(json);

  @override
  final String task;
  @override
  final String deliverable;
  final List<String> _steps;
  @override
  List<String> get steps {
    if (_steps is EqualUnmodifiableListView) return _steps;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_steps);
  }

  final List<String> _tools;
  @override
  List<String> get tools {
    if (_tools is EqualUnmodifiableListView) return _tools;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_tools);
  }

  @override
  final String exampleOutput;
  final List<String> _commonMistakes;
  @override
  List<String> get commonMistakes {
    if (_commonMistakes is EqualUnmodifiableListView) return _commonMistakes;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_commonMistakes);
  }

  final List<ValidationQuestion> _validationQuestions;
  @override
  List<ValidationQuestion> get validationQuestions {
    if (_validationQuestions is EqualUnmodifiableListView)
      return _validationQuestions;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_validationQuestions);
  }

  @JsonKey(name: 'type')
  final String $type;

  @override
  String toString() {
    return 'StageContent.apply(task: $task, deliverable: $deliverable, steps: $steps, tools: $tools, exampleOutput: $exampleOutput, commonMistakes: $commonMistakes, validationQuestions: $validationQuestions)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ApplyContentImpl &&
            (identical(other.task, task) || other.task == task) &&
            (identical(other.deliverable, deliverable) ||
                other.deliverable == deliverable) &&
            const DeepCollectionEquality().equals(other._steps, _steps) &&
            const DeepCollectionEquality().equals(other._tools, _tools) &&
            (identical(other.exampleOutput, exampleOutput) ||
                other.exampleOutput == exampleOutput) &&
            const DeepCollectionEquality().equals(
              other._commonMistakes,
              _commonMistakes,
            ) &&
            const DeepCollectionEquality().equals(
              other._validationQuestions,
              _validationQuestions,
            ));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    task,
    deliverable,
    const DeepCollectionEquality().hash(_steps),
    const DeepCollectionEquality().hash(_tools),
    exampleOutput,
    const DeepCollectionEquality().hash(_commonMistakes),
    const DeepCollectionEquality().hash(_validationQuestions),
  );

  /// Create a copy of StageContent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ApplyContentImplCopyWith<_$ApplyContentImpl> get copyWith =>
      __$$ApplyContentImplCopyWithImpl<_$ApplyContentImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(
      String concept,
      String definition,
      String whyImportant,
      String howItWorks,
      List<String> examples,
      String? visualAid,
    )
    learn,
    required TResult Function(
      String task,
      String deliverable,
      List<String> steps,
      List<String> tools,
      String exampleOutput,
      List<String> commonMistakes,
      List<ValidationQuestion> validationQuestions,
    )
    apply,
  }) {
    return apply(
      task,
      deliverable,
      steps,
      tools,
      exampleOutput,
      commonMistakes,
      validationQuestions,
    );
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(
      String concept,
      String definition,
      String whyImportant,
      String howItWorks,
      List<String> examples,
      String? visualAid,
    )?
    learn,
    TResult? Function(
      String task,
      String deliverable,
      List<String> steps,
      List<String> tools,
      String exampleOutput,
      List<String> commonMistakes,
      List<ValidationQuestion> validationQuestions,
    )?
    apply,
  }) {
    return apply?.call(
      task,
      deliverable,
      steps,
      tools,
      exampleOutput,
      commonMistakes,
      validationQuestions,
    );
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(
      String concept,
      String definition,
      String whyImportant,
      String howItWorks,
      List<String> examples,
      String? visualAid,
    )?
    learn,
    TResult Function(
      String task,
      String deliverable,
      List<String> steps,
      List<String> tools,
      String exampleOutput,
      List<String> commonMistakes,
      List<ValidationQuestion> validationQuestions,
    )?
    apply,
    required TResult orElse(),
  }) {
    if (apply != null) {
      return apply(
        task,
        deliverable,
        steps,
        tools,
        exampleOutput,
        commonMistakes,
        validationQuestions,
      );
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(LearnContent value) learn,
    required TResult Function(ApplyContent value) apply,
  }) {
    return apply(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(LearnContent value)? learn,
    TResult? Function(ApplyContent value)? apply,
  }) {
    return apply?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(LearnContent value)? learn,
    TResult Function(ApplyContent value)? apply,
    required TResult orElse(),
  }) {
    if (apply != null) {
      return apply(this);
    }
    return orElse();
  }

  @override
  Map<String, dynamic> toJson() {
    return _$$ApplyContentImplToJson(this);
  }
}

abstract class ApplyContent implements StageContent {
  const factory ApplyContent({
    required final String task,
    required final String deliverable,
    required final List<String> steps,
    required final List<String> tools,
    required final String exampleOutput,
    required final List<String> commonMistakes,
    required final List<ValidationQuestion> validationQuestions,
  }) = _$ApplyContentImpl;

  factory ApplyContent.fromJson(Map<String, dynamic> json) =
      _$ApplyContentImpl.fromJson;

  String get task;
  String get deliverable;
  List<String> get steps;
  List<String> get tools;
  String get exampleOutput;
  List<String> get commonMistakes;
  List<ValidationQuestion> get validationQuestions;

  /// Create a copy of StageContent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ApplyContentImplCopyWith<_$ApplyContentImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
