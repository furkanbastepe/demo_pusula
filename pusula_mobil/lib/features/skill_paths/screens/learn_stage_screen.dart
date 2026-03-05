import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import 'package:go_router/go_router.dart';

import '../../../core/theme/colors.dart';
import '../../../widgets/common/glass_morphic_card.dart';
import '../models/models.dart';
import '../providers/projects_provider.dart';

/// Learn Stage Screen
///
/// Displays theory and concept explanation for a learning stage.
/// Shows "Nedir?", "Neden Önemli?", "Nasıl Çalışır?", and "Örnek" sections.
class LearnStageScreen extends HookConsumerWidget {
  final String projectId;
  final String stageId;

  const LearnStageScreen({
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

          final learnContent = stage.content as LearnContent;

          return _buildContent(context, ref, project, module, stage, learnContent);
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
    LearnContent content,
  ) {
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
            'Öğren',
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
              tooltip: 'AI Koç\'a Sor',
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

                // Content Sections
                _buildContentSection(
                  icon: LucideIcons.info,
                  title: 'Nedir?',
                  content: content.definition,
                  color: PColors.primary,
                ).animate(delay: 200.ms).fadeIn().slideY(begin: 0.2),

                const SizedBox(height: 20),

                _buildContentSection(
                  icon: LucideIcons.lightbulb,
                  title: 'Neden Önemli?',
                  content: content.whyImportant,
                  color: PColors.accent,
                ).animate(delay: 300.ms).fadeIn().slideY(begin: 0.2),

                const SizedBox(height: 20),

                _buildContentSection(
                  icon: LucideIcons.settings,
                  title: 'Nasıl Çalışır?',
                  content: content.howItWorks,
                  color: PColors.info,
                ).animate(delay: 400.ms).fadeIn().slideY(begin: 0.2),

                const SizedBox(height: 20),

                // Examples Section
                if (content.examples.isNotEmpty)
                  _buildExamplesSection(content.examples)
                      .animate(delay: 500.ms)
                      .fadeIn()
                      .slideY(begin: 0.2),

                const SizedBox(height: 32),

                // Action Button
                _buildActionButton(context, project, module, stage)
                    .animate(delay: 600.ms)
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
                color: PColors.primary.withValues(alpha: 0.15),
                borderRadius: BorderRadius.circular(12),
                border: Border.all(
                  color: PColors.primary.withValues(alpha: 0.3),
                  width: 1,
                ),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(LucideIcons.bookOpen, size: 14, color: PColors.primary),
                  const SizedBox(width: 6),
                  Text(
                    'Öğren',
                    style: GoogleFonts.inter(
                      color: PColors.primary,
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
                  '${stage.estimatedMinutes} dk okuma',
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
              valueColor: AlwaysStoppedAnimation<Color>(PColors.primary),
              minHeight: 6,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildContentSection({
    required IconData icon,
    required String title,
    required String content,
    required Color color,
  }) {
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
                    color: color.withValues(alpha: 0.15),
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(
                      color: color.withValues(alpha: 0.3),
                      width: 1,
                    ),
                  ),
                  child: Icon(icon, color: color, size: 20),
                ),
                const SizedBox(width: 12),
                Text(
                  title,
                  style: GoogleFonts.poppins(
                    color: PColors.text,
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),

            // Section Content
            Text(
              content,
              style: GoogleFonts.inter(
                color: PColors.text,
                fontSize: 15,
                height: 1.6,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildExamplesSection(List<String> examples) {
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
                  child: Icon(
                    LucideIcons.code,
                    color: PColors.success,
                    size: 20,
                  ),
                ),
                const SizedBox(width: 12),
                Text(
                  'Örnekler',
                  style: GoogleFonts.poppins(
                    color: PColors.text,
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),

            // Examples List
            ...examples.asMap().entries.map((entry) {
              final index = entry.key;
              final example = entry.value;
              return Padding(
                padding: EdgeInsets.only(bottom: index < examples.length - 1 ? 12 : 0),
                child: Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: PColors.surface.withValues(alpha: 0.5),
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(
                      color: PColors.border.withValues(alpha: 0.3),
                      width: 1,
                    ),
                  ),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        width: 24,
                        height: 24,
                        decoration: BoxDecoration(
                          color: PColors.success.withValues(alpha: 0.15),
                          shape: BoxShape.circle,
                        ),
                        child: Center(
                          child: Text(
                            '${index + 1}',
                            style: GoogleFonts.inter(
                              color: PColors.success,
                              fontSize: 12,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Text(
                          example,
                          style: GoogleFonts.sourceCodePro(
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
        ),
      ),
    );
  }

  Widget _buildActionButton(
    BuildContext context,
    ProjectSimulation project,
    ProjectModule module,
    LearningStage stage,
  ) {
    // Find next stage (should be Apply stage)
    final stageIndex = module.stages.indexOf(stage);
    final hasNextStage = stageIndex < module.stages.length - 1;

    return Column(
      children: [
        // Primary Action Button
        SizedBox(
          width: double.infinity,
          height: 56,
          child: ElevatedButton(
            onPressed: hasNextStage
                ? () {
                    final nextStage = module.stages[stageIndex + 1];
                    context.go('/skill-paths/${project.id}/stage/${nextStage.id}');
                  }
                : null,
            style: ElevatedButton.styleFrom(
              backgroundColor: PColors.primary,
              foregroundColor: PColors.background,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
              elevation: 0,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Anladım, Uygulayalım!',
                  style: GoogleFonts.poppins(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(width: 8),
                Icon(LucideIcons.arrowRight, size: 20),
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
                  'AI Koç\'a Sor',
                  style: GoogleFonts.poppins(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
