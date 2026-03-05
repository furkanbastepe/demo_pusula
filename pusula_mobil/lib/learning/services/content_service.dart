import 'dart:convert';
import 'package:flutter/services.dart';
import '../models/models.dart';

// ═══════════════════════════════════════════════════════════════════════════════════
// 📚 CONTENT SERVICE - Load courses and lessons from assets
// ═══════════════════════════════════════════════════════════════════════════════════

class ContentService {
  // In-memory cache
  final Map<String, Course> _coursesCache = {};
  final Map<String, Lesson> _lessonsCache = {};

  Future<List<Course>> loadCourses() async {
    if (_coursesCache.isNotEmpty) {
      return _coursesCache.values.toList();
    }

    try {
      final courses = <Course>[];
      
      // Load Python course
      try {
        final pythonJson = await rootBundle.loadString(
          'assets/learning/courses/python/course.json',
        );
        final pythonCourse = Course.fromJson(json.decode(pythonJson));
        courses.add(pythonCourse);
        _coursesCache[pythonCourse.id] = pythonCourse;
      } catch (e) {
        print('Error loading Python course: $e');
      }

      // Load SQL course
      try {
        final sqlJson = await rootBundle.loadString(
          'assets/learning/courses/sql/course.json',
        );
        final sqlCourse = Course.fromJson(json.decode(sqlJson));
        courses.add(sqlCourse);
        _coursesCache[sqlCourse.id] = sqlCourse;
      } catch (e) {
        print('Error loading SQL course: $e');
      }

      return courses;
    } catch (e) {
      print('Error loading courses: $e');
      rethrow;
    }
  }

  Future<Lesson> loadLesson(String courseId, String lessonId) async {
    // Check cache first
    final cacheKey = '$courseId/$lessonId';
    if (_lessonsCache.containsKey(cacheKey)) {
      print('✅ Lesson loaded from cache: $cacheKey');
      return _lessonsCache[cacheKey]!;
    }

    try {
      // Map courseId to folder name
      final folderName = _getCourseFolder(courseId);
      final path = 'assets/learning/courses/$folderName/lessons/$lessonId.json';
      
      print('📖 Loading lesson from: $path');
      
      final lessonJson = await rootBundle.loadString(path);
      print('✅ Lesson JSON loaded successfully');
      
      final jsonData = json.decode(lessonJson);
      print('✅ JSON decoded successfully');
      
      final lesson = Lesson.fromJson(jsonData);
      print('✅ Lesson model created successfully: ${lesson.title}');
      
      _lessonsCache[cacheKey] = lesson;
      return lesson;
    } catch (e, stackTrace) {
      print('❌ Error loading lesson $lessonId from courseId $courseId');
      print('❌ Error: $e');
      print('❌ StackTrace: $stackTrace');
      rethrow;
    }
  }

  String _getCourseFolder(String courseId) {
    // Map course IDs to their folder names
    switch (courseId) {
      case 'python-basics':
        return 'python';
      case 'sql-basics':
        return 'sql';
      default:
        return courseId;
    }
  }

  void clearCache() {
    _coursesCache.clear();
    _lessonsCache.clear();
  }
}
