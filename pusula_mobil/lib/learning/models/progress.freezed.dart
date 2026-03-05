// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'progress.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

LearningProgress _$LearningProgressFromJson(Map<String, dynamic> json) {
  return _LearningProgress.fromJson(json);
}

/// @nodoc
mixin _$LearningProgress {
  String get userId => throw _privateConstructorUsedError;
  Map<String, CourseProgress> get courseProgress =>
      throw _privateConstructorUsedError;
  int get totalXP => throw _privateConstructorUsedError;
  int get currentStreak => throw _privateConstructorUsedError;
  DateTime get lastActivityDate => throw _privateConstructorUsedError;
  List<String> get earnedAchievements => throw _privateConstructorUsedError;

  /// Serializes this LearningProgress to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of LearningProgress
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $LearningProgressCopyWith<LearningProgress> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $LearningProgressCopyWith<$Res> {
  factory $LearningProgressCopyWith(
    LearningProgress value,
    $Res Function(LearningProgress) then,
  ) = _$LearningProgressCopyWithImpl<$Res, LearningProgress>;
  @useResult
  $Res call({
    String userId,
    Map<String, CourseProgress> courseProgress,
    int totalXP,
    int currentStreak,
    DateTime lastActivityDate,
    List<String> earnedAchievements,
  });
}

/// @nodoc
class _$LearningProgressCopyWithImpl<$Res, $Val extends LearningProgress>
    implements $LearningProgressCopyWith<$Res> {
  _$LearningProgressCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of LearningProgress
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? userId = null,
    Object? courseProgress = null,
    Object? totalXP = null,
    Object? currentStreak = null,
    Object? lastActivityDate = null,
    Object? earnedAchievements = null,
  }) {
    return _then(
      _value.copyWith(
            userId: null == userId
                ? _value.userId
                : userId // ignore: cast_nullable_to_non_nullable
                      as String,
            courseProgress: null == courseProgress
                ? _value.courseProgress
                : courseProgress // ignore: cast_nullable_to_non_nullable
                      as Map<String, CourseProgress>,
            totalXP: null == totalXP
                ? _value.totalXP
                : totalXP // ignore: cast_nullable_to_non_nullable
                      as int,
            currentStreak: null == currentStreak
                ? _value.currentStreak
                : currentStreak // ignore: cast_nullable_to_non_nullable
                      as int,
            lastActivityDate: null == lastActivityDate
                ? _value.lastActivityDate
                : lastActivityDate // ignore: cast_nullable_to_non_nullable
                      as DateTime,
            earnedAchievements: null == earnedAchievements
                ? _value.earnedAchievements
                : earnedAchievements // ignore: cast_nullable_to_non_nullable
                      as List<String>,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$LearningProgressImplCopyWith<$Res>
    implements $LearningProgressCopyWith<$Res> {
  factory _$$LearningProgressImplCopyWith(
    _$LearningProgressImpl value,
    $Res Function(_$LearningProgressImpl) then,
  ) = __$$LearningProgressImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String userId,
    Map<String, CourseProgress> courseProgress,
    int totalXP,
    int currentStreak,
    DateTime lastActivityDate,
    List<String> earnedAchievements,
  });
}

/// @nodoc
class __$$LearningProgressImplCopyWithImpl<$Res>
    extends _$LearningProgressCopyWithImpl<$Res, _$LearningProgressImpl>
    implements _$$LearningProgressImplCopyWith<$Res> {
  __$$LearningProgressImplCopyWithImpl(
    _$LearningProgressImpl _value,
    $Res Function(_$LearningProgressImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of LearningProgress
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? userId = null,
    Object? courseProgress = null,
    Object? totalXP = null,
    Object? currentStreak = null,
    Object? lastActivityDate = null,
    Object? earnedAchievements = null,
  }) {
    return _then(
      _$LearningProgressImpl(
        userId: null == userId
            ? _value.userId
            : userId // ignore: cast_nullable_to_non_nullable
                  as String,
        courseProgress: null == courseProgress
            ? _value._courseProgress
            : courseProgress // ignore: cast_nullable_to_non_nullable
                  as Map<String, CourseProgress>,
        totalXP: null == totalXP
            ? _value.totalXP
            : totalXP // ignore: cast_nullable_to_non_nullable
                  as int,
        currentStreak: null == currentStreak
            ? _value.currentStreak
            : currentStreak // ignore: cast_nullable_to_non_nullable
                  as int,
        lastActivityDate: null == lastActivityDate
            ? _value.lastActivityDate
            : lastActivityDate // ignore: cast_nullable_to_non_nullable
                  as DateTime,
        earnedAchievements: null == earnedAchievements
            ? _value._earnedAchievements
            : earnedAchievements // ignore: cast_nullable_to_non_nullable
                  as List<String>,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$LearningProgressImpl extends _LearningProgress {
  const _$LearningProgressImpl({
    required this.userId,
    final Map<String, CourseProgress> courseProgress = const {},
    this.totalXP = 0,
    this.currentStreak = 0,
    required this.lastActivityDate,
    final List<String> earnedAchievements = const [],
  }) : _courseProgress = courseProgress,
       _earnedAchievements = earnedAchievements,
       super._();

  factory _$LearningProgressImpl.fromJson(Map<String, dynamic> json) =>
      _$$LearningProgressImplFromJson(json);

  @override
  final String userId;
  final Map<String, CourseProgress> _courseProgress;
  @override
  @JsonKey()
  Map<String, CourseProgress> get courseProgress {
    if (_courseProgress is EqualUnmodifiableMapView) return _courseProgress;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(_courseProgress);
  }

  @override
  @JsonKey()
  final int totalXP;
  @override
  @JsonKey()
  final int currentStreak;
  @override
  final DateTime lastActivityDate;
  final List<String> _earnedAchievements;
  @override
  @JsonKey()
  List<String> get earnedAchievements {
    if (_earnedAchievements is EqualUnmodifiableListView)
      return _earnedAchievements;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_earnedAchievements);
  }

  @override
  String toString() {
    return 'LearningProgress(userId: $userId, courseProgress: $courseProgress, totalXP: $totalXP, currentStreak: $currentStreak, lastActivityDate: $lastActivityDate, earnedAchievements: $earnedAchievements)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$LearningProgressImpl &&
            (identical(other.userId, userId) || other.userId == userId) &&
            const DeepCollectionEquality().equals(
              other._courseProgress,
              _courseProgress,
            ) &&
            (identical(other.totalXP, totalXP) || other.totalXP == totalXP) &&
            (identical(other.currentStreak, currentStreak) ||
                other.currentStreak == currentStreak) &&
            (identical(other.lastActivityDate, lastActivityDate) ||
                other.lastActivityDate == lastActivityDate) &&
            const DeepCollectionEquality().equals(
              other._earnedAchievements,
              _earnedAchievements,
            ));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    userId,
    const DeepCollectionEquality().hash(_courseProgress),
    totalXP,
    currentStreak,
    lastActivityDate,
    const DeepCollectionEquality().hash(_earnedAchievements),
  );

  /// Create a copy of LearningProgress
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$LearningProgressImplCopyWith<_$LearningProgressImpl> get copyWith =>
      __$$LearningProgressImplCopyWithImpl<_$LearningProgressImpl>(
        this,
        _$identity,
      );

  @override
  Map<String, dynamic> toJson() {
    return _$$LearningProgressImplToJson(this);
  }
}

abstract class _LearningProgress extends LearningProgress {
  const factory _LearningProgress({
    required final String userId,
    final Map<String, CourseProgress> courseProgress,
    final int totalXP,
    final int currentStreak,
    required final DateTime lastActivityDate,
    final List<String> earnedAchievements,
  }) = _$LearningProgressImpl;
  const _LearningProgress._() : super._();

  factory _LearningProgress.fromJson(Map<String, dynamic> json) =
      _$LearningProgressImpl.fromJson;

  @override
  String get userId;
  @override
  Map<String, CourseProgress> get courseProgress;
  @override
  int get totalXP;
  @override
  int get currentStreak;
  @override
  DateTime get lastActivityDate;
  @override
  List<String> get earnedAchievements;

  /// Create a copy of LearningProgress
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$LearningProgressImplCopyWith<_$LearningProgressImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

CourseProgress _$CourseProgressFromJson(Map<String, dynamic> json) {
  return _CourseProgress.fromJson(json);
}

/// @nodoc
mixin _$CourseProgress {
  String get courseId => throw _privateConstructorUsedError;
  List<String> get completedLessonIds => throw _privateConstructorUsedError;
  int get earnedXP => throw _privateConstructorUsedError;
  DateTime get lastAccessDate => throw _privateConstructorUsedError;

  /// Serializes this CourseProgress to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of CourseProgress
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $CourseProgressCopyWith<CourseProgress> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $CourseProgressCopyWith<$Res> {
  factory $CourseProgressCopyWith(
    CourseProgress value,
    $Res Function(CourseProgress) then,
  ) = _$CourseProgressCopyWithImpl<$Res, CourseProgress>;
  @useResult
  $Res call({
    String courseId,
    List<String> completedLessonIds,
    int earnedXP,
    DateTime lastAccessDate,
  });
}

/// @nodoc
class _$CourseProgressCopyWithImpl<$Res, $Val extends CourseProgress>
    implements $CourseProgressCopyWith<$Res> {
  _$CourseProgressCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of CourseProgress
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? courseId = null,
    Object? completedLessonIds = null,
    Object? earnedXP = null,
    Object? lastAccessDate = null,
  }) {
    return _then(
      _value.copyWith(
            courseId: null == courseId
                ? _value.courseId
                : courseId // ignore: cast_nullable_to_non_nullable
                      as String,
            completedLessonIds: null == completedLessonIds
                ? _value.completedLessonIds
                : completedLessonIds // ignore: cast_nullable_to_non_nullable
                      as List<String>,
            earnedXP: null == earnedXP
                ? _value.earnedXP
                : earnedXP // ignore: cast_nullable_to_non_nullable
                      as int,
            lastAccessDate: null == lastAccessDate
                ? _value.lastAccessDate
                : lastAccessDate // ignore: cast_nullable_to_non_nullable
                      as DateTime,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$CourseProgressImplCopyWith<$Res>
    implements $CourseProgressCopyWith<$Res> {
  factory _$$CourseProgressImplCopyWith(
    _$CourseProgressImpl value,
    $Res Function(_$CourseProgressImpl) then,
  ) = __$$CourseProgressImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String courseId,
    List<String> completedLessonIds,
    int earnedXP,
    DateTime lastAccessDate,
  });
}

/// @nodoc
class __$$CourseProgressImplCopyWithImpl<$Res>
    extends _$CourseProgressCopyWithImpl<$Res, _$CourseProgressImpl>
    implements _$$CourseProgressImplCopyWith<$Res> {
  __$$CourseProgressImplCopyWithImpl(
    _$CourseProgressImpl _value,
    $Res Function(_$CourseProgressImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of CourseProgress
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? courseId = null,
    Object? completedLessonIds = null,
    Object? earnedXP = null,
    Object? lastAccessDate = null,
  }) {
    return _then(
      _$CourseProgressImpl(
        courseId: null == courseId
            ? _value.courseId
            : courseId // ignore: cast_nullable_to_non_nullable
                  as String,
        completedLessonIds: null == completedLessonIds
            ? _value._completedLessonIds
            : completedLessonIds // ignore: cast_nullable_to_non_nullable
                  as List<String>,
        earnedXP: null == earnedXP
            ? _value.earnedXP
            : earnedXP // ignore: cast_nullable_to_non_nullable
                  as int,
        lastAccessDate: null == lastAccessDate
            ? _value.lastAccessDate
            : lastAccessDate // ignore: cast_nullable_to_non_nullable
                  as DateTime,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$CourseProgressImpl implements _CourseProgress {
  const _$CourseProgressImpl({
    required this.courseId,
    final List<String> completedLessonIds = const [],
    this.earnedXP = 0,
    required this.lastAccessDate,
  }) : _completedLessonIds = completedLessonIds;

  factory _$CourseProgressImpl.fromJson(Map<String, dynamic> json) =>
      _$$CourseProgressImplFromJson(json);

  @override
  final String courseId;
  final List<String> _completedLessonIds;
  @override
  @JsonKey()
  List<String> get completedLessonIds {
    if (_completedLessonIds is EqualUnmodifiableListView)
      return _completedLessonIds;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_completedLessonIds);
  }

  @override
  @JsonKey()
  final int earnedXP;
  @override
  final DateTime lastAccessDate;

  @override
  String toString() {
    return 'CourseProgress(courseId: $courseId, completedLessonIds: $completedLessonIds, earnedXP: $earnedXP, lastAccessDate: $lastAccessDate)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$CourseProgressImpl &&
            (identical(other.courseId, courseId) ||
                other.courseId == courseId) &&
            const DeepCollectionEquality().equals(
              other._completedLessonIds,
              _completedLessonIds,
            ) &&
            (identical(other.earnedXP, earnedXP) ||
                other.earnedXP == earnedXP) &&
            (identical(other.lastAccessDate, lastAccessDate) ||
                other.lastAccessDate == lastAccessDate));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    courseId,
    const DeepCollectionEquality().hash(_completedLessonIds),
    earnedXP,
    lastAccessDate,
  );

  /// Create a copy of CourseProgress
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$CourseProgressImplCopyWith<_$CourseProgressImpl> get copyWith =>
      __$$CourseProgressImplCopyWithImpl<_$CourseProgressImpl>(
        this,
        _$identity,
      );

  @override
  Map<String, dynamic> toJson() {
    return _$$CourseProgressImplToJson(this);
  }
}

abstract class _CourseProgress implements CourseProgress {
  const factory _CourseProgress({
    required final String courseId,
    final List<String> completedLessonIds,
    final int earnedXP,
    required final DateTime lastAccessDate,
  }) = _$CourseProgressImpl;

  factory _CourseProgress.fromJson(Map<String, dynamic> json) =
      _$CourseProgressImpl.fromJson;

  @override
  String get courseId;
  @override
  List<String> get completedLessonIds;
  @override
  int get earnedXP;
  @override
  DateTime get lastAccessDate;

  /// Create a copy of CourseProgress
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$CourseProgressImplCopyWith<_$CourseProgressImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
