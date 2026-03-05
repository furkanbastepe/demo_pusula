// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'learning_analytics.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

LearningAnalytics _$LearningAnalyticsFromJson(Map<String, dynamic> json) {
  return _LearningAnalytics.fromJson(json);
}

/// @nodoc
mixin _$LearningAnalytics {
  int get totalTimeSpentMinutes => throw _privateConstructorUsedError;
  Map<String, int> get timePerStage =>
      throw _privateConstructorUsedError; // stageId → minutes
  int get totalAIInteractions => throw _privateConstructorUsedError;
  int get totalValidationAttempts => throw _privateConstructorUsedError;
  double get validationSuccessRate => throw _privateConstructorUsedError;
  List<String> get strugglingStages =>
      throw _privateConstructorUsedError; // Stages with >3 attempts
  int get consecutiveDaysActive => throw _privateConstructorUsedError;
  DateTime get lastActiveDate => throw _privateConstructorUsedError;

  /// Serializes this LearningAnalytics to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of LearningAnalytics
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $LearningAnalyticsCopyWith<LearningAnalytics> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $LearningAnalyticsCopyWith<$Res> {
  factory $LearningAnalyticsCopyWith(
    LearningAnalytics value,
    $Res Function(LearningAnalytics) then,
  ) = _$LearningAnalyticsCopyWithImpl<$Res, LearningAnalytics>;
  @useResult
  $Res call({
    int totalTimeSpentMinutes,
    Map<String, int> timePerStage,
    int totalAIInteractions,
    int totalValidationAttempts,
    double validationSuccessRate,
    List<String> strugglingStages,
    int consecutiveDaysActive,
    DateTime lastActiveDate,
  });
}

/// @nodoc
class _$LearningAnalyticsCopyWithImpl<$Res, $Val extends LearningAnalytics>
    implements $LearningAnalyticsCopyWith<$Res> {
  _$LearningAnalyticsCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of LearningAnalytics
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? totalTimeSpentMinutes = null,
    Object? timePerStage = null,
    Object? totalAIInteractions = null,
    Object? totalValidationAttempts = null,
    Object? validationSuccessRate = null,
    Object? strugglingStages = null,
    Object? consecutiveDaysActive = null,
    Object? lastActiveDate = null,
  }) {
    return _then(
      _value.copyWith(
            totalTimeSpentMinutes: null == totalTimeSpentMinutes
                ? _value.totalTimeSpentMinutes
                : totalTimeSpentMinutes // ignore: cast_nullable_to_non_nullable
                      as int,
            timePerStage: null == timePerStage
                ? _value.timePerStage
                : timePerStage // ignore: cast_nullable_to_non_nullable
                      as Map<String, int>,
            totalAIInteractions: null == totalAIInteractions
                ? _value.totalAIInteractions
                : totalAIInteractions // ignore: cast_nullable_to_non_nullable
                      as int,
            totalValidationAttempts: null == totalValidationAttempts
                ? _value.totalValidationAttempts
                : totalValidationAttempts // ignore: cast_nullable_to_non_nullable
                      as int,
            validationSuccessRate: null == validationSuccessRate
                ? _value.validationSuccessRate
                : validationSuccessRate // ignore: cast_nullable_to_non_nullable
                      as double,
            strugglingStages: null == strugglingStages
                ? _value.strugglingStages
                : strugglingStages // ignore: cast_nullable_to_non_nullable
                      as List<String>,
            consecutiveDaysActive: null == consecutiveDaysActive
                ? _value.consecutiveDaysActive
                : consecutiveDaysActive // ignore: cast_nullable_to_non_nullable
                      as int,
            lastActiveDate: null == lastActiveDate
                ? _value.lastActiveDate
                : lastActiveDate // ignore: cast_nullable_to_non_nullable
                      as DateTime,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$LearningAnalyticsImplCopyWith<$Res>
    implements $LearningAnalyticsCopyWith<$Res> {
  factory _$$LearningAnalyticsImplCopyWith(
    _$LearningAnalyticsImpl value,
    $Res Function(_$LearningAnalyticsImpl) then,
  ) = __$$LearningAnalyticsImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    int totalTimeSpentMinutes,
    Map<String, int> timePerStage,
    int totalAIInteractions,
    int totalValidationAttempts,
    double validationSuccessRate,
    List<String> strugglingStages,
    int consecutiveDaysActive,
    DateTime lastActiveDate,
  });
}

/// @nodoc
class __$$LearningAnalyticsImplCopyWithImpl<$Res>
    extends _$LearningAnalyticsCopyWithImpl<$Res, _$LearningAnalyticsImpl>
    implements _$$LearningAnalyticsImplCopyWith<$Res> {
  __$$LearningAnalyticsImplCopyWithImpl(
    _$LearningAnalyticsImpl _value,
    $Res Function(_$LearningAnalyticsImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of LearningAnalytics
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? totalTimeSpentMinutes = null,
    Object? timePerStage = null,
    Object? totalAIInteractions = null,
    Object? totalValidationAttempts = null,
    Object? validationSuccessRate = null,
    Object? strugglingStages = null,
    Object? consecutiveDaysActive = null,
    Object? lastActiveDate = null,
  }) {
    return _then(
      _$LearningAnalyticsImpl(
        totalTimeSpentMinutes: null == totalTimeSpentMinutes
            ? _value.totalTimeSpentMinutes
            : totalTimeSpentMinutes // ignore: cast_nullable_to_non_nullable
                  as int,
        timePerStage: null == timePerStage
            ? _value._timePerStage
            : timePerStage // ignore: cast_nullable_to_non_nullable
                  as Map<String, int>,
        totalAIInteractions: null == totalAIInteractions
            ? _value.totalAIInteractions
            : totalAIInteractions // ignore: cast_nullable_to_non_nullable
                  as int,
        totalValidationAttempts: null == totalValidationAttempts
            ? _value.totalValidationAttempts
            : totalValidationAttempts // ignore: cast_nullable_to_non_nullable
                  as int,
        validationSuccessRate: null == validationSuccessRate
            ? _value.validationSuccessRate
            : validationSuccessRate // ignore: cast_nullable_to_non_nullable
                  as double,
        strugglingStages: null == strugglingStages
            ? _value._strugglingStages
            : strugglingStages // ignore: cast_nullable_to_non_nullable
                  as List<String>,
        consecutiveDaysActive: null == consecutiveDaysActive
            ? _value.consecutiveDaysActive
            : consecutiveDaysActive // ignore: cast_nullable_to_non_nullable
                  as int,
        lastActiveDate: null == lastActiveDate
            ? _value.lastActiveDate
            : lastActiveDate // ignore: cast_nullable_to_non_nullable
                  as DateTime,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$LearningAnalyticsImpl implements _LearningAnalytics {
  const _$LearningAnalyticsImpl({
    required this.totalTimeSpentMinutes,
    final Map<String, int> timePerStage = const {},
    required this.totalAIInteractions,
    required this.totalValidationAttempts,
    required this.validationSuccessRate,
    final List<String> strugglingStages = const [],
    required this.consecutiveDaysActive,
    required this.lastActiveDate,
  }) : _timePerStage = timePerStage,
       _strugglingStages = strugglingStages;

  factory _$LearningAnalyticsImpl.fromJson(Map<String, dynamic> json) =>
      _$$LearningAnalyticsImplFromJson(json);

  @override
  final int totalTimeSpentMinutes;
  final Map<String, int> _timePerStage;
  @override
  @JsonKey()
  Map<String, int> get timePerStage {
    if (_timePerStage is EqualUnmodifiableMapView) return _timePerStage;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(_timePerStage);
  }

  // stageId → minutes
  @override
  final int totalAIInteractions;
  @override
  final int totalValidationAttempts;
  @override
  final double validationSuccessRate;
  final List<String> _strugglingStages;
  @override
  @JsonKey()
  List<String> get strugglingStages {
    if (_strugglingStages is EqualUnmodifiableListView)
      return _strugglingStages;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_strugglingStages);
  }

  // Stages with >3 attempts
  @override
  final int consecutiveDaysActive;
  @override
  final DateTime lastActiveDate;

  @override
  String toString() {
    return 'LearningAnalytics(totalTimeSpentMinutes: $totalTimeSpentMinutes, timePerStage: $timePerStage, totalAIInteractions: $totalAIInteractions, totalValidationAttempts: $totalValidationAttempts, validationSuccessRate: $validationSuccessRate, strugglingStages: $strugglingStages, consecutiveDaysActive: $consecutiveDaysActive, lastActiveDate: $lastActiveDate)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$LearningAnalyticsImpl &&
            (identical(other.totalTimeSpentMinutes, totalTimeSpentMinutes) ||
                other.totalTimeSpentMinutes == totalTimeSpentMinutes) &&
            const DeepCollectionEquality().equals(
              other._timePerStage,
              _timePerStage,
            ) &&
            (identical(other.totalAIInteractions, totalAIInteractions) ||
                other.totalAIInteractions == totalAIInteractions) &&
            (identical(
                  other.totalValidationAttempts,
                  totalValidationAttempts,
                ) ||
                other.totalValidationAttempts == totalValidationAttempts) &&
            (identical(other.validationSuccessRate, validationSuccessRate) ||
                other.validationSuccessRate == validationSuccessRate) &&
            const DeepCollectionEquality().equals(
              other._strugglingStages,
              _strugglingStages,
            ) &&
            (identical(other.consecutiveDaysActive, consecutiveDaysActive) ||
                other.consecutiveDaysActive == consecutiveDaysActive) &&
            (identical(other.lastActiveDate, lastActiveDate) ||
                other.lastActiveDate == lastActiveDate));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    totalTimeSpentMinutes,
    const DeepCollectionEquality().hash(_timePerStage),
    totalAIInteractions,
    totalValidationAttempts,
    validationSuccessRate,
    const DeepCollectionEquality().hash(_strugglingStages),
    consecutiveDaysActive,
    lastActiveDate,
  );

  /// Create a copy of LearningAnalytics
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$LearningAnalyticsImplCopyWith<_$LearningAnalyticsImpl> get copyWith =>
      __$$LearningAnalyticsImplCopyWithImpl<_$LearningAnalyticsImpl>(
        this,
        _$identity,
      );

  @override
  Map<String, dynamic> toJson() {
    return _$$LearningAnalyticsImplToJson(this);
  }
}

abstract class _LearningAnalytics implements LearningAnalytics {
  const factory _LearningAnalytics({
    required final int totalTimeSpentMinutes,
    final Map<String, int> timePerStage,
    required final int totalAIInteractions,
    required final int totalValidationAttempts,
    required final double validationSuccessRate,
    final List<String> strugglingStages,
    required final int consecutiveDaysActive,
    required final DateTime lastActiveDate,
  }) = _$LearningAnalyticsImpl;

  factory _LearningAnalytics.fromJson(Map<String, dynamic> json) =
      _$LearningAnalyticsImpl.fromJson;

  @override
  int get totalTimeSpentMinutes;
  @override
  Map<String, int> get timePerStage; // stageId → minutes
  @override
  int get totalAIInteractions;
  @override
  int get totalValidationAttempts;
  @override
  double get validationSuccessRate;
  @override
  List<String> get strugglingStages; // Stages with >3 attempts
  @override
  int get consecutiveDaysActive;
  @override
  DateTime get lastActiveDate;

  /// Create a copy of LearningAnalytics
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$LearningAnalyticsImplCopyWith<_$LearningAnalyticsImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
