import 'package:hooks_riverpod/hooks_riverpod.dart';
import '../../../providers/user_provider.dart';
import '../models/models.dart';
import '../services/problem_service.dart';

// ═══════════════════════════════════════════════════════════════════════════════════
// 🎯 PROBLEMS PROVIDERS - Problem-Based Learning
// ═══════════════════════════════════════════════════════════════════════════════════

/// Provider for ProblemService
final problemServiceProvider = Provider<ProblemService>((ref) {
  return ProblemService();
});

/// Provider for all open problems
final problemsProvider = FutureProvider<List<Problem>>((ref) async {
  final service = ref.watch(problemServiceProvider);
  return service.getProblems(status: ProblemStatus.open);
});

/// Provider for recommended problems based on user profile
final recommendedProblemsProvider = FutureProvider<List<Problem>>((ref) async {
  final user = ref.watch(userProvider);
  final service = ref.watch(problemServiceProvider);
  
  if (user == null) return [];
  
  return service.getRecommendedProblems(user);
});

/// Provider for a specific problem by ID
final problemProvider = FutureProvider.family<Problem?, String>(
  (ref, problemId) async {
    final service = ref.watch(problemServiceProvider);
    try {
      return await service.getProblemById(problemId);
    } catch (e) {
      return null;
    }
  },
);

/// Provider for saved problems
final savedProblemsProvider = FutureProvider<List<Problem>>((ref) async {
  final user = ref.watch(userProvider);
  final service = ref.watch(problemServiceProvider);
  
  if (user == null) return [];
  
  return service.getSavedProblems(user.id);
});

/// Provider for problem filters
final problemFiltersProvider = StateProvider<ProblemFilters>((ref) {
  return ProblemFilters();
});

/// Provider for filtered problems
final filteredProblemsProvider = FutureProvider<List<Problem>>((ref) async {
  final filters = ref.watch(problemFiltersProvider);
  final service = ref.watch(problemServiceProvider);
  
  return service.getProblems(
    impactArea: filters.impactArea,
    city: filters.city,
    requiredSkills: filters.requiredSkills,
    status: filters.status,
  );
});

// ═══════════════════════════════════════════════════════════════════════════════════
// FILTER MODEL
// ═══════════════════════════════════════════════════════════════════════════════════

class ProblemFilters {
  final ImpactArea? impactArea;
  final String? city;
  final List<String>? requiredSkills;
  final ProblemStatus? status;

  ProblemFilters({
    this.impactArea,
    this.city,
    this.requiredSkills,
    this.status,
  });

  ProblemFilters copyWith({
    ImpactArea? impactArea,
    String? city,
    List<String>? requiredSkills,
    ProblemStatus? status,
  }) {
    return ProblemFilters(
      impactArea: impactArea ?? this.impactArea,
      city: city ?? this.city,
      requiredSkills: requiredSkills ?? this.requiredSkills,
      status: status ?? this.status,
    );
  }

  bool get hasFilters =>
      impactArea != null ||
      (city != null && city!.isNotEmpty) ||
      (requiredSkills != null && requiredSkills!.isNotEmpty) ||
      status != null;

  ProblemFilters clear() {
    return ProblemFilters();
  }
}
