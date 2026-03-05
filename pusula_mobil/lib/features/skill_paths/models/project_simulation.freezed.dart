// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'project_simulation.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

ProjectSimulation _$ProjectSimulationFromJson(Map<String, dynamic> json) {
  return _ProjectSimulation.fromJson(json);
}

/// @nodoc
mixin _$ProjectSimulation {
  String get id => throw _privateConstructorUsedError;
  String get title => throw _privateConstructorUsedError;
  String get skillPath =>
      throw _privateConstructorUsedError; // Veri Analisti, Yazılım Geliştirici, etc.
  String get emoji => throw _privateConstructorUsedError; // Project Context
  ProjectContext get context => throw _privateConstructorUsedError; // Modules
  List<ProjectModule> get modules =>
      throw _privateConstructorUsedError; // Metadata
  int get totalXP => throw _privateConstructorUsedError;
  int get estimatedHours => throw _privateConstructorUsedError;
  String get difficulty =>
      throw _privateConstructorUsedError; // "Çırak", "Kalfa", "Usta"
  List<String> get learningOutcomes => throw _privateConstructorUsedError;
  List<String> get toolsUsed => throw _privateConstructorUsedError;

  /// Serializes this ProjectSimulation to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of ProjectSimulation
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $ProjectSimulationCopyWith<ProjectSimulation> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ProjectSimulationCopyWith<$Res> {
  factory $ProjectSimulationCopyWith(
    ProjectSimulation value,
    $Res Function(ProjectSimulation) then,
  ) = _$ProjectSimulationCopyWithImpl<$Res, ProjectSimulation>;
  @useResult
  $Res call({
    String id,
    String title,
    String skillPath,
    String emoji,
    ProjectContext context,
    List<ProjectModule> modules,
    int totalXP,
    int estimatedHours,
    String difficulty,
    List<String> learningOutcomes,
    List<String> toolsUsed,
  });

  $ProjectContextCopyWith<$Res> get context;
}

/// @nodoc
class _$ProjectSimulationCopyWithImpl<$Res, $Val extends ProjectSimulation>
    implements $ProjectSimulationCopyWith<$Res> {
  _$ProjectSimulationCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of ProjectSimulation
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? title = null,
    Object? skillPath = null,
    Object? emoji = null,
    Object? context = null,
    Object? modules = null,
    Object? totalXP = null,
    Object? estimatedHours = null,
    Object? difficulty = null,
    Object? learningOutcomes = null,
    Object? toolsUsed = null,
  }) {
    return _then(
      _value.copyWith(
            id: null == id
                ? _value.id
                : id // ignore: cast_nullable_to_non_nullable
                      as String,
            title: null == title
                ? _value.title
                : title // ignore: cast_nullable_to_non_nullable
                      as String,
            skillPath: null == skillPath
                ? _value.skillPath
                : skillPath // ignore: cast_nullable_to_non_nullable
                      as String,
            emoji: null == emoji
                ? _value.emoji
                : emoji // ignore: cast_nullable_to_non_nullable
                      as String,
            context: null == context
                ? _value.context
                : context // ignore: cast_nullable_to_non_nullable
                      as ProjectContext,
            modules: null == modules
                ? _value.modules
                : modules // ignore: cast_nullable_to_non_nullable
                      as List<ProjectModule>,
            totalXP: null == totalXP
                ? _value.totalXP
                : totalXP // ignore: cast_nullable_to_non_nullable
                      as int,
            estimatedHours: null == estimatedHours
                ? _value.estimatedHours
                : estimatedHours // ignore: cast_nullable_to_non_nullable
                      as int,
            difficulty: null == difficulty
                ? _value.difficulty
                : difficulty // ignore: cast_nullable_to_non_nullable
                      as String,
            learningOutcomes: null == learningOutcomes
                ? _value.learningOutcomes
                : learningOutcomes // ignore: cast_nullable_to_non_nullable
                      as List<String>,
            toolsUsed: null == toolsUsed
                ? _value.toolsUsed
                : toolsUsed // ignore: cast_nullable_to_non_nullable
                      as List<String>,
          )
          as $Val,
    );
  }

  /// Create a copy of ProjectSimulation
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $ProjectContextCopyWith<$Res> get context {
    return $ProjectContextCopyWith<$Res>(_value.context, (value) {
      return _then(_value.copyWith(context: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$ProjectSimulationImplCopyWith<$Res>
    implements $ProjectSimulationCopyWith<$Res> {
  factory _$$ProjectSimulationImplCopyWith(
    _$ProjectSimulationImpl value,
    $Res Function(_$ProjectSimulationImpl) then,
  ) = __$$ProjectSimulationImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String id,
    String title,
    String skillPath,
    String emoji,
    ProjectContext context,
    List<ProjectModule> modules,
    int totalXP,
    int estimatedHours,
    String difficulty,
    List<String> learningOutcomes,
    List<String> toolsUsed,
  });

  @override
  $ProjectContextCopyWith<$Res> get context;
}

/// @nodoc
class __$$ProjectSimulationImplCopyWithImpl<$Res>
    extends _$ProjectSimulationCopyWithImpl<$Res, _$ProjectSimulationImpl>
    implements _$$ProjectSimulationImplCopyWith<$Res> {
  __$$ProjectSimulationImplCopyWithImpl(
    _$ProjectSimulationImpl _value,
    $Res Function(_$ProjectSimulationImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of ProjectSimulation
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? title = null,
    Object? skillPath = null,
    Object? emoji = null,
    Object? context = null,
    Object? modules = null,
    Object? totalXP = null,
    Object? estimatedHours = null,
    Object? difficulty = null,
    Object? learningOutcomes = null,
    Object? toolsUsed = null,
  }) {
    return _then(
      _$ProjectSimulationImpl(
        id: null == id
            ? _value.id
            : id // ignore: cast_nullable_to_non_nullable
                  as String,
        title: null == title
            ? _value.title
            : title // ignore: cast_nullable_to_non_nullable
                  as String,
        skillPath: null == skillPath
            ? _value.skillPath
            : skillPath // ignore: cast_nullable_to_non_nullable
                  as String,
        emoji: null == emoji
            ? _value.emoji
            : emoji // ignore: cast_nullable_to_non_nullable
                  as String,
        context: null == context
            ? _value.context
            : context // ignore: cast_nullable_to_non_nullable
                  as ProjectContext,
        modules: null == modules
            ? _value._modules
            : modules // ignore: cast_nullable_to_non_nullable
                  as List<ProjectModule>,
        totalXP: null == totalXP
            ? _value.totalXP
            : totalXP // ignore: cast_nullable_to_non_nullable
                  as int,
        estimatedHours: null == estimatedHours
            ? _value.estimatedHours
            : estimatedHours // ignore: cast_nullable_to_non_nullable
                  as int,
        difficulty: null == difficulty
            ? _value.difficulty
            : difficulty // ignore: cast_nullable_to_non_nullable
                  as String,
        learningOutcomes: null == learningOutcomes
            ? _value._learningOutcomes
            : learningOutcomes // ignore: cast_nullable_to_non_nullable
                  as List<String>,
        toolsUsed: null == toolsUsed
            ? _value._toolsUsed
            : toolsUsed // ignore: cast_nullable_to_non_nullable
                  as List<String>,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$ProjectSimulationImpl extends _ProjectSimulation {
  const _$ProjectSimulationImpl({
    required this.id,
    required this.title,
    required this.skillPath,
    required this.emoji,
    required this.context,
    required final List<ProjectModule> modules,
    required this.totalXP,
    required this.estimatedHours,
    required this.difficulty,
    required final List<String> learningOutcomes,
    required final List<String> toolsUsed,
  }) : _modules = modules,
       _learningOutcomes = learningOutcomes,
       _toolsUsed = toolsUsed,
       super._();

  factory _$ProjectSimulationImpl.fromJson(Map<String, dynamic> json) =>
      _$$ProjectSimulationImplFromJson(json);

  @override
  final String id;
  @override
  final String title;
  @override
  final String skillPath;
  // Veri Analisti, Yazılım Geliştirici, etc.
  @override
  final String emoji;
  // Project Context
  @override
  final ProjectContext context;
  // Modules
  final List<ProjectModule> _modules;
  // Modules
  @override
  List<ProjectModule> get modules {
    if (_modules is EqualUnmodifiableListView) return _modules;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_modules);
  }

  // Metadata
  @override
  final int totalXP;
  @override
  final int estimatedHours;
  @override
  final String difficulty;
  // "Çırak", "Kalfa", "Usta"
  final List<String> _learningOutcomes;
  // "Çırak", "Kalfa", "Usta"
  @override
  List<String> get learningOutcomes {
    if (_learningOutcomes is EqualUnmodifiableListView)
      return _learningOutcomes;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_learningOutcomes);
  }

  final List<String> _toolsUsed;
  @override
  List<String> get toolsUsed {
    if (_toolsUsed is EqualUnmodifiableListView) return _toolsUsed;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_toolsUsed);
  }

  @override
  String toString() {
    return 'ProjectSimulation(id: $id, title: $title, skillPath: $skillPath, emoji: $emoji, context: $context, modules: $modules, totalXP: $totalXP, estimatedHours: $estimatedHours, difficulty: $difficulty, learningOutcomes: $learningOutcomes, toolsUsed: $toolsUsed)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ProjectSimulationImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.title, title) || other.title == title) &&
            (identical(other.skillPath, skillPath) ||
                other.skillPath == skillPath) &&
            (identical(other.emoji, emoji) || other.emoji == emoji) &&
            (identical(other.context, context) || other.context == context) &&
            const DeepCollectionEquality().equals(other._modules, _modules) &&
            (identical(other.totalXP, totalXP) || other.totalXP == totalXP) &&
            (identical(other.estimatedHours, estimatedHours) ||
                other.estimatedHours == estimatedHours) &&
            (identical(other.difficulty, difficulty) ||
                other.difficulty == difficulty) &&
            const DeepCollectionEquality().equals(
              other._learningOutcomes,
              _learningOutcomes,
            ) &&
            const DeepCollectionEquality().equals(
              other._toolsUsed,
              _toolsUsed,
            ));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    id,
    title,
    skillPath,
    emoji,
    context,
    const DeepCollectionEquality().hash(_modules),
    totalXP,
    estimatedHours,
    difficulty,
    const DeepCollectionEquality().hash(_learningOutcomes),
    const DeepCollectionEquality().hash(_toolsUsed),
  );

  /// Create a copy of ProjectSimulation
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ProjectSimulationImplCopyWith<_$ProjectSimulationImpl> get copyWith =>
      __$$ProjectSimulationImplCopyWithImpl<_$ProjectSimulationImpl>(
        this,
        _$identity,
      );

  @override
  Map<String, dynamic> toJson() {
    return _$$ProjectSimulationImplToJson(this);
  }
}

abstract class _ProjectSimulation extends ProjectSimulation {
  const factory _ProjectSimulation({
    required final String id,
    required final String title,
    required final String skillPath,
    required final String emoji,
    required final ProjectContext context,
    required final List<ProjectModule> modules,
    required final int totalXP,
    required final int estimatedHours,
    required final String difficulty,
    required final List<String> learningOutcomes,
    required final List<String> toolsUsed,
  }) = _$ProjectSimulationImpl;
  const _ProjectSimulation._() : super._();

  factory _ProjectSimulation.fromJson(Map<String, dynamic> json) =
      _$ProjectSimulationImpl.fromJson;

  @override
  String get id;
  @override
  String get title;
  @override
  String get skillPath; // Veri Analisti, Yazılım Geliştirici, etc.
  @override
  String get emoji; // Project Context
  @override
  ProjectContext get context; // Modules
  @override
  List<ProjectModule> get modules; // Metadata
  @override
  int get totalXP;
  @override
  int get estimatedHours;
  @override
  String get difficulty; // "Çırak", "Kalfa", "Usta"
  @override
  List<String> get learningOutcomes;
  @override
  List<String> get toolsUsed;

  /// Create a copy of ProjectSimulation
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ProjectSimulationImplCopyWith<_$ProjectSimulationImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
