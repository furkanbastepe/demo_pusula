import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../screens/screens.dart';
import '../../features/skill_paths/screens/screens.dart';
import '../../learning/screens/screens.dart';
import '../../features/problem_based_learning/screens/problems_list_screen.dart';
import '../../screens/digem_guide/digem_guide_dashboard_screen.dart';
import '../widgets/error_screen.dart';


// ═══════════════════════════════════════════════════════════════════════════════════
// 🚦 APP ROUTER CONFIGURATION
// ═══════════════════════════════════════════════════════════════════════════════════

final routerProvider = Provider<GoRouter>((ref) {
  return GoRouter(
    initialLocation: '/splash',
    errorBuilder: (context, state) => ErrorScreen(
      error: state.error,
      onRetry: () => context.go('/home'),
    ),
    routes: [
      GoRoute(
        path: '/splash',
        builder: (context, state) => const SplashScreen(),
      ),
      GoRoute(
        path: '/login',
        builder: (context, state) => const LoginScreen(),
      ),
      GoRoute(
        path: '/role-selection',
        builder: (context, state) => const RoleSelectionScreen(),
      ),
      GoRoute(
        path: '/onboarding',
        builder: (context, state) => const CalibrationScreen(),
      ),
      GoRoute(
        path: '/calibration-success',
        builder: (context, state) => const CalibrationSuccessScreen(),
      ),
      GoRoute(
        path: '/home',
        builder: (context, state) => const HomeScreen(),
      ),
      GoRoute(
        path: '/projects',
        builder: (context, state) => const ProjectsScreen(),
      ),
      GoRoute(
        path: '/workshops',
        builder: (context, state) => const WorkshopsScreen(),
      ),
      GoRoute(
        path: '/community',
        builder: (context, state) => const CommunityScreen(),
      ),
      GoRoute(
        path: '/profile',
        builder: (context, state) => const ProfileScreen(),
      ),
      GoRoute(
        path: '/digem-guide',
        builder: (context, state) => const DigemGuideDashboardScreen(),
      ),
      // Problem-Based Learning
      GoRoute(
        path: '/problems',
        builder: (context, state) => const ProblemsListScreen(),
      ),
      // Learning (Academy)
      GoRoute(
        path: '/learning',
        builder: (context, state) => const LearningHomeScreen(),
      ),
      GoRoute(
        path: '/learning/course/:courseId',
        builder: (context, state) {
          final courseId = state.pathParameters['courseId']!;
          return CourseDetailScreen(courseId: courseId);
        },
      ),
      GoRoute(
        path: '/learning/lesson/:courseId/:lessonId',
        builder: (context, state) {
          final courseId = state.pathParameters['courseId']!;
          final lessonId = state.pathParameters['lessonId']!;
          return LessonScreen(
            courseId: courseId,
            lessonId: lessonId,
          );
        },
      ),
      // Skill Paths (Project-based Learning / Simulations)
      GoRoute(
        path: '/skill-paths',
        builder: (context, state) => const SkillPathSelectionScreen(),
      ),
      GoRoute(
        path: '/simulations',
        builder: (context, state) => const SkillPathSelectionScreen(),
      ),
      GoRoute(
        path: '/skill-paths/:projectId',
        builder: (context, state) {
          final projectId = state.pathParameters['projectId']!;
          return ProjectOverviewScreen(projectId: projectId);
        },
      ),
      GoRoute(
        path: '/skill-paths/:projectId/module/:moduleId',
        builder: (context, state) {
          final projectId = state.pathParameters['projectId']!;
          final moduleId = state.pathParameters['moduleId']!;
          return ModuleDetailScreen(
            projectId: projectId,
            moduleId: moduleId,
          );
        },
      ),
      GoRoute(
        path: '/skill-paths/:projectId/stage/:stageId',
        builder: (context, state) {
          final projectId = state.pathParameters['projectId']!;
          final stageId = state.pathParameters['stageId']!;
          return LearnStageScreen(
            projectId: projectId,
            stageId: stageId,
          );
        },
      ),
    ],
  );
});
