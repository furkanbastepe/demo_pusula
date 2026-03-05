import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import '../../../core/core.dart';
import '../../../widgets/common/glass_morphic_card.dart';
import '../providers/providers.dart';

// ═══════════════════════════════════════════════════════════════════════════════════
// 📚 COURSE DETAIL SCREEN
// ═══════════════════════════════════════════════════════════════════════════════════

class CourseDetailScreen extends ConsumerWidget {
  final String courseId;

  const CourseDetailScreen({super.key, required this.courseId});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final coursesAsync = ref.watch(coursesProvider);
    final progress = ref.watch(progressProvider);

    return Scaffold(
      backgroundColor: Colors.transparent,
      body: coursesAsync.when(
            data: (courses) {
              final course = courses.firstWhere((c) => c.id == courseId);
              final courseProgress = progress.courseProgress[courseId];
              final completedLessonIds = courseProgress?.completedLessonIds ?? [];
              final progressValue = course.calculateProgress(completedLessonIds);

              return SafeArea(
                child: CustomScrollView(
                  slivers: [
                    // App Bar
                    SliverAppBar(
                      leading: IconButton(
                        icon: const Icon(LucideIcons.arrowLeft, color: PColors.text),
                        onPressed: () => context.pop(),
                      ),
                      backgroundColor: Colors.transparent,
                      floating: true,
                    ),

                    // Course Header
                    SliverToBoxAdapter(
                      child: Padding(
                        padding: const EdgeInsets.all(16),
                        child: GlassMorphicCard(
                          child: Column(
                            children: [
                              // Icon
                              Container(
                                width: 100,
                                height: 100,
                                decoration: BoxDecoration(
                                  gradient: LinearGradient(
                                    colors: [
                                      PColors.primary,
                                      PColors.primary.withValues(alpha: 0.7),
                                    ],
                                  ),
                                  borderRadius: BorderRadius.circular(25),
                                ),
                                child: Center(
                                  child: Text(
                                    course.iconPath,
                                    style: const TextStyle(fontSize: 48),
                                  ),
                                ),
                              ),
                              const SizedBox(height: 16),
                              // Title
                              Text(
                                course.title,
                                style: GoogleFonts.poppins(
                                  fontSize: 24,
                                  fontWeight: FontWeight.bold,
                                  color: PColors.text,
                                ),
                                textAlign: TextAlign.center,
                              ),
                              const SizedBox(height: 8),
                              // Description
                              Text(
                                course.description,
                                style: GoogleFonts.inter(
                                  fontSize: 14,
                                  color: PColors.textDim,
                                ),
                                textAlign: TextAlign.center,
                              ),
                              const SizedBox(height: 20),
                              // Progress
                              ClipRRect(
                                borderRadius: BorderRadius.circular(10),
                                child: LinearProgressIndicator(
                                  value: progressValue,
                                  backgroundColor: PColors.surfaceHi,
                                  valueColor: const AlwaysStoppedAnimation<Color>(
                                    PColors.primary,
                                  ),
                                  minHeight: 10,
                                ),
                              ),
                              const SizedBox(height: 12),
                              Text(
                                '${completedLessonIds.length}/${course.totalLessons} ders tamamlandı',
                                style: GoogleFonts.inter(
                                  fontSize: 14,
                                  color: PColors.textDim,
                                ),
                              ),
                            ],
                          ),
                        ).animate().fadeIn().scale(),
                      ),
                    ),

                    // Lessons Section
                    SliverToBoxAdapter(
                      child: Padding(
                        padding: const EdgeInsets.all(16),
                        child: Text(
                          'Dersler',
                          style: GoogleFonts.poppins(
                            fontSize: 20,
                            fontWeight: FontWeight.w600,
                            color: PColors.text,
                          ),
                        ),
                      ),
                    ),

                    // Lessons List
                    SliverPadding(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      sliver: SliverList(
                        delegate: SliverChildBuilderDelegate(
                          (context, index) {
                            final lessonId = course.lessonIds[index];
                            final isCompleted = completedLessonIds.contains(lessonId);
                            // For demo: All lessons are always unlocked
                            final isUnlocked = true;

                            return _buildLessonCard(
                              context,
                              lessonId,
                              index + 1,
                              isCompleted,
                              isUnlocked,
                            ).animate(delay: ((index + 1) * 50).ms)
                                .fadeIn()
                                .slideX(begin: 0.2);
                          },
                          childCount: course.lessonIds.length,
                        ),
                      ),
                    ),

                    const SliverToBoxAdapter(child: SizedBox(height: 100)),
                  ],
                ),
              );
            },
            loading: () => const Center(
              child: CircularProgressIndicator(color: PColors.primary),
            ),
            error: (error, stack) => Center(
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
                      'Kurs Yüklenemedi',
                      style: GoogleFonts.poppins(
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                        color: PColors.text,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'Lütfen tekrar deneyin',
                      style: GoogleFonts.inter(
                        fontSize: 14,
                        color: PColors.textDim,
                      ),
                    ),
                    const SizedBox(height: 24),
                    ElevatedButton.icon(
                      onPressed: () => context.pop(),
                      icon: const Icon(LucideIcons.arrowLeft, size: 18),
                      label: Text(
                        'Geri Dön',
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
    );
  }

  Widget _buildLessonCard(
    BuildContext context,
    String lessonId,
    int lessonNumber,
    bool isCompleted,
    bool isUnlocked,
  ) {
    Color statusColor;
    IconData statusIcon;
    String statusText;

    if (isCompleted) {
      statusColor = PColors.success;
      statusIcon = LucideIcons.circleCheck;
      statusText = 'Tamamlandı';
    } else if (isUnlocked) {
      statusColor = PColors.primary;
      statusIcon = LucideIcons.play;
      statusText = 'Başla';
    } else {
      statusColor = PColors.textDim;
      statusIcon = LucideIcons.lock;
      statusText = 'Kilitli';
    }

    return GestureDetector(
      onTap: isUnlocked
          ? () => context.push('/learning/lesson/$courseId/$lessonId')
          : null,
      child: Container(
        margin: const EdgeInsets.only(bottom: 12),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: PColors.surface.withValues(alpha: 0.8),
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: isCompleted
                ? PColors.success.withValues(alpha: 0.3)
                : PColors.border.withValues(alpha: 0.3),
          ),
        ),
        child: Row(
          children: [
            // Lesson number
            Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                color: statusColor.withValues(alpha: 0.15),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Center(
                child: Text(
                  '$lessonNumber',
                  style: GoogleFonts.poppins(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: statusColor,
                  ),
                ),
              ),
            ),
            const SizedBox(width: 16),
            // Lesson title
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Ders $lessonNumber',
                    style: GoogleFonts.poppins(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: isUnlocked ? PColors.text : PColors.textDim,
                    ),
                  ),
                  Text(
                    lessonId,
                    style: GoogleFonts.inter(
                      fontSize: 12,
                      color: PColors.textDim,
                    ),
                  ),
                ],
              ),
            ),
            // Status
            Row(
              children: [
                Icon(statusIcon, color: statusColor, size: 20),
                const SizedBox(width: 8),
                Text(
                  statusText,
                  style: GoogleFonts.inter(
                    fontSize: 12,
                    color: statusColor,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
