import 'package:freezed_annotation/freezed_annotation.dart';

part 'course.freezed.dart';
part 'course.g.dart';

// ═══════════════════════════════════════════════════════════════════════════════════
// 📚 COURSE MODEL - Freezed + JSON Serializable
// ═══════════════════════════════════════════════════════════════════════════════════

@freezed
class Course with _$Course {
  const Course._();
  
  const factory Course({
    required String id,
    required String title,
    required String description,
    required String iconPath,
    required List<String> lessonIds,
    required int totalXP,
    @Default('beginner') String difficulty,
  }) = _Course;

  factory Course.fromJson(Map<String, dynamic> json) => _$CourseFromJson(json);

  // Computed properties
  int get totalLessons => lessonIds.length;

  double calculateProgress(List<String> completedLessonIds) {
    if (lessonIds.isEmpty) return 0.0;
    final completed = lessonIds.where((id) => completedLessonIds.contains(id)).length;
    return completed / lessonIds.length;
  }
}
