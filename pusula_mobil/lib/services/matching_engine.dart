import '../data/data.dart';

// ═══════════════════════════════════════════════════════════════════════════════════
// 🤖 AI MATCHING ENGINE - ZAFER ÖZELLIK
// ═══════════════════════════════════════════════════════════════════════════════════

class PusulaMatchingEngine {
  static double calculateTaskMatch(AppUser user, Task task) {
    if (user.level.index < task.requiredLevel.index) return 0.0;
    
    double baseScore = 30.0;
    
    // Şehir uyumu
    if (user.city == task.city) {
      baseScore += 30.0;
    }
    
    // Beceri uyumu
    if (task.requiredSkills.isNotEmpty) {
      int matchingSkills = 0;
      for (String skill in task.requiredSkills) {
        if (user.skills.contains(skill) || user.skillPath == skill) {
          matchingSkills++;
        }
      }
      baseScore += (matchingSkills / task.requiredSkills.length) * 30.0;
    }
    
    // Güvenli mod
    if (task.womenOnly && user.safeMode) {
      baseScore += 10.0;
    }
    
    return baseScore.clamp(0.0, 100.0);
  }
}
