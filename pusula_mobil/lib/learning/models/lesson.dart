import 'package:freezed_annotation/freezed_annotation.dart';

part 'lesson.freezed.dart';
part 'lesson.g.dart';

// ═══════════════════════════════════════════════════════════════════════════════════
// 📖 LESSON MODEL - Freezed + JSON Serializable
// ═══════════════════════════════════════════════════════════════════════════════════

@freezed
class Lesson with _$Lesson {
  const Lesson._();
  
  const factory Lesson({
    required String id,
    required String courseId,
    required int order,
    required String title,
    required List<LessonSection> sections,
    required int xpReward,
    required int estimatedTime, // in minutes
  }) = _Lesson;

  factory Lesson.fromJson(Map<String, dynamic> json) => _$LessonFromJson(json);

  bool isUnlocked(List<String> completedLessonIds, List<String> allLessonIds) {
    // First lesson is always unlocked
    if (order == 1) return true;
    
    // Find previous lesson
    final previousLessonIndex = allLessonIds.indexOf(id) - 1;
    if (previousLessonIndex < 0) return true;
    
    final previousLessonId = allLessonIds[previousLessonIndex];
    return completedLessonIds.contains(previousLessonId);
  }
}

class LessonSection {
  const LessonSection._();
  
  factory LessonSection.content(ContentData data) = ContentSection;
  factory LessonSection.quiz(QuizData data) = QuizSection;
  factory LessonSection.codeChallenge(CodeChallengeData data) = CodeChallengeSection;

  factory LessonSection.fromJson(Map<String, dynamic> json) {
    final type = json['type'] as String;
    final data = json['data'] as Map<String, dynamic>;
    
    switch (type) {
      case 'content':
        return LessonSection.content(ContentData.fromJson(data));
      case 'quiz':
        return LessonSection.quiz(QuizData.fromJson(data));
      case 'code_challenge':
        return LessonSection.codeChallenge(CodeChallengeData.fromJson(data));
      default:
        throw Exception('Unknown section type: $type');
    }
  }
  
  Map<String, dynamic> toJson() {
    if (this is ContentSection) {
      return {'type': 'content', 'data': (this as ContentSection).data.toJson()};
    } else if (this is QuizSection) {
      return {'type': 'quiz', 'data': (this as QuizSection).data.toJson()};
    } else if (this is CodeChallengeSection) {
      return {'type': 'code_challenge', 'data': (this as CodeChallengeSection).data.toJson()};
    }
    throw Exception('Unknown section type');
  }
  
  T when<T>({
    required T Function(ContentData data) content,
    required T Function(QuizData data) quiz,
    required T Function(CodeChallengeData data) codeChallenge,
  }) {
    if (this is ContentSection) {
      return content((this as ContentSection).data);
    } else if (this is QuizSection) {
      return quiz((this as QuizSection).data);
    } else if (this is CodeChallengeSection) {
      return codeChallenge((this as CodeChallengeSection).data);
    }
    throw Exception('Unknown section type');
  }
}

class ContentSection extends LessonSection {
  final ContentData data;
  const ContentSection(this.data) : super._();
}

class QuizSection extends LessonSection {
  final QuizData data;
  const QuizSection(this.data) : super._();
}

class CodeChallengeSection extends LessonSection {
  final CodeChallengeData data;
  const CodeChallengeSection(this.data) : super._();
}

@freezed
class ContentData with _$ContentData {
  const factory ContentData({
    required String markdown,
    List<String>? imageUrls,
    Map<String, dynamic>? examples,
  }) = _ContentData;

  factory ContentData.fromJson(Map<String, dynamic> json) => _$ContentDataFromJson(json);
}

@freezed
class QuizData with _$QuizData {
  const factory QuizData({
    required String question,
    required List<String> options,
    required int correctAnswerIndex,
    required String explanation,
    @Default(10) int xpReward,
  }) = _QuizData;

  factory QuizData.fromJson(Map<String, dynamic> json) => _$QuizDataFromJson(json);
}

@freezed
class CodeChallengeData with _$CodeChallengeData {
  const factory CodeChallengeData({
    required String description,
    required String codeExample,
    required List<String> options,
    required int correctAnswerIndex,
    required String explanation,
    required String detailedSolution,
    @Default(30) int xpReward,
  }) = _CodeChallengeData;

  factory CodeChallengeData.fromJson(Map<String, dynamic> json) => 
      _$CodeChallengeDataFromJson(json);
}
