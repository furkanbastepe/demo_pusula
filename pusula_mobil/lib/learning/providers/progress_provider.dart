import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/models.dart';
import '../services/services.dart';

// ═══════════════════════════════════════════════════════════════════════════════════
// 📊 PROGRESS PROVIDER
// ═══════════════════════════════════════════════════════════════════════════════════

final progressServiceProvider = Provider<ProgressService>((ref) {
  return ProgressService();
});

final progressProvider = StateNotifierProvider<ProgressNotifier, LearningProgress>((ref) {
  final progressService = ref.read(progressServiceProvider);
  return ProgressNotifier(progressService);
});

class ProgressNotifier extends StateNotifier<LearningProgress> {
  final ProgressService _progressService;

  ProgressNotifier(this._progressService) 
      : super(LearningProgress.initial('current_user')) {
    _loadProgress();
  }

  Future<void> _loadProgress() async {
    final progress = await _progressService.loadProgress('current_user');
    if (progress != null) {
      state = progress;
    }
  }

  Future<void> completeLesson(String courseId, String lessonId, int xpEarned) async {
    state = state.completeLesson(courseId, lessonId, xpEarned);
    state = state.updateStreak();
    await _progressService.saveProgress(state);
  }

  Future<void> updateStreak() async {
    state = state.updateStreak();
    await _progressService.saveProgress(state);
  }

  Future<void> addAchievement(String achievementId) async {
    state = state.addAchievement(achievementId);
    await _progressService.saveProgress(state);
  }

  Future<void> resetProgress() async {
    state = LearningProgress.initial('current_user');
    await _progressService.clearProgress();
  }
}
