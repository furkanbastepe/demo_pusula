import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../data/models/app_user.dart';
import '../models/models.dart';

// ═══════════════════════════════════════════════════════════════════════════════════
// 🎯 PROBLEM SERVICE - Problem-Based Learning
// ═══════════════════════════════════════════════════════════════════════════════════

class ProblemService {
  // Singleton pattern
  static final ProblemService _instance = ProblemService._internal();
  factory ProblemService() => _instance;
  ProblemService._internal();

  // In-memory cache
  final Map<String, Problem> _problemCache = {};
  final Map<String, DateTime> _cacheTimestamps = {};
  final Duration _cacheExpiry = const Duration(minutes: 15);
  List<Problem>? _allProblems;

  // Problem IDs
  static const List<String> _problemIds = [
    'problem_traffic_analysis',
    'problem_elderly_education',
    'problem_waste_management',
    'problem_local_business_digital',
    'problem_health_appointment',
    'problem_cultural_heritage',
    'problem_social_assistance',
    'problem_smart_parking',
    'problem_student_mentorship',
    'problem_air_quality',
  ];

  // ═══════════════════════════════════════════════════════════════════════════════════
  // PROBLEM DISCOVERY
  // ═══════════════════════════════════════════════════════════════════════════════════

  /// Get all problems with optional filters
  Future<List<Problem>> getProblems({
    ImpactArea? impactArea,
    String? city,
    List<String>? requiredSkills,
    ProblemStatus? status,
  }) async {
    // Load all problems if not cached
    if (_allProblems == null) {
      await _loadAllProblems();
    }

    var problems = List<Problem>.from(_allProblems ?? []);

    // Apply filters
    if (impactArea != null) {
      problems = problems.where((p) => p.impactArea == impactArea).toList();
    }

    if (city != null && city.isNotEmpty) {
      problems = problems
          .where((p) => p.city.toLowerCase() == city.toLowerCase())
          .toList();
    }

    if (status != null) {
      problems = problems.where((p) => p.status == status).toList();
    }

    if (requiredSkills != null && requiredSkills.isNotEmpty) {
      problems = problems.where((p) {
        return p.requiredSkills.any((skill) =>
            requiredSkills.any((rs) => skill.toLowerCase().contains(rs.toLowerCase())));
      }).toList();
    }

    return problems;
  }

  /// Load all problems from assets
  Future<void> _loadAllProblems() async {
    final problems = <Problem>[];

    for (final id in _problemIds) {
      try {
        final problem = await getProblemById(id);
        problems.add(problem);
      } catch (e) {
        // Skip problems that fail to load
        continue;
      }
    }

    _allProblems = problems;
  }

  /// Get a specific problem by ID
  Future<Problem> getProblemById(String id) async {
    // Check cache first
    if (_problemCache.containsKey(id)) {
      final timestamp = _cacheTimestamps[id]!;
      if (DateTime.now().difference(timestamp) < _cacheExpiry) {
        return _problemCache[id]!;
      }
    }

    try {
      final jsonString = await rootBundle.loadString(
        'assets/problems/$id.json',
      );
      final json = jsonDecode(jsonString) as Map<String, dynamic>;
      final problem = Problem.fromJson(json);

      // Update cache
      _problemCache[id] = problem;
      _cacheTimestamps[id] = DateTime.now();

      return problem;
    } catch (e) {
      throw Exception('Failed to load problem $id: $e');
    }
  }

  /// Get recommended problems for user based on matching algorithm
  Future<List<Problem>> getRecommendedProblems(AppUser user) async {
    final allProblems = await getProblems(status: ProblemStatus.open);

    // Calculate match score for each problem
    final problemsWithScores = allProblems.map((problem) {
      final score = calculateProblemMatch(user, problem);
      return {'problem': problem, 'score': score};
    }).toList();

    // Sort by match score (highest first)
    problemsWithScores.sort((a, b) =>
        (b['score'] as double).compareTo(a['score'] as double));

    // Return top problems
    return problemsWithScores
        .map((item) => item['problem'] as Problem)
        .toList();
  }

  // ═══════════════════════════════════════════════════════════════════════════════════
  // PROBLEM SUBMISSION (Organizations)
  // ═══════════════════════════════════════════════════════════════════════════════════

  /// Submit a new problem
  Future<Problem> submitProblem(ProblemSubmission submission) async {
    // Generate unique ID
    final id = 'prob_${DateTime.now().millisecondsSinceEpoch}';

    // Convert submission to problem
    final problem = submission.toProblem(impactScore: 50).copyWith(id: id);

    // Store in cache
    _problemCache[id] = problem;
    _cacheTimestamps[id] = DateTime.now();

    // Add to all problems list
    if (_allProblems != null) {
      _allProblems!.add(problem);
    }

    // In production, this would save to backend
    // For now, we'll store in SharedPreferences
    await _saveProblemToStorage(problem);

    return problem;
  }

  /// Update problem details
  Future<void> updateProblem(String id, Map<String, dynamic> updates) async {
    final problem = await getProblemById(id);

    // Apply updates (simplified - in production would use proper update logic)
    final updatedProblem = problem.copyWith(
      title: updates['title'] as String? ?? problem.title,
      description: updates['description'] as String? ?? problem.description,
      status: updates['status'] != null
          ? ProblemStatus.values.firstWhere((e) => e.name == updates['status'])
          : problem.status,
    );

    // Update cache
    _problemCache[id] = updatedProblem;
    _cacheTimestamps[id] = DateTime.now();

    // Update in all problems list
    if (_allProblems != null) {
      final index = _allProblems!.indexWhere((p) => p.id == id);
      if (index != -1) {
        _allProblems![index] = updatedProblem;
      }
    }

    await _saveProblemToStorage(updatedProblem);
  }

  // ═══════════════════════════════════════════════════════════════════════════════════
  // PROBLEM ENGAGEMENT
  // ═══════════════════════════════════════════════════════════════════════════════════

  /// Increment view count
  Future<void> incrementViews(String problemId) async {
    final problem = await getProblemById(problemId);
    final updatedEngagement = problem.engagement.copyWith(
      views: problem.engagement.views + 1,
    );
    final updatedProblem = problem.copyWith(engagement: updatedEngagement);

    _problemCache[problemId] = updatedProblem;
    _cacheTimestamps[problemId] = DateTime.now();

    await _saveProblemToStorage(updatedProblem);
  }

  /// Save problem for user
  Future<void> saveProblem(String userId, String problemId) async {
    final prefs = await SharedPreferences.getInstance();
    final key = 'saved_problems_$userId';
    final savedProblems = prefs.getStringList(key) ?? [];

    if (!savedProblems.contains(problemId)) {
      savedProblems.add(problemId);
      await prefs.setStringList(key, savedProblems);

      // Update engagement
      final problem = await getProblemById(problemId);
      final updatedEngagement = problem.engagement.copyWith(
        saves: problem.engagement.saves + 1,
      );
      final updatedProblem = problem.copyWith(engagement: updatedEngagement);
      _problemCache[problemId] = updatedProblem;
      await _saveProblemToStorage(updatedProblem);
    }
  }

  /// Unsave problem for user
  Future<void> unsaveProblem(String userId, String problemId) async {
    final prefs = await SharedPreferences.getInstance();
    final key = 'saved_problems_$userId';
    final savedProblems = prefs.getStringList(key) ?? [];

    if (savedProblems.contains(problemId)) {
      savedProblems.remove(problemId);
      await prefs.setStringList(key, savedProblems);

      // Update engagement
      final problem = await getProblemById(problemId);
      final updatedEngagement = problem.engagement.copyWith(
        saves: problem.engagement.saves - 1,
      );
      final updatedProblem = problem.copyWith(engagement: updatedEngagement);
      _problemCache[problemId] = updatedProblem;
      await _saveProblemToStorage(updatedProblem);
    }
  }

  /// Get saved problems for user
  Future<List<Problem>> getSavedProblems(String userId) async {
    final prefs = await SharedPreferences.getInstance();
    final key = 'saved_problems_$userId';
    final savedProblemIds = prefs.getStringList(key) ?? [];

    final problems = <Problem>[];
    for (final id in savedProblemIds) {
      try {
        final problem = await getProblemById(id);
        problems.add(problem);
      } catch (e) {
        // Skip problems that fail to load
        continue;
      }
    }

    return problems;
  }

  // ═══════════════════════════════════════════════════════════════════════════════════
  // PROBLEM MATCHING ALGORITHM
  // ═══════════════════════════════════════════════════════════════════════════════════

  /// Calculate match score between user and problem (0-100)
  double calculateProblemMatch(AppUser user, Problem problem) {
    double score = 0.0;

    // Skill match (40%)
    final skillMatch = _calculateSkillMatch(user.skills, problem.requiredSkills);
    score += skillMatch * 0.4;

    // City match (20%)
    if (user.city.toLowerCase() == problem.city.toLowerCase()) {
      score += 20.0;
    }

    // Impact area interest (20%) - based on skill path
    // This is a simplified version - in production would use user interests
    score += 10.0; // Base interest score

    // Level appropriateness (20%)
    final levelScore = _calculateLevelMatch(user.level, problem.requiredSkills.length);
    score += levelScore * 0.2;

    return score.clamp(0.0, 100.0);
  }

  double _calculateSkillMatch(List<String> userSkills, List<String> requiredSkills) {
    if (requiredSkills.isEmpty) return 100.0;

    final matchCount = requiredSkills.where((skill) =>
        userSkills.any((userSkill) =>
            userSkill.toLowerCase().contains(skill.toLowerCase()) ||
            skill.toLowerCase().contains(userSkill.toLowerCase()))).length;

    return (matchCount / requiredSkills.length) * 100.0;
  }

  double _calculateLevelMatch(dynamic userLevel, int skillCount) {
    // Convert UserLevel to numeric value
    int levelValue = 0;
    if (userLevel.toString().contains('cirak')) levelValue = 1;
    else if (userLevel.toString().contains('kalfa')) levelValue = 2;
    else if (userLevel.toString().contains('usta')) levelValue = 3;
    else if (userLevel.toString().contains('buyukUsta')) levelValue = 4;

    // More skills required = higher level needed
    final requiredLevel = (skillCount / 2).ceil().clamp(1, 4);

    // Calculate match (closer levels = higher score)
    final difference = (levelValue - requiredLevel).abs();
    return (100.0 - (difference * 25.0)).clamp(0.0, 100.0);
  }

  // ═══════════════════════════════════════════════════════════════════════════════════
  // UTILITY METHODS
  // ═══════════════════════════════════════════════════════════════════════════════════

  /// Save problem to storage
  Future<void> _saveProblemToStorage(Problem problem) async {
    final prefs = await SharedPreferences.getInstance();
    final key = 'problem_${problem.id}';
    final json = jsonEncode(problem.toJson());
    await prefs.setString(key, json);
  }

  /// Invalidate cache
  void invalidateCache([String? id]) {
    if (id != null) {
      _problemCache.remove(id);
      _cacheTimestamps.remove(id);
    } else {
      _problemCache.clear();
      _cacheTimestamps.clear();
      _allProblems = null;
    }
  }

  /// Clear all cache (useful for testing)
  void clearCache() {
    invalidateCache();
  }
}
