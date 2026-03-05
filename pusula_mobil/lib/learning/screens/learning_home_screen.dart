import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import '../../../core/core.dart';
import '../../../providers/providers.dart' as app_providers;
import '../../../widgets/common/aurora_background.dart';
import '../../../widgets/common/glass_morphic_card.dart';
import '../providers/providers.dart';
import '../widgets/widgets.dart';

// ═══════════════════════════════════════════════════════════════════════════════════
// 🎓 LEARNING HOME SCREEN
// ═══════════════════════════════════════════════════════════════════════════════════

class LearningHomeScreen extends ConsumerWidget {
  const LearningHomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final coursesAsync = ref.watch(coursesProvider);
    final progress = ref.watch(progressProvider);
    final achievements = ref.watch(achievementsProvider);

    return Scaffold(
      backgroundColor: PColors.background,
      body: Stack(
        children: [
          AuroraBackground(),
          SafeArea(
            child: CustomScrollView(
              slivers: [
                // App Bar
                SliverAppBar(
                  leading: IconButton(
                    icon: const Icon(
                      LucideIcons.arrowLeft,
                      color: PColors.text,
                    ),
                    onPressed: () {
                      ref
                              .read(
                                app_providers.navigationIndexProvider.notifier,
                              )
                              .state =
                          0;
                      context.go('/home');
                    },
                  ),
                  title: Text(
                    'Akademi',
                    style: GoogleFonts.poppins(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: PColors.text,
                    ),
                  ),
                  backgroundColor: Colors.transparent,
                  floating: true,
                  actions: [
                    IconButton(
                      icon: const Icon(
                        LucideIcons.settings,
                        color: PColors.textDim,
                      ),
                      onPressed: () {
                        // Settings
                      },
                    ),
                  ],
                ),

                // Streak & XP Card
                SliverToBoxAdapter(
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: GlassMorphicCard(
                      child: Row(
                        children: [
                          // Streak
                          Expanded(
                            child: Column(
                              children: [
                                Text('🔥', style: const TextStyle(fontSize: 32))
                                    .animate(
                                      onPlay: (controller) =>
                                          controller.repeat(),
                                    )
                                    .scale(
                                      duration: 1000.ms,
                                      begin: const Offset(1, 1),
                                      end: const Offset(1.1, 1.1),
                                    )
                                    .then()
                                    .scale(
                                      duration: 1000.ms,
                                      begin: const Offset(1.1, 1.1),
                                      end: const Offset(1, 1),
                                    ),
                                const SizedBox(height: 8),
                                Text(
                                  '${progress.currentStreak} günlük seri!',
                                  style: GoogleFonts.poppins(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w600,
                                    color: PColors.text,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Container(
                            width: 1,
                            height: 60,
                            color: PColors.border,
                          ),
                          // XP
                          Expanded(
                            child: Column(
                              children: [
                                Text(
                                  '💎',
                                  style: const TextStyle(fontSize: 32),
                                ),
                                const SizedBox(height: 8),
                                Text(
                                  '${progress.totalXP} XP',
                                  style: GoogleFonts.poppins(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w600,
                                    color: PColors.accent,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ).animate().fadeIn().slideY(begin: -0.2),
                  ),
                ),

                // Courses Section
                SliverToBoxAdapter(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: Text(
                      '📚 Kurslarım',
                      style: GoogleFonts.poppins(
                        fontSize: 20,
                        fontWeight: FontWeight.w600,
                        color: PColors.text,
                      ),
                    ).animate(delay: 100.ms).fadeIn(),
                  ),
                ),

                const SliverToBoxAdapter(child: SizedBox(height: 16)),

                // Courses List
                coursesAsync.when(
                  data: (courses) {
                    return SliverPadding(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      sliver: SliverList(
                        delegate: SliverChildBuilderDelegate((context, index) {
                          final course = courses[index];
                          final courseProgress =
                              progress.courseProgress[course.id];
                          final completedLessons =
                              courseProgress?.completedLessonIds.length ?? 0;
                          final progressValue = course.calculateProgress(
                            courseProgress?.completedLessonIds ?? [],
                          );

                          return CourseCard(
                                course: course,
                                progress: progressValue,
                                completedLessons: completedLessons,
                                onTap: () {
                                  context.push('/learning/course/${course.id}');
                                },
                              )
                              .animate(delay: ((index + 1) * 100).ms)
                              .fadeIn()
                              .slideX(begin: 0.2);
                        }, childCount: courses.length),
                      ),
                    );
                  },
                  loading: () => const SliverToBoxAdapter(
                    child: Center(
                      child: CircularProgressIndicator(color: PColors.primary),
                    ),
                  ),
                  error: (error, stack) => SliverToBoxAdapter(
                    child: Center(
                      child: Padding(
                        padding: const EdgeInsets.all(32),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              LucideIcons.triangleAlert,
                              size: 64,
                              color: PColors.warning,
                            ),
                            const SizedBox(height: 16),
                            Text(
                              'Kurslar Yüklenemedi',
                              style: GoogleFonts.poppins(
                                fontSize: 18,
                                fontWeight: FontWeight.w600,
                                color: PColors.text,
                              ),
                            ),
                            const SizedBox(height: 8),
                            Text(
                              'İnternet bağlantınızı kontrol edin',
                              style: GoogleFonts.inter(
                                fontSize: 14,
                                color: PColors.textDim,
                              ),
                              textAlign: TextAlign.center,
                            ),
                            const SizedBox(height: 24),
                            ElevatedButton.icon(
                              onPressed: () {
                                ref.invalidate(coursesProvider);
                              },
                              icon: const Icon(LucideIcons.refreshCw, size: 18),
                              label: Text(
                                'Tekrar Dene',
                                style: GoogleFonts.inter(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              style: ElevatedButton.styleFrom(
                                backgroundColor: PColors.primary,
                                foregroundColor: Colors.white,
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 24,
                                  vertical: 12,
                                ),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),

                const SliverToBoxAdapter(child: SizedBox(height: 24)),

                // Projects Section
                SliverToBoxAdapter(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          '💼 Simülasyon Projeleri',
                          style: GoogleFonts.poppins(
                            fontSize: 20,
                            fontWeight: FontWeight.w600,
                            color: PColors.text,
                          ),
                        ),
                        TextButton(
                          onPressed: () {
                            context.go('/skill-paths');
                          },
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text(
                                'Tümünü Gör',
                                style: GoogleFonts.inter(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600,
                                  color: PColors.primary,
                                ),
                              ),
                              const SizedBox(width: 4),
                              const Icon(
                                LucideIcons.arrowRight,
                                size: 16,
                                color: PColors.primary,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ).animate(delay: 300.ms).fadeIn(),
                  ),
                ),

                const SliverToBoxAdapter(child: SizedBox(height: 12)),

                SliverToBoxAdapter(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: GlassMorphicCard(
                      child: InkWell(
                        onTap: () {
                          context.go('/skill-paths');
                        },
                        borderRadius: BorderRadius.circular(16),
                        child: Padding(
                          padding: const EdgeInsets.all(20),
                          child: Row(
                            children: [
                              Container(
                                width: 56,
                                height: 56,
                                decoration: BoxDecoration(
                                  color: PColors.accent.withValues(alpha: 0.15),
                                  borderRadius: BorderRadius.circular(16),
                                ),
                                child: const Center(
                                  child: Text(
                                    '🎯',
                                    style: TextStyle(fontSize: 28),
                                  ),
                                ),
                              ),
                              const SizedBox(width: 16),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'Simülasyon Projeleri',
                                      style: GoogleFonts.poppins(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w600,
                                        color: PColors.text,
                                      ),
                                    ),
                                    const SizedBox(height: 4),
                                    Text(
                                      'Öğrendiklerinle pratik yap',
                                      style: GoogleFonts.inter(
                                        fontSize: 13,
                                        color: PColors.textDim,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              const Icon(
                                LucideIcons.chevronRight,
                                size: 24,
                                color: PColors.textDim,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ).animate(delay: 350.ms).fadeIn().slideX(begin: 0.2),
                  ),
                ),

                const SliverToBoxAdapter(child: SizedBox(height: 24)),

                // Achievements Section
                SliverToBoxAdapter(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: Text(
                      '🏆 Başarılarım',
                      style: GoogleFonts.poppins(
                        fontSize: 20,
                        fontWeight: FontWeight.w600,
                        color: PColors.text,
                      ),
                    ).animate(delay: 300.ms).fadeIn(),
                  ),
                ),

                const SliverToBoxAdapter(child: SizedBox(height: 16)),

                // Achievements List
                SliverToBoxAdapter(
                  child: SizedBox(
                    height: 120,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      itemCount: achievements.length,
                      itemBuilder: (context, index) {
                        final achievement = achievements[index];
                        final isEarned = achievement.isEarned(progress);
                        return AchievementBadge(
                              achievement: achievement,
                              isEarned: isEarned,
                            )
                            .animate(delay: ((index + 4) * 100).ms)
                            .fadeIn()
                            .scale();
                      },
                    ),
                  ),
                ),

                const SliverToBoxAdapter(child: SizedBox(height: 100)),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
