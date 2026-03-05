import 'package:hooks_riverpod/hooks_riverpod.dart';
import '../../../providers/user_provider.dart';
import '../models/models.dart';
import '../services/workshop_service.dart';

// ═══════════════════════════════════════════════════════════════════════════════════
// 🎯 WORKSHOPS PROVIDERS - Problem-Based Learning
// ═══════════════════════════════════════════════════════════════════════════════════

/// Provider for WorkshopService
final workshopServiceProvider = Provider<WorkshopService>((ref) {
  return WorkshopService();
});

/// Provider for user's workshops
final userWorkshopsProvider = FutureProvider<List<SolutionWorkshop>>((ref) async {
  final user = ref.watch(userProvider);
  final service = ref.watch(workshopServiceProvider);
  
  if (user == null) return [];
  
  return service.getUserWorkshops(user.id);
});

/// Provider for workshops for a specific problem
final problemWorkshopsProvider = FutureProvider.family<List<SolutionWorkshop>, String>(
  (ref, problemId) async {
    final service = ref.watch(workshopServiceProvider);
    return service.getWorkshopsForProblem(problemId);
  },
);

/// Provider for a specific workshop by ID
final workshopProvider = FutureProvider.family<SolutionWorkshop?, String>(
  (ref, workshopId) async {
    final service = ref.watch(workshopServiceProvider);
    try {
      return await service.getWorkshopById(workshopId);
    } catch (e) {
      return null;
    }
  },
);

/// Provider for workshop progress
final workshopProgressProvider = FutureProvider.family<WorkshopProgress?, String>(
  (ref, workshopId) async {
    final service = ref.watch(workshopServiceProvider);
    try {
      return await service.getWorkshopProgress(workshopId);
    } catch (e) {
      return null;
    }
  },
);
