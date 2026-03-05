import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import '../../../core/core.dart';
import '../../../widgets/common/glass_button.dart';
import '../../../widgets/common/primary_cta_button.dart';
import '../models/models.dart';
import '../providers/providers.dart';
import '../widgets/widgets.dart';

// ═══════════════════════════════════════════════════════════════════════════════════
// 📖 LESSON SCREEN
// ═══════════════════════════════════════════════════════════════════════════════════

class LessonScreen extends ConsumerStatefulWidget {
  final String courseId;
  final String lessonId;

  const LessonScreen({
    super.key,
    required this.courseId,
    required this.lessonId,
  });

  @override
  ConsumerState<LessonScreen> createState() => _LessonScreenState();
}

class _LessonScreenState extends ConsumerState<LessonScreen> {
  int currentSectionIndex = 0;
  int earnedXP = 0;

  @override
  Widget build(BuildContext context) {
    final lessonAsync = ref.watch(lessonProvider(
      LessonParams(courseId: widget.courseId, lessonId: widget.lessonId),
    ));

    return Scaffold(
      backgroundColor: Colors.transparent,
      body: lessonAsync.when(
            data: (lesson) => _buildLessonContent(lesson),
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
                      'Ders Yüklenemedi',
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
                    GlassButton(
                      label: 'Geri Dön',
                      icon: LucideIcons.arrowLeft,
                      onPressed: () => context.pop(),
                    ),
                  ],
                ),
              ),
            ),
          ),
    );
  }

  Widget _buildLessonContent(Lesson lesson) {
    final section = lesson.sections[currentSectionIndex];
    final isLastSection = currentSectionIndex == lesson.sections.length - 1;

    return SafeArea(
      child: Column(
        children: [
          // App Bar
          Container(
            padding: const EdgeInsets.all(16),
            child: Row(
              children: [
                IconButton(
                  icon: const Icon(LucideIcons.arrowLeft, color: PColors.text),
                  onPressed: () => context.pop(),
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        lesson.title,
                        style: GoogleFonts.poppins(
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                          color: PColors.text,
                        ),
                      ),
                      Text(
                        'Bölüm ${currentSectionIndex + 1}/${lesson.sections.length}',
                        style: GoogleFonts.inter(
                          fontSize: 12,
                          color: PColors.textDim,
                        ),
                      ),
                    ],
                  ),
                ),
                IconButton(
                  icon: const Icon(LucideIcons.bot, color: PColors.primary),
                  tooltip: 'AI Yardım',
                  onPressed: () {
                    // Get current section content for context
                    final section = lesson.sections[currentSectionIndex];
                    String lessonContext = 'Ders: ${lesson.title}\n\n';
                    
                    section.when(
                      content: (data) {
                        lessonContext += data.markdown;
                      },
                      quiz: (data) {
                        lessonContext += 'Quiz: ${data.question}';
                      },
                      codeChallenge: (data) {
                        lessonContext += 'Kod Challenge: ${data.description}\n${data.codeExample}';
                      },
                    );
                    
                    openAIChat(context, lessonContext: lessonContext);
                  },
                ),
                if (earnedXP > 0)
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                    decoration: BoxDecoration(
                      color: PColors.accent.withValues(alpha: 0.15),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Text(
                      '+$earnedXP XP',
                      style: GoogleFonts.inter(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: PColors.accent,
                      ),
                    ),
                  ).animate().scale().shimmer(),
              ],
            ),
          ),

          // Progress bar
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: LinearProgressIndicator(
                value: (currentSectionIndex + 1) / lesson.sections.length,
                backgroundColor: PColors.surfaceHi,
                valueColor: const AlwaysStoppedAnimation<Color>(PColors.primary),
                minHeight: 6,
              ),
            ),
          ),

          const SizedBox(height: 16),

          // Section Content
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(16),
              child: section.when(
                content: (data) => LessonContentWidget(content: data),
                quiz: (data) => QuizWidget(
                  quiz: data,
                  onAnswered: (isCorrect, xp) {
                    setState(() {
                      earnedXP += xp;
                    });
                  },
                ),
                codeChallenge: (data) => CodeChallengeWidget(
                  challenge: data,
                  onAnswered: (isCorrect, xp) {
                    setState(() {
                      earnedXP += xp;
                    });
                  },
                ),
              ).animate().fadeIn().slideY(begin: 0.2),
            ),
          ),

          // Navigation Button
          Padding(
            padding: const EdgeInsets.all(16),
            child: PrimaryCTAButton(
              label: isLastSection ? 'Dersi Tamamla' : 'Devam Et',
              onPressed: () => _handleNext(lesson, isLastSection),
              margin: EdgeInsets.zero,
            ),
          ),
        ],
      ),
    );
  }

  void _handleNext(Lesson lesson, bool isLastSection) {
    if (isLastSection) {
      // Complete lesson
      ref.read(progressProvider.notifier).completeLesson(
        widget.courseId,
        widget.lessonId,
        earnedXP,
      );

      // Check for new achievements
      final newAchievements = ref.read(newAchievementsProvider);
      
      // Show success dialog
      if (!mounted) return;
      showDialog(
        context: context,
        builder: (dialogContext) => AlertDialog(
          backgroundColor: PColors.surface,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text('🎉', style: TextStyle(fontSize: 64)),
              const SizedBox(height: 16),
              Text(
                'Ders Tamamlandı!',
                style: GoogleFonts.poppins(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: PColors.text,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                '+$earnedXP XP kazandın!',
                style: GoogleFonts.inter(
                  fontSize: 16,
                  color: PColors.accent,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: 24),
              PrimaryCTAButton(
                label: 'Harika!',
                onPressed: () {
                  Navigator.of(dialogContext).pop(); // Close dialog
                  
                  // Show achievement notifications if any
                  if (newAchievements.isNotEmpty) {
                    for (final achievement in newAchievements) {
                      ref.read(progressProvider.notifier).addAchievement(achievement.id);
                      Future.delayed(const Duration(milliseconds: 500), () {
                        if (mounted) {
                          AchievementNotificationDialog.show(
                            context,
                            achievement,
                            bonusXP: 50,
                          );
                        }
                      });
                    }
                  }
                  
                  // Go back to course detail screen
                  if (mounted) {
                    Navigator.of(context).pop();
                  }
                },
                margin: EdgeInsets.zero,
              ),
            ],
          ),
        ),
      );
    } else {
      // Next section
      setState(() {
        currentSectionIndex++;
      });
    }
  }
}
