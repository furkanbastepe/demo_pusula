// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'project_progress.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

ProjectProgress _$ProjectProgressFromJson(Map<String, dynamic> json) {
  return _ProjectProgress.fromJson(json);
}

/// @nodoc
mixin _$ProjectProgress {
  String get userId => throw _privateConstructorUsedError;
  String get projectId => throw _privateConstructorUsedError; // Module Progress
  Map<String, ModuleProgress> get moduleProgress =>
      throw _privateConstructorUsedError; // moduleId → progress
  String? get currentModuleId => throw _privateConstructorUsedError;
  String? get currentStageId =>
      throw _privateConstructorUsedError; // Overall Progress
  int get earnedXP => throw _privateConstructorUsedError;
  int get totalStagesCompleted => throw _privateConstructorUsedError;
  DateTime get startedAt => throw _privateConstructorUsedError;
  DateTime? get completedAt => throw _privateConstructorUsedError;
  DateTime? get lastActivityAt =>
      throw _privateConstructorUsedError; // Project Submission
  String? get projectLink => throw _privateConstructorUsedError;
  String? get projectDescription => throw _privateConstructorUsedError;
  DateTime? get submittedAt => throw _privateConstructorUsedError; // Atölye
  String? get atolyeSessionId => throw _privateConstructorUsedError;
  DateTime? get atolyeDate => throw _privateConstructorUsedError;
  bool get atolyeCompleted => throw _privateConstructorUsedError; // Analytics
  LearningAnalytics get analytics => throw _privateConstructorUsedError;

  /// Serializes this ProjectProgress to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of ProjectProgress
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $ProjectProgressCopyWith<ProjectProgress> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ProjectProgressCopyWith<$Res> {
  factory $ProjectProgressCopyWith(
    ProjectProgress value,
    $Res Function(ProjectProgress) then,
  ) = _$ProjectProgressCopyWithImpl<$Res, ProjectProgress>;
  @useResult
  $Res call({
    String userId,
    String projectId,
    Map<String, ModuleProgress> moduleProgress,
    String? currentModuleId,
    String? currentStageId,
    int earnedXP,
    int totalStagesCompleted,
    DateTime startedAt,
    DateTime? completedAt,
    DateTime? lastActivityAt,
    String? projectLink,
    String? projectDescription,
    DateTime? submittedAt,
    String? atolyeSessionId,
    DateTime? atolyeDate,
    bool atolyeCompleted,
    LearningAnalytics analytics,
  });

  $LearningAnalyticsCopyWith<$Res> get analytics;
}

/// @nodoc
class _$ProjectProgressCopyWithImpl<$Res, $Val extends ProjectProgress>
    implements $ProjectProgressCopyWith<$Res> {
  _$ProjectProgressCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of ProjectProgress
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? userId = null,
    Object? projectId = null,
    Object? moduleProgress = null,
    Object? currentModuleId = freezed,
    Object? currentStageId = freezed,
    Object? earnedXP = null,
    Object? totalStagesCompleted = null,
    Object? startedAt = null,
    Object? completedAt = freezed,
    Object? lastActivityAt = freezed,
    Object? projectLink = freezed,
    Object? projectDescription = freezed,
    Object? submittedAt = freezed,
    Object? atolyeSessionId = freezed,
    Object? atolyeDate = freezed,
    Object? atolyeCompleted = null,
    Object? analytics = null,
  }) {
    return _then(
      _value.copyWith(
            userId: null == userId
                ? _value.userId
                : userId // ignore: cast_nullable_to_non_nullable
                      as String,
            projectId: null == projectId
                ? _value.projectId
                : projectId // ignore: cast_nullable_to_non_nullable
                      as String,
            moduleProgress: null == moduleProgress
                ? _value.moduleProgress
                : moduleProgress // ignore: cast_nullable_to_non_nullable
                      as Map<String, ModuleProgress>,
            currentModuleId: freezed == currentModuleId
                ? _value.currentModuleId
                : currentModuleId // ignore: cast_nullable_to_non_nullable
                      as String?,
            currentStageId: freezed == currentStageId
                ? _value.currentStageId
                : currentStageId // ignore: cast_nullable_to_non_nullable
                      as String?,
            earnedXP: null == earnedXP
                ? _value.earnedXP
                : earnedXP // ignore: cast_nullable_to_non_nullable
                      as int,
            totalStagesCompleted: null == totalStagesCompleted
                ? _value.totalStagesCompleted
                : totalStagesCompleted // ignore: cast_nullable_to_non_nullable
                      as int,
            startedAt: null == startedAt
                ? _value.startedAt
                : startedAt // ignore: cast_nullable_to_non_nullable
                      as DateTime,
            completedAt: freezed == completedAt
                ? _value.completedAt
                : completedAt // ignore: cast_nullable_to_non_nullable
                      as DateTime?,
            lastActivityAt: freezed == lastActivityAt
                ? _value.lastActivityAt
                : lastActivityAt // ignore: cast_nullable_to_non_nullable
                      as DateTime?,
            projectLink: freezed == projectLink
                ? _value.projectLink
                : projectLink // ignore: cast_nullable_to_non_nullable
                      as String?,
            projectDescription: freezed == projectDescription
                ? _value.projectDescription
                : projectDescription // ignore: cast_nullable_to_non_nullable
                      as String?,
            submittedAt: freezed == submittedAt
                ? _value.submittedAt
                : submittedAt // ignore: cast_nullable_to_non_nullable
                      as DateTime?,
            atolyeSessionId: freezed == atolyeSessionId
                ? _value.atolyeSessionId
                : atolyeSessionId // ignore: cast_nullable_to_non_nullable
                      as String?,
            atolyeDate: freezed == atolyeDate
                ? _value.atolyeDate
                : atolyeDate // ignore: cast_nullable_to_non_nullable
                      as DateTime?,
            atolyeCompleted: null == atolyeCompleted
                ? _value.atolyeCompleted
                : atolyeCompleted // ignore: cast_nullable_to_non_nullable
                      as bool,
            analytics: null == analytics
                ? _value.analytics
                : analytics // ignore: cast_nullable_to_non_nullable
                      as LearningAnalytics,
          )
          as $Val,
    );
  }

  /// Create a copy of ProjectProgress
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
abstract class _$$ProjectProgressImplCopyWith<$Res>
    implements $ProjectProgressCopyWith<$Res> {
  factory _$$ProjectProgressImplCopyWith(
    _$ProjectProgressImpl value,
    $Res Function(_$ProjectProgressImpl) then,
  ) = __$$ProjectProgressImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String userId,
    String projectId,
    Map<String, ModuleProgress> moduleProgress,
    String? currentModuleId,
    String? currentStageId,
    int earnedXP,
    int totalStagesCompleted,
    DateTime startedAt,
    DateTime? completedAt,
    DateTime? lastActivityAt,
    String? projectLink,
    String? projectDescription,
    DateTime? submittedAt,
    String? atolyeSessionId,
    DateTime? atolyeDate,
    bool atolyeCompleted,
    LearningAnalytics analytics,
  });

  @override
  $LearningAnalyticsCopyWith<$Res> get analytics;
}

/// @nodoc
class __$$ProjectProgressImplCopyWithImpl<$Res>
    extends _$ProjectProgressCopyWithImpl<$Res, _$ProjectProgressImpl>
    implements _$$ProjectProgressImplCopyWith<$Res> {
  __$$ProjectProgressImplCopyWithImpl(
    _$ProjectProgressImpl _value,
    $Res Function(_$ProjectProgressImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of ProjectProgress
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? userId = null,
    Object? projectId = null,
    Object? moduleProgress = null,
    Object? currentModuleId = freezed,
    Object? currentStageId = freezed,
    Object? earnedXP = null,
    Object? totalStagesCompleted = null,
    Object? startedAt = null,
    Object? completedAt = freezed,
    Object? lastActivityAt = freezed,
    Object? projectLink = freezed,
    Object? projectDescription = freezed,
    Object? submittedAt = freezed,
    Object? atolyeSessionId = freezed,
    Object? atolyeDate = freezed,
    Object? atolyeCompleted = null,
    Object? analytics = null,
  }) {
    return _then(
      _$ProjectProgressImpl(
        userId: null == userId
            ? _value.userId
            : userId // ignore: cast_nullable_to_non_nullable
                  as String,
        projectId: null == projectId
            ? _value.projectId
            : projectId // ignore: cast_nullable_to_non_nullable
                  as String,
        moduleProgress: null == moduleProgress
            ? _value._moduleProgress
            : moduleProgress // ignore: cast_nullable_to_non_nullable
                  as Map<String, ModuleProgress>,
        currentModuleId: freezed == currentModuleId
            ? _value.currentModuleId
            : currentModuleId // ignore: cast_nullable_to_non_nullable
                  as String?,
        currentStageId: freezed == currentStageId
            ? _value.currentStageId
            : currentStageId // ignore: cast_nullable_to_non_nullable
                  as String?,
        earnedXP: null == earnedXP
            ? _value.earnedXP
            : earnedXP // ignore: cast_nullable_to_non_nullable
                  as int,
        totalStagesCompleted: null == totalStagesCompleted
            ? _value.totalStagesCompleted
            : totalStagesCompleted // ignore: cast_nullable_to_non_nullable
                  as int,
        startedAt: null == startedAt
            ? _value.startedAt
            : startedAt // ignore: cast_nullable_to_non_nullable
                  as DateTime,
        completedAt: freezed == completedAt
            ? _value.completedAt
            : completedAt // ignore: cast_nullable_to_non_nullable
                  as DateTime?,
        lastActivityAt: freezed == lastActivityAt
            ? _value.lastActivityAt
            : lastActivityAt // ignore: cast_nullable_to_non_nullable
                  as DateTime?,
        projectLink: freezed == projectLink
            ? _value.projectLink
            : projectLink // ignore: cast_nullable_to_non_nullable
                  as String?,
        projectDescription: freezed == projectDescription
            ? _value.projectDescription
            : projectDescription // ignore: cast_nullable_to_non_nullable
                  as String?,
        submittedAt: freezed == submittedAt
            ? _value.submittedAt
            : submittedAt // ignore: cast_nullable_to_non_nullable
                  as DateTime?,
        atolyeSessionId: freezed == atolyeSessionId
            ? _value.atolyeSessionId
            : atolyeSessionId // ignore: cast_nullable_to_non_nullable
                  as String?,
        atolyeDate: freezed == atolyeDate
            ? _value.atolyeDate
            : atolyeDate // ignore: cast_nullable_to_non_nullable
                  as DateTime?,
        atolyeCompleted: null == atolyeCompleted
            ? _value.atolyeCompleted
            : atolyeCompleted // ignore: cast_nullable_to_non_nullable
                  as bool,
        analytics: null == analytics
            ? _value.analytics
            : analytics // ignore: cast_nullable_to_non_nullable
                  as LearningAnalytics,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$ProjectProgressImpl extends _ProjectProgress {
  const _$ProjectProgressImpl({
    required this.userId,
    required this.projectId,
    final Map<String, ModuleProgress> moduleProgress = const {},
    this.currentModuleId,
    this.currentStageId,
    required this.earnedXP,
    required this.totalStagesCompleted,
    required this.startedAt,
    this.completedAt,
    this.lastActivityAt,
    this.projectLink,
    this.projectDescription,
    this.submittedAt,
    this.atolyeSessionId,
    this.atolyeDate,
    this.atolyeCompleted = false,
    required this.analytics,
  }) : _moduleProgress = moduleProgress,
       super._();

  factory _$ProjectProgressImpl.fromJson(Map<String, dynamic> json) =>
      _$$ProjectProgressImplFromJson(json);

  @override
  final String userId;
  @override
  final String projectId;
  // Module Progress
  final Map<String, ModuleProgress> _moduleProgress;
  // Module Progress
  @override
  @JsonKey()
  Map<String, ModuleProgress> get moduleProgress {
    if (_moduleProgress is EqualUnmodifiableMapView) return _moduleProgress;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(_moduleProgress);
  }

  // moduleId → progress
  @override
  final String? currentModuleId;
  @override
  final String? currentStageId;
  // Overall Progress
  @override
  final int earnedXP;
  @override
  final int totalStagesCompleted;
  @override
  final DateTime startedAt;
  @override
  final DateTime? completedAt;
  @override
  final DateTime? lastActivityAt;
  // Project Submission
  @override
  final String? projectLink;
  @override
  final String? projectDescription;
  @override
  final DateTime? submittedAt;
  // Atölye
  @override
  final String? atolyeSessionId;
  @override
  final DateTime? atolyeDate;
  @override
  @JsonKey()
  final bool atolyeCompleted;
  // Analytics
  @override
  final LearningAnalytics analytics;

  @override
  String toString() {
    return 'ProjectProgress(userId: $userId, projectId: $projectId, moduleProgress: $moduleProgress, currentModuleId: $currentModuleId, currentStageId: $currentStageId, earnedXP: $earnedXP, totalStagesCompleted: $totalStagesCompleted, startedAt: $startedAt, completedAt: $completedAt, lastActivityAt: $lastActivityAt, projectLink: $projectLink, projectDescription: $projectDescription, submittedAt: $submittedAt, atolyeSessionId: $atolyeSessionId, atolyeDate: $atolyeDate, atolyeCompleted: $atolyeCompleted, analytics: $analytics)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ProjectProgressImpl &&
            (identical(other.userId, userId) || other.userId == userId) &&
            (identical(other.projectId, projectId) ||
                other.projectId == projectId) &&
            const DeepCollectionEquality().equals(
              other._moduleProgress,
              _moduleProgress,
            ) &&
            (identical(other.currentModuleId, currentModuleId) ||
                other.currentModuleId == currentModuleId) &&
            (identical(other.currentStageId, currentStageId) ||
                other.currentStageId == currentStageId) &&
            (identical(other.earnedXP, earnedXP) ||
                other.earnedXP == earnedXP) &&
            (identical(other.totalStagesCompleted, totalStagesCompleted) ||
                other.totalStagesCompleted == totalStagesCompleted) &&
            (identical(other.startedAt, startedAt) ||
                other.startedAt == startedAt) &&
            (identical(other.completedAt, completedAt) ||
                other.completedAt == completedAt) &&
            (identical(other.lastActivityAt, lastActivityAt) ||
                other.lastActivityAt == lastActivityAt) &&
            (identical(other.projectLink, projectLink) ||
                other.projectLink == projectLink) &&
            (identical(other.projectDescription, projectDescription) ||
                other.projectDescription == projectDescription) &&
            (identical(other.submittedAt, submittedAt) ||
                other.submittedAt == submittedAt) &&
            (identical(other.atolyeSessionId, atolyeSessionId) ||
                other.atolyeSessionId == atolyeSessionId) &&
            (identical(other.atolyeDate, atolyeDate) ||
                other.atolyeDate == atolyeDate) &&
            (identical(other.atolyeCompleted, atolyeCompleted) ||
                other.atolyeCompleted == atolyeCompleted) &&
            (identical(other.analytics, analytics) ||
                other.analytics == analytics));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    userId,
    projectId,
    const DeepCollectionEquality().hash(_moduleProgress),
    currentModuleId,
    currentStageId,
    earnedXP,
    totalStagesCompleted,
    startedAt,
    completedAt,
    lastActivityAt,
    projectLink,
    projectDescription,
    submittedAt,
    atolyeSessionId,
    atolyeDate,
    atolyeCompleted,
    analytics,
  );

  /// Create a copy of ProjectProgress
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ProjectProgressImplCopyWith<_$ProjectProgressImpl> get copyWith =>
      __$$ProjectProgressImplCopyWithImpl<_$ProjectProgressImpl>(
        this,
        _$identity,
      );

  @override
  Map<String, dynamic> toJson() {
    return _$$ProjectProgressImplToJson(this);
  }
}

abstract class _ProjectProgress extends ProjectProgress {
  const factory _ProjectProgress({
    required final String userId,
    required final String projectId,
    final Map<String, ModuleProgress> moduleProgress,
    final String? currentModuleId,
    final String? currentStageId,
    required final int earnedXP,
    required final int totalStagesCompleted,
    required final DateTime startedAt,
    final DateTime? completedAt,
    final DateTime? lastActivityAt,
    final String? projectLink,
    final String? projectDescription,
    final DateTime? submittedAt,
    final String? atolyeSessionId,
    final DateTime? atolyeDate,
    final bool atolyeCompleted,
    required final LearningAnalytics analytics,
  }) = _$ProjectProgressImpl;
  const _ProjectProgress._() : super._();

  factory _ProjectProgress.fromJson(Map<String, dynamic> json) =
      _$ProjectProgressImpl.fromJson;

  @override
  String get userId;
  @override
  String get projectId; // Module Progress
  @override
  Map<String, ModuleProgress> get moduleProgress; // moduleId → progress
  @override
  String? get currentModuleId;
  @override
  String? get currentStageId; // Overall Progress
  @override
  int get earnedXP;
  @override
  int get totalStagesCompleted;
  @override
  DateTime get startedAt;
  @override
  DateTime? get completedAt;
  @override
  DateTime? get lastActivityAt; // Project Submission
  @override
  String? get projectLink;
  @override
  String? get projectDescription;
  @override
  DateTime? get submittedAt; // Atölye
  @override
  String? get atolyeSessionId;
  @override
  DateTime? get atolyeDate;
  @override
  bool get atolyeCompleted; // Analytics
  @override
  LearningAnalytics get analytics;

  /// Create a copy of ProjectProgress
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ProjectProgressImplCopyWith<_$ProjectProgressImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
