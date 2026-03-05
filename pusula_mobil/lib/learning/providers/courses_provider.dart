import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/models.dart';
import '../services/services.dart';

// ═══════════════════════════════════════════════════════════════════════════════════
// 📚 COURSES PROVIDER
// ═══════════════════════════════════════════════════════════════════════════════════

final contentServiceProvider = Provider<ContentService>((ref) {
  return ContentService();
});

final coursesProvider = FutureProvider<List<Course>>((ref) async {
  final contentService = ref.read(contentServiceProvider);
  return await contentService.loadCourses();
});

final lessonProvider = FutureProvider.family<Lesson, LessonParams>((ref, params) async {
  final contentService = ref.read(contentServiceProvider);
  return await contentService.loadLesson(params.courseId, params.lessonId);
});

class LessonParams {
  final String courseId;
  final String lessonId;

  LessonParams({required this.courseId, required this.lessonId});

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is LessonParams &&
          runtimeType == other.runtimeType &&
          courseId == other.courseId &&
          lessonId == other.lessonId;

  @override
  int get hashCode => courseId.hashCode ^ lessonId.hashCode;
}
