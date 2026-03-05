import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/models.dart';
import 'progress_provider.dart';

// ═══════════════════════════════════════════════════════════════════════════════════
// 🏆 ACHIEVEMENTS PROVIDER
// ═══════════════════════════════════════════════════════════════════════════════════

final achievementsProvider = Provider<List<Achievement>>((ref) {
  return Achievement.getDefaultAchievements();
});

final earnedAchievementsProvider = Provider<List<Achievement>>((ref) {
  final progress = ref.watch(progressProvider);
  final allAchievements = ref.watch(achievementsProvider);
  
  return allAchievements.where((achievement) {
    return achievement.isEarned(progress);
  }).toList();
});

final newAchievementsProvider = Provider<List<Achievement>>((ref) {
  final progress = ref.watch(progressProvider);
  final allAchievements = ref.watch(achievementsProvider);
  
  return allAchievements.where((achievement) {
    return !achievement.isEarned(progress) && achievement.shouldEarn(progress);
  }).toList();
});
