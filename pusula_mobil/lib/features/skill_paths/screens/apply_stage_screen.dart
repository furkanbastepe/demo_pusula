import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import 'package:go_router/go_router.dart';

import '../../../core/theme/colors.dart';
import '../../../widgets/common/glass_morphic_card.dart';
import '../models/models.dart';
import '../providers/projects_provider.dart';
import '../providers/progress_provider.dart';
import '../widgets/ai_validation_dialog.dart';

/// Apply Stage Screen
///
/// Displays practical task instructions for an apply stage.
/// Shows task, steps, tools, example output, and common mistakes.
class ApplyStageScreen extends HookConsumerWidget {
  final String projectId;
  final String stageId;

  const ApplyStageScreen({
    super.key,
    required this.projectId,
    required this.stageId,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final projectAsync = ref.watch(projectProvider(projectId));

    return Scaffold(
      backgroundColor: Colors.transparent,
      extendBodyBehindAppBar: true,
      body: projectAsync.when(
        data: (project) {
          if (project == null) {
            return Center(
              child: Text(
                'Proje bulunamadı',
                style: TextStyle(color: PColors.textDim),
              ),
            );
          }

          // Find the stage
          LearningStage? stage;
          ProjectModule? module;

          for (final m in project.modules) {
            final s = m.stages.firstWhere(
              (s) => s.id == stageId,
              orElse: () => m.stages.first,
            );
            if (s.id == stageId) {
              stage = s;
              module = m;
              break;
            }
          }

          if (stage == null || module == null) {
            return Center(
              child: Text(
                'Aşama bulunamadı',
                style: TextStyle(color: PColors.textDim),
              ),
            );
          }

          final applyContent = stage.content as ApplyContent;

          return _buildContent(
              context, ref, project, module, stage, applyContent);
        },
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, stack) => Center(
          child: Text(
            'Hata: $error',
            style: TextStyle(color: PColors.textDim),
          ),
        ),
      ),
    );
  }

  Widget _buildContent(
    BuildContext context,
    WidgetRef ref,
    ProjectSimulation project,
    ProjectModule module,
    LearningStage stage,
    ApplyContent content,
  ) {
    final isExpanded = useState(false);

    // Find stage index
    final stageIndex = module.stages.indexOf(stage);
    final totalStages = module.stages.length;

    return CustomScrollView(
      slivers: [
        // App Bar
        SliverAppBar(
          floating: true,
          backgroundColor: PColors.background.withValues(alpha: 0.9),
          leading: IconButton(
            icon: Icon(LucideIcons.chevronLeft, color: PColors.text),
            onPressed: () {
              // Find module ID for this stage
              String? moduleId;
              for (final m in project.modules) {
                if (m.stages.any((s) => s.id == stage.id)) {
                  moduleId = m.id;
                  break;
                }
              }
              if (moduleId != null && context.mounted) {
                context.go('/skill-paths/$projectId/module/$moduleId');
              }
            },
          ),
          title: Text(
            'Uygula',
            style: GoogleFonts.poppins(
              color: PColors.text,
              fontSize: 18,
              fontWeight: FontWeight.w600,
            ),
          ),
          actions: [
            IconButton(
              icon: Icon(LucideIcons.sparkles, color: PColors.primary),
              onPressed: () {
                // TODO: Open AI Coach with stage context
              },
              tooltip: 'AI Koç',
            ),
          ],
        ),

        SliverToBoxAdapter(
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Stage Header
                _buildStageHeader(stage, stageIndex, totalStages)
                    .animate()
                    .fadeIn(duration: 300.ms)
                    .slideY(begin: 0.2, duration: 300.ms),

                const SizedBox(height: 24),

                // Progress Indicator
                _buildProgressIndicator(stageIndex, totalStages)
                    .animate(delay: 100.ms)
                    .fadeIn(duration: 300.ms),

                const SizedBox(height: 24),

                // Task Section
                _buildTaskSection(content.task, content.deliverable)
                    .animate(delay: 200.ms)
                    .fadeIn()
                    .slideY(begin: 0.2),

                const SizedBox(height: 20),

                // Steps Section
                _buildStepsSection(content.steps)
                    .animate(delay: 300.ms)
                    .fadeIn()
                    .slideY(begin: 0.2),

                const SizedBox(height: 20),

                // Tools Section
                _buildToolsSection(content.tools)
                    .animate(delay: 400.ms)
                    .fadeIn()
                    .slideY(begin: 0.2),

                const SizedBox(height: 20),

                // Example Output Section
                _buildExampleOutputSection(content.exampleOutput)
                    .animate(delay: 500.ms)
                    .fadeIn()
                    .slideY(begin: 0.2),

                const SizedBox(height: 20),

                // Common Mistakes Section
                _buildCommonMistakesSection(
                  content.commonMistakes,
                  isExpanded,
                ).animate(delay: 600.ms).fadeIn().slideY(begin: 0.2),

                const SizedBox(height: 32),

                // Action Buttons
                _buildActionButtons(context, ref, project, module, stage, content)
                    .animate(delay: 700.ms)
                    .fadeIn()
                    .slideY(begin: 0.2),

                const SizedBox(height: 20),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildStageHeader(LearningStage stage, int index, int total) {
    return GlassMorphicCard(
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Stage Badge
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
              decoration: BoxDecoration(
                color: PColors.accent.withValues(alpha: 0.15),
                borderRadius: BorderRadius.circular(12),
                border: Border.all(
                  color: PColors.accent.withValues(alpha: 0.3),
                  width: 1,
                ),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(LucideIcons.code, size: 14, color: PColors.accent),
                  const SizedBox(width: 6),
                  Text(
                    'Uygula',
                    style: GoogleFonts.inter(
                      color: PColors.accent,
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 12),

            // Stage Title
            Text(
              stage.title,
              style: GoogleFonts.poppins(
                color: PColors.text,
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 12),

            // Stage Stats
            Row(
              children: [
                Icon(LucideIcons.zap, size: 16, color: PColors.accent),
                const SizedBox(width: 6),
                Text(
                  '${stage.xpReward} XP',
                  style: GoogleFonts.inter(
                    color: PColors.textDim,
                    fontSize: 14,
                  ),
                ),
                const SizedBox(width: 16),
                Icon(LucideIcons.clock, size: 16, color: PColors.info),
                const SizedBox(width: 6),
                Text(
                  '${stage.estimatedMinutes} dk',
                  style: GoogleFonts.inter(
                    color: PColors.textDim,
                    fontSize: 14,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildProgressIndicator(int current, int total) {
    return Row(
      children: [
        Text(
          'Aşama ${current + 1}/$total',
          style: GoogleFonts.inter(
            color: PColors.textDim,
            fontSize: 12,
            fontWeight: FontWeight.w500,
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: LinearProgressIndicator(
              value: (current + 1) / total,
              backgroundColor: PColors.surface,
              valueColor: AlwaysStoppedAnimation<Color>(PColors.accent),
              minHeight: 6,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildTaskSection(String task, String deliverable) {
    return GlassMorphicCard(
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Section Header
            Row(
              children: [
                Container(
                  width: 40,
                  height: 40,
                  decoration: BoxDecoration(
                    color: PColors.primary.withValues(alpha: 0.15),
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(
                      color: PColors.primary.withValues(alpha: 0.3),
                      width: 1,
                    ),
                  ),
                  child: Icon(LucideIcons.target, color: PColors.primary, size: 20),
                ),
                const SizedBox(width: 12),
                Text(
                  'Ne Yapacaksın?',
                  style: GoogleFonts.poppins(
                    color: PColors.text,
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),

            // Task Description
            Text(
              task,
              style: GoogleFonts.inter(
                color: PColors.text,
                fontSize: 15,
                height: 1.6,
              ),
            ),
            const SizedBox(height: 12),

            // Deliverable
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: PColors.success.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(12),
                border: Border.all(
                  color: PColors.success.withValues(alpha: 0.3),
                  width: 1,
                ),
              ),
              child: Row(
                children: [
                  Icon(LucideIcons.check, color: PColors.success, size: 20),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Text(
                      deliverable,
                      style: GoogleFonts.inter(
                        color: PColors.text,
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStepsSection(List<String> steps) {
    return GlassMorphicCard(
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Section Header
            Row(
              children: [
                Container(
                  width: 40,
                  height: 40,
                  decoration: BoxDecoration(
                    color: PColors.info.withValues(alpha: 0.15),
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(
                      color: PColors.info.withValues(alpha: 0.3),
                      width: 1,
                    ),
                  ),
                  child: Icon(LucideIcons.listOrdered, color: PColors.info, size: 20),
                ),
                const SizedBox(width: 12),
                Text(
                  'Adım Adım Rehber',
                  style: GoogleFonts.poppins(
                    color: PColors.text,
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),

            // Steps List
            ...steps.asMap().entries.map((entry) {
              final index = entry.key;
              final step = entry.value;
              return Padding(
                padding: EdgeInsets.only(bottom: index < steps.length - 1 ? 12 : 0),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      width: 28,
                      height: 28,
                      decoration: BoxDecoration(
                        color: PColors.info.withValues(alpha: 0.15),
                        shape: BoxShape.circle,
                        border: Border.all(
                          color: PColors.info.withValues(alpha: 0.3),
                          width: 1,
                        ),
                      ),
                      child: Center(
                        child: Text(
                          '${index + 1}',
                          style: GoogleFonts.inter(
                            color: PColors.info,
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.only(top: 4),
                        child: Text(
                          step,
                          style: GoogleFonts.inter(
                            color: PColors.text,
                            fontSize: 14,
                            height: 1.5,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              );
            }),
          ],
        ),
      ),
    );
  }

  Widget _buildToolsSection(List<String> tools) {
    return GlassMorphicCard(
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Section Header
            Row(
              children: [
                Container(
                  width: 40,
                  height: 40,
                  decoration: BoxDecoration(
                    color: PColors.accent.withValues(alpha: 0.15),
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(
                      color: PColors.accent.withValues(alpha: 0.3),
                      width: 1,
                    ),
                  ),
                  child: Icon(LucideIcons.wrench, color: PColors.accent, size: 20),
                ),
                const SizedBox(width: 12),
                Text(
                  'Kullanacağın Araçlar',
                  style: GoogleFonts.poppins(
                    color: PColors.text,
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),

            // Tools List
            ...tools.asMap().entries.map((entry) {
              final index = entry.key;
              final tool = entry.value;
              return Padding(
                padding: EdgeInsets.only(bottom: index < tools.length - 1 ? 8 : 0),
                child: Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: PColors.surface.withValues(alpha: 0.5),
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(
                      color: PColors.border.withValues(alpha: 0.3),
                      width: 1,
                    ),
                  ),
                  child: Row(
                    children: [
                      Icon(LucideIcons.package, size: 16, color: PColors.accent),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Text(
                          tool,
                          style: GoogleFonts.inter(
                            color: PColors.text,
                            fontSize: 14,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              );
            }),
          ],
        ),
      ),
    );
  }

  Widget _buildExampleOutputSection(String exampleOutput) {
    return GlassMorphicCard(
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Section Header
            Row(
              children: [
                Container(
                  width: 40,
                  height: 40,
                  decoration: BoxDecoration(
                    color: PColors.success.withValues(alpha: 0.15),
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(
                      color: PColors.success.withValues(alpha: 0.3),
                      width: 1,
                    ),
                  ),
                  child: Icon(LucideIcons.eye, color: PColors.success, size: 20),
                ),
                const SizedBox(width: 12),
                Text(
                  'Örnek Çıktı',
                  style: GoogleFonts.poppins(
                    color: PColors.text,
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),

            // Example Output
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: PColors.surface.withValues(alpha: 0.5),
                borderRadius: BorderRadius.circular(12),
                border: Border.all(
                  color: PColors.border.withValues(alpha: 0.3),
                  width: 1,
                ),
              ),
              child: Text(
                exampleOutput,
                style: GoogleFonts.sourceCodePro(
                  color: PColors.text,
                  fontSize: 13,
                  height: 1.5,
                ),
              ),
            ),
            const SizedBox(height: 12),

            // Note
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: PColors.success.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Row(
                children: [
                  Icon(LucideIcons.info, size: 16, color: PColors.success),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      'Senin çıktın buna benzemeli',
                      style: GoogleFonts.inter(
                        color: PColors.success,
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCommonMistakesSection(
    List<String> mistakes,
    ValueNotifier<bool> isExpanded,
  ) {
    return GlassMorphicCard(
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Section Header (Clickable)
            InkWell(
              onTap: () => isExpanded.value = !isExpanded.value,
              borderRadius: BorderRadius.circular(12),
              child: Row(
                children: [
                  Container(
                    width: 40,
                    height: 40,
                    decoration: BoxDecoration(
                      color: PColors.warning.withValues(alpha: 0.15),
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(
                        color: PColors.warning.withValues(alpha: 0.3),
                        width: 1,
                      ),
                    ),
                    child: Icon(LucideIcons.info,
                        color: PColors.warning, size: 20),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Text(
                      'Sık Yapılan Hatalar',
                      style: GoogleFonts.poppins(
                        color: PColors.text,
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                  Icon(
                    isExpanded.value
                        ? LucideIcons.chevronUp
                        : LucideIcons.chevronDown,
                    color: PColors.textDim,
                    size: 20,
                  ),
                ],
              ),
            ),

            // Expandable Content
            if (isExpanded.value) ...[
              const SizedBox(height: 16),
              ...mistakes.asMap().entries.map((entry) {
                final index = entry.key;
                final mistake = entry.value;
                return Padding(
                  padding:
                      EdgeInsets.only(bottom: index < mistakes.length - 1 ? 12 : 0),
                  child: Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: PColors.warning.withValues(alpha: 0.1),
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(
                        color: PColors.warning.withValues(alpha: 0.3),
                        width: 1,
                      ),
                    ),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Icon(LucideIcons.x, size: 16, color: PColors.warning),
                        const SizedBox(width: 12),
                        Expanded(
                          child: Text(
                            mistake,
                            style: GoogleFonts.inter(
                              color: PColors.text,
                              fontSize: 14,
                              height: 1.5,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              }),
            ],
          ],
        ),
      ),
    );
  }

  Widget _buildActionButtons(
    BuildContext context,
    WidgetRef ref,
    ProjectSimulation project,
    ProjectModule module,
    LearningStage stage,
    ApplyContent content,
  ) {
    return Column(
      children: [
        // Primary Action Button - Validate
        SizedBox(
          width: double.infinity,
          height: 56,
          child: ElevatedButton(
            onPressed: () {
              showDialog(
                context: context,
                barrierDismissible: false,
                builder: (context) => AIValidationDialog(
                  questions: content.validationQuestions,
                  onComplete: (passed) async {
                    if (passed) {
                      // Find module ID
                      String? moduleId;
                      for (final m in project.modules) {
                        if (m.stages.any((s) => s.id == stage.id)) {
                          moduleId = m.id;
                          break;
                        }
                      }
                      
                      if (moduleId != null) {
                        // Award XP and complete stage
                        final progressNotifier = ref.read(progressNotifierProvider.notifier);
                        await progressNotifier.completeStage(
                          project.id,
                          moduleId,
                          stage.id,
                          stage.xpReward,
                        );
                      }
                      
                      if (context.mounted) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text('Tebrikler! ${stage.xpReward} XP kazandın! 🎉'),
                            backgroundColor: PColors.success,
                            duration: Duration(seconds: 2),
                          ),
                        );
                        
                        // Navigate back to module
                        if (moduleId != null) {
                          context.go('/skill-paths/${project.id}/module/$moduleId');
                        }
                      }
                    }
                  },
                ),
              );
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: PColors.accent,
              foregroundColor: PColors.background,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
              elevation: 0,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(LucideIcons.check, size: 20),
                const SizedBox(width: 8),
                Text(
                  'Doğrula ve Devam Et',
                  style: GoogleFonts.poppins(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),
        ),
        const SizedBox(height: 12),

        // Secondary Action - AI Coach
        SizedBox(
          width: double.infinity,
          height: 48,
          child: OutlinedButton(
            onPressed: () {
              // TODO: Open AI Coach with stage context
            },
            style: OutlinedButton.styleFrom(
              foregroundColor: PColors.primary,
              side: BorderSide(color: PColors.primary.withValues(alpha: 0.3)),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(LucideIcons.sparkles, size: 18),
                const SizedBox(width: 8),
                Text(
                  'AI Koç ile Konuş',
                  style: GoogleFonts.poppins(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),
        ),
        const SizedBox(height: 12),

        // Tertiary Action - Back to Learn
        TextButton(
          onPressed: () {
            // Find module ID for this stage
            String? moduleId;
            for (final m in project.modules) {
              if (m.stages.any((s) => s.id == stage.id)) {
                moduleId = m.id;
                break;
              }
            }
            if (moduleId != null && context.mounted) {
              context.go('/skill-paths/$projectId/module/$moduleId');
            }
          },
          child: Text(
            'Öğren Aşamasına Dön',
            style: GoogleFonts.inter(
              color: PColors.textDim,
              fontSize: 14,
            ),
          ),
        ),
      ],
    );
  }
}
