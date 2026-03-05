// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'ai_coach_context.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

AICoachContext _$AICoachContextFromJson(Map<String, dynamic> json) {
  return _AICoachContext.fromJson(json);
}

/// @nodoc
mixin _$AICoachContext {
  // Project Context
  String get projectId => throw _privateConstructorUsedError;
  String get projectTitle => throw _privateConstructorUsedError;
  ProjectContext get projectContext =>
      throw _privateConstructorUsedError; // Current Position
  String get currentModuleId => throw _privateConstructorUsedError;
  String get currentStageId => throw _privateConstructorUsedError;
  StageType get stageType => throw _privateConstructorUsedError;
  StageContent get stageContent =>
      throw _privateConstructorUsedError; // User Progress
  List<String> get completedStages => throw _privateConstructorUsedError;
  LearningAnalytics get analytics =>
      throw _privateConstructorUsedError; // Conversation History
  List<ChatMessage>? get previousMessages =>
      throw _privateConstructorUsedError; // Coaching Mode
  CoachingMode get mode => throw _privateConstructorUsedError;

  /// Serializes this AICoachContext to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of AICoachContext
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $AICoachContextCopyWith<AICoachContext> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $AICoachContextCopyWith<$Res> {
  factory $AICoachContextCopyWith(
    AICoachContext value,
    $Res Function(AICoachContext) then,
  ) = _$AICoachContextCopyWithImpl<$Res, AICoachContext>;
  @useResult
  $Res call({
    String projectId,
    String projectTitle,
    ProjectContext projectContext,
    String currentModuleId,
    String currentStageId,
    StageType stageType,
    StageContent stageContent,
    List<String> completedStages,
    LearningAnalytics analytics,
    List<ChatMessage>? previousMessages,
    CoachingMode mode,
  });

  $ProjectContextCopyWith<$Res> get projectContext;
  $StageContentCopyWith<$Res> get stageContent;
  $LearningAnalyticsCopyWith<$Res> get analytics;
}

/// @nodoc
class _$AICoachContextCopyWithImpl<$Res, $Val extends AICoachContext>
    implements $AICoachContextCopyWith<$Res> {
  _$AICoachContextCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of AICoachContext
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? projectId = null,
    Object? projectTitle = null,
    Object? projectContext = null,
    Object? currentModuleId = null,
    Object? currentStageId = null,
    Object? stageType = null,
    Object? stageContent = null,
    Object? completedStages = null,
    Object? analytics = null,
    Object? previousMessages = freezed,
    Object? mode = null,
  }) {
    return _then(
      _value.copyWith(
            projectId: null == projectId
                ? _value.projectId
                : projectId // ignore: cast_nullable_to_non_nullable
                      as String,
            projectTitle: null == projectTitle
                ? _value.projectTitle
                : projectTitle // ignore: cast_nullable_to_non_nullable
                      as String,
            projectContext: null == projectContext
                ? _value.projectContext
                : projectContext // ignore: cast_nullable_to_non_nullable
                      as ProjectContext,
            currentModuleId: null == currentModuleId
                ? _value.currentModuleId
                : currentModuleId // ignore: cast_nullable_to_non_nullable
                      as String,
            currentStageId: null == currentStageId
                ? _value.currentStageId
                : currentStageId // ignore: cast_nullable_to_non_nullable
                      as String,
            stageType: null == stageType
                ? _value.stageType
                : stageType // ignore: cast_nullable_to_non_nullable
                      as StageType,
            stageContent: null == stageContent
                ? _value.stageContent
                : stageContent // ignore: cast_nullable_to_non_nullable
                      as StageContent,
            completedStages: null == completedStages
                ? _value.completedStages
                : completedStages // ignore: cast_nullable_to_non_nullable
                      as List<String>,
            analytics: null == analytics
                ? _value.analytics
                : analytics // ignore: cast_nullable_to_non_nullable
                      as LearningAnalytics,
            previousMessages: freezed == previousMessages
                ? _value.previousMessages
                : previousMessages // ignore: cast_nullable_to_non_nullable
                      as List<ChatMessage>?,
            mode: null == mode
                ? _value.mode
                : mode // ignore: cast_nullable_to_non_nullable
                      as CoachingMode,
          )
          as $Val,
    );
  }

  /// Create a copy of AICoachContext
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $ProjectContextCopyWith<$Res> get projectContext {
    return $ProjectContextCopyWith<$Res>(_value.projectContext, (value) {
      return _then(_value.copyWith(projectContext: value) as $Val);
    });
  }

  /// Create a copy of AICoachContext
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $StageContentCopyWith<$Res> get stageContent {
    return $StageContentCopyWith<$Res>(_value.stageContent, (value) {
      return _then(_value.copyWith(stageContent: value) as $Val);
    });
  }

  /// Create a copy of AICoachContext
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $LearningAnalyticsCopyWith<$Res> get analytics {
    return $LearningAnalyticsCopyWith<$Res>(_value.analytics, (value) {
      return _then(_value.copyWith(analytics: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$AICoachContextImplCopyWith<$Res>
    implements $AICoachContextCopyWith<$Res> {
  factory _$$AICoachContextImplCopyWith(
    _$AICoachContextImpl value,
    $Res Function(_$AICoachContextImpl) then,
  ) = __$$AICoachContextImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String projectId,
    String projectTitle,
    ProjectContext projectContext,
    String currentModuleId,
    String currentStageId,
    StageType stageType,
    StageContent stageContent,
    List<String> completedStages,
    LearningAnalytics analytics,
    List<ChatMessage>? previousMessages,
    CoachingMode mode,
  });

  @override
  $ProjectContextCopyWith<$Res> get projectContext;
  @override
  $StageContentCopyWith<$Res> get stageContent;
  @override
  $LearningAnalyticsCopyWith<$Res> get analytics;
}

/// @nodoc
class __$$AICoachContextImplCopyWithImpl<$Res>
    extends _$AICoachContextCopyWithImpl<$Res, _$AICoachContextImpl>
    implements _$$AICoachContextImplCopyWith<$Res> {
  __$$AICoachContextImplCopyWithImpl(
    _$AICoachContextImpl _value,
    $Res Function(_$AICoachContextImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of AICoachContext
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? projectId = null,
    Object? projectTitle = null,
    Object? projectContext = null,
    Object? currentModuleId = null,
    Object? currentStageId = null,
    Object? stageType = null,
    Object? stageContent = null,
    Object? completedStages = null,
    Object? analytics = null,
    Object? previousMessages = freezed,
    Object? mode = null,
  }) {
    return _then(
      _$AICoachContextImpl(
        projectId: null == projectId
            ? _value.projectId
            : projectId // ignore: cast_nullable_to_non_nullable
                  as String,
        projectTitle: null == projectTitle
            ? _value.projectTitle
            : projectTitle // ignore: cast_nullable_to_non_nullable
                  as String,
        projectContext: null == projectContext
            ? _value.projectContext
            : projectContext // ignore: cast_nullable_to_non_nullable
                  as ProjectContext,
        currentModuleId: null == currentModuleId
            ? _value.currentModuleId
            : currentModuleId // ignore: cast_nullable_to_non_nullable
                  as String,
        currentStageId: null == currentStageId
            ? _value.currentStageId
            : currentStageId // ignore: cast_nullable_to_non_nullable
                  as String,
        stageType: null == stageType
            ? _value.stageType
            : stageType // ignore: cast_nullable_to_non_nullable
                  as StageType,
        stageContent: null == stageContent
            ? _value.stageContent
            : stageContent // ignore: cast_nullable_to_non_nullable
                  as StageContent,
        completedStages: null == completedStages
            ? _value._completedStages
            : completedStages // ignore: cast_nullable_to_non_nullable
                  as List<String>,
        analytics: null == analytics
            ? _value.analytics
            : analytics // ignore: cast_nullable_to_non_nullable
                  as LearningAnalytics,
        previousMessages: freezed == previousMessages
            ? _value._previousMessages
            : previousMessages // ignore: cast_nullable_to_non_nullable
                  as List<ChatMessage>?,
        mode: null == mode
            ? _value.mode
            : mode // ignore: cast_nullable_to_non_nullable
                  as CoachingMode,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$AICoachContextImpl extends _AICoachContext {
  const _$AICoachContextImpl({
    required this.projectId,
    required this.projectTitle,
    required this.projectContext,
    required this.currentModuleId,
    required this.currentStageId,
    required this.stageType,
    required this.stageContent,
    final List<String> completedStages = const [],
    required this.analytics,
    final List<ChatMessage>? previousMessages,
    required this.mode,
  }) : _completedStages = completedStages,
       _previousMessages = previousMessages,
       super._();

  factory _$AICoachContextImpl.fromJson(Map<String, dynamic> json) =>
      _$$AICoachContextImplFromJson(json);

  // Project Context
  @override
  final String projectId;
  @override
  final String projectTitle;
  @override
  final ProjectContext projectContext;
  // Current Position
  @override
  final String currentModuleId;
  @override
  final String currentStageId;
  @override
  final StageType stageType;
  @override
  final StageContent stageContent;
  // User Progress
  final List<String> _completedStages;
  // User Progress
  @override
  @JsonKey()
  List<String> get completedStages {
    if (_completedStages is EqualUnmodifiableListView) return _completedStages;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_completedStages);
  }

  @override
  final LearningAnalytics analytics;
  // Conversation History
  final List<ChatMessage>? _previousMessages;
  // Conversation History
  @override
  List<ChatMessage>? get previousMessages {
    final value = _previousMessages;
    if (value == null) return null;
    if (_previousMessages is EqualUnmodifiableListView)
      return _previousMessages;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  // Coaching Mode
  @override
  final CoachingMode mode;

  @override
  String toString() {
    return 'AICoachContext(projectId: $projectId, projectTitle: $projectTitle, projectContext: $projectContext, currentModuleId: $currentModuleId, currentStageId: $currentStageId, stageType: $stageType, stageContent: $stageContent, completedStages: $completedStages, analytics: $analytics, previousMessages: $previousMessages, mode: $mode)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$AICoachContextImpl &&
            (identical(other.projectId, projectId) ||
                other.projectId == projectId) &&
            (identical(other.projectTitle, projectTitle) ||
                other.projectTitle == projectTitle) &&
            (identical(other.projectContext, projectContext) ||
                other.projectContext == projectContext) &&
            (identical(other.currentModuleId, currentModuleId) ||
                other.currentModuleId == currentModuleId) &&
            (identical(other.currentStageId, currentStageId) ||
                other.currentStageId == currentStageId) &&
            (identical(other.stageType, stageType) ||
                other.stageType == stageType) &&
            (identical(other.stageContent, stageContent) ||
                other.stageContent == stageContent) &&
            const DeepCollectionEquality().equals(
              other._completedStages,
              _completedStages,
            ) &&
            (identical(other.analytics, analytics) ||
                other.analytics == analytics) &&
            const DeepCollectionEquality().equals(
              other._previousMessages,
              _previousMessages,
            ) &&
            (identical(other.mode, mode) || other.mode == mode));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    projectId,
    projectTitle,
    projectContext,
    currentModuleId,
    currentStageId,
    stageType,
    stageContent,
    const DeepCollectionEquality().hash(_completedStages),
    analytics,
    const DeepCollectionEquality().hash(_previousMessages),
    mode,
  );

  /// Create a copy of AICoachContext
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$AICoachContextImplCopyWith<_$AICoachContextImpl> get copyWith =>
      __$$AICoachContextImplCopyWithImpl<_$AICoachContextImpl>(
        this,
        _$identity,
      );

  @override
  Map<String, dynamic> toJson() {
    return _$$AICoachContextImplToJson(this);
  }
}

abstract class _AICoachContext extends AICoachContext {
  const factory _AICoachContext({
    required final String projectId,
    required final String projectTitle,
    required final ProjectContext projectContext,
    required final String currentModuleId,
    required final String currentStageId,
    required final StageType stageType,
    required final StageContent stageContent,
    final List<String> completedStages,
    required final LearningAnalytics analytics,
    final List<ChatMessage>? previousMessages,
    required final CoachingMode mode,
  }) = _$AICoachContextImpl;
  const _AICoachContext._() : super._();

  factory _AICoachContext.fromJson(Map<String, dynamic> json) =
      _$AICoachContextImpl.fromJson;

  // Project Context
  @override
  String get projectId;
  @override
  String get projectTitle;
  @override
  ProjectContext get projectContext; // Current Position
  @override
  String get currentModuleId;
  @override
  String get currentStageId;
  @override
  StageType get stageType;
  @override
  StageContent get stageContent; // User Progress
  @override
  List<String> get completedStages;
  @override
  LearningAnalytics get analytics; // Conversation History
  @override
  List<ChatMessage>? get previousMessages; // Coaching Mode
  @override
  CoachingMode get mode;

  /// Create a copy of AICoachContext
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$AICoachContextImplCopyWith<_$AICoachContextImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
