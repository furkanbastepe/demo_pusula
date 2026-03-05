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

class ModuleDetailScreen extends HookConsumerWidget {
  final String projectId;
  final String moduleId;

  const ModuleDetailScreen({
    super.key,
    required this.projectId,
    required this.moduleId,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final projectAsync = ref.watch(projectProvider(projectId));
    final progressAsync = ref.watch(projectProgressProvider(projectId));

    return Scaffold(
      backgroundColor: Colors.transparent,
      extendBodyBehindAppBar: true,
      body: projectAsync.when(
        data: (project) {
          if (project == null) {
            return Center(
              child: Text('Proje bulunamadı', style: TextStyle(color: PColors.textDim)),
            );
          }
          
          final module = project.modules.firstWhere((m) => m.id == moduleId);
          
          return progressAsync.when(
            data: (progress) => _buildContent(context, ref, project, module, progress),
            loading: () => const Center(child: CircularProgressIndicator()),
            error: (error, stack) => Center(
              child: Text('Hata: $error', style: TextStyle(color: PColors.textDim)),
            ),
          );
        },
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, stack) => Center(
          child: Text('Hata: $error', style: TextStyle(color: PColors.textDim)),
        ),
      ),
    );
  }

  Widget _buildContent(
    BuildContext context,
    WidgetRef ref,
    ProjectSimulation project,
    ProjectModule module,
    ProjectProgress? progress,
  ) {
    final moduleProgress = progress?.moduleProgress[module.id];
    final completedStages = moduleProgress?.stageProgress.values
            .where((s) => s.status == StageStatus.completed)
            .length ??
        0;
    final totalStages = module.stages.length;
    final progressPercent = totalStages > 0 ? completedStages / totalStages : 0.0;

    return CustomScrollView(
      slivers: [
        // App Bar with AI Koç button
        SliverAppBar(
          floating: true,
          backgroundColor: PColors.background.withValues(alpha: 0.9),
          leading: IconButton(
            icon: Icon(LucideIcons.chevronLeft, color: PColors.text),
            onPressed: () => context.go('/skill-paths/$projectId'),
          ),
          title: Text(
            'Modül ${module.order}',
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
                // TODO: Open AI Coach with module context
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
                // Module Header
                _buildModuleHeader(module, completedStages, totalStages, progressPercent)
                    .animate()
                    .fadeIn(duration: 300.ms)
                    .slideY(begin: 0.2, duration: 300.ms),

                const SizedBox(height: 24),

                // Stage List
                _buildStageList(context, ref, project, module, progress),
              ],
            ),
          ),
        ),

        // Bottom padding
        const SliverToBoxAdapter(
          child: SizedBox(height: 100),
        ),
      ],
    );
  }

  Widget _buildModuleHeader(
    ProjectModule module,
    int completedStages,
    int totalStages,
    double progressPercent,
  ) {
    return GlassMorphicCard(
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Module Title
            Text(
              module.title,
              style: GoogleFonts.poppins(
                color: PColors.text,
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),

            // Module Description
            Text(
              module.description,
              style: GoogleFonts.inter(
                color: PColors.textDim,
                fontSize: 14,
                height: 1.5,
              ),
            ),
            const SizedBox(height: 16),

            // Progress Bar
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      '$completedStages/$totalStages aşama tamamlandı',
                      style: GoogleFonts.inter(
                        color: PColors.textDim,
                        fontSize: 12,
                      ),
                    ),
                    Text(
                      '${(progressPercent * 100).toInt()}%',
                      style: GoogleFonts.poppins(
                        color: PColors.primary,
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: LinearProgressIndicator(
                    value: progressPercent,
                    backgroundColor: PColors.surface,
                    valueColor: AlwaysStoppedAnimation<Color>(PColors.primary),
                    minHeight: 8,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),

            // Module Stats
            Row(
              children: [
                _buildStatChip(
                  icon: LucideIcons.zap,
                  label: '${module.xpReward} XP',
                  color: PColors.accent,
                ),
                const SizedBox(width: 12),
                _buildStatChip(
                  icon: LucideIcons.clock,
                  label: '${module.estimatedMinutes} dk',
                  color: PColors.info,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStatChip({
    required IconData icon,
    required String label,
    required Color color,
  }) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.15),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: color.withValues(alpha: 0.3),
          width: 1,
        ),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 14, color: color),
          const SizedBox(width: 6),
          Text(
            label,
            style: GoogleFonts.inter(
              color: color,
              fontSize: 12,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStageList(
    BuildContext context,
    WidgetRef ref,
    ProjectSimulation project,
    ProjectModule module,
    ProjectProgress? progress,
  ) {
    final moduleProgress = progress?.moduleProgress[module.id];
    
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Aşamalar',
          style: GoogleFonts.poppins(
            color: PColors.text,
            fontSize: 18,
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(height: 16),

        // Build stage pairs (Learn + Apply)
        ...List.generate(
          (module.stages.length / 2).ceil(),
          (pairIndex) {
            final learnIndex = pairIndex * 2;
            final applyIndex = learnIndex + 1;
            
            final learnStage = module.stages[learnIndex];
            final applyStage = applyIndex < module.stages.length
                ? module.stages[applyIndex]
                : null;

            return _buildStagePair(
              context,
              ref,
              project,
              module,
              learnStage,
              applyStage,
              moduleProgress,
              pairIndex,
            ).animate(delay: (pairIndex * 100).ms)
                .fadeIn(duration: 300.ms)
                .slideX(begin: 0.2, duration: 300.ms);
          },
        ),
      ],
    );
  }

  Widget _buildStagePair(
    BuildContext context,
    WidgetRef ref,
    ProjectSimulation project,
    ProjectModule module,
    LearningStage learnStage,
    LearningStage? applyStage,
    ModuleProgress? moduleProgress,
    int pairIndex,
  ) {
    return Column(
      children: [
        // Learn Stage
        _buildStageNode(
          context,
          ref,
          project,
          module,
          learnStage,
          moduleProgress,
          isLeft: pairIndex % 2 == 0,
        ),

        // Connector
        if (applyStage != null) _buildConnector(),

        // Apply Stage
        if (applyStage != null)
          _buildStageNode(
            context,
            ref,
            project,
            module,
            applyStage,
            moduleProgress,
            isLeft: pairIndex % 2 == 0,
          ),

        // Connector to next pair
        if (applyStage != null && pairIndex < (module.stages.length / 2).ceil() - 1)
          _buildConnector(),
      ],
    );
  }

  Widget _buildStageNode(
    BuildContext context,
    WidgetRef ref,
    ProjectSimulation project,
    ProjectModule module,
    LearningStage stage,
    ModuleProgress? moduleProgress,
    {required bool isLeft}
  ) {
    final stageProgress = moduleProgress?.stageProgress[stage.id];
    
    // Determine stage status
    StageStatus status;
    if (stageProgress != null) {
      status = stageProgress.status;
    } else {
      // If no progress, first stage is unlocked, others are locked
      final stageIndex = module.stages.indexWhere((s) => s.id == stage.id);
      status = stageIndex == 0 ? StageStatus.unlocked : StageStatus.locked;
    }
    
    final isCurrentStage = status == StageStatus.inProgress;
    
    // Determine if stage is unlocked
    final isUnlocked = status == StageStatus.unlocked || 
                       status == StageStatus.inProgress ||
                       status == StageStatus.completed;

    final color = _getStageColor(status);
    final icon = _getStageIcon(stage.type, status);

    return GestureDetector(
      onTap: isUnlocked
          ? () {
              context.go('/skill-paths/${project.id}/stage/${stage.id}');
            }
          : null,
      child: Container(
        margin: EdgeInsets.only(
          left: isLeft ? 0 : 40,
          right: isLeft ? 40 : 0,
        ),
        child: GlassMorphicCard(
          child: Container(
            decoration: isCurrentStage
                ? BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(
                      color: PColors.primary.withValues(alpha: 0.5),
                      width: 2,
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: PColors.primary.withValues(alpha: 0.3),
                        blurRadius: 12,
                        spreadRadius: 2,
                      ),
                    ],
                  )
                : null,
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Row(
                children: [
                  // Stage Icon
                  Container(
                    width: 48,
                    height: 48,
                    decoration: BoxDecoration(
                      color: color.withValues(alpha: 0.15),
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(
                        color: color.withValues(alpha: 0.3),
                        width: 1,
                      ),
                    ),
                    child: Icon(
                      icon,
                      color: color,
                      size: 24,
                    ),
                  ),
                  const SizedBox(width: 12),

                  // Stage Info
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Stage Type Badge
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 8,
                            vertical: 4,
                          ),
                          decoration: BoxDecoration(
                            color: color.withValues(alpha: 0.15),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Text(
                            stage.type == StageType.learn ? 'Öğren' : 'Uygula',
                            style: GoogleFonts.inter(
                              color: color,
                              fontSize: 10,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                        const SizedBox(height: 6),

                        // Stage Title
                        Text(
                          stage.title,
                          style: GoogleFonts.poppins(
                            color: isUnlocked ? PColors.text : PColors.textDim,
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        const SizedBox(height: 4),

                        // Stage Stats
                        Row(
                          children: [
                            Icon(
                              LucideIcons.zap,
                              size: 12,
                              color: PColors.accent.withValues(alpha: 0.7),
                            ),
                            const SizedBox(width: 4),
                            Text(
                              '${stage.xpReward} XP',
                              style: GoogleFonts.inter(
                                color: PColors.textDim,
                                fontSize: 11,
                              ),
                            ),
                            const SizedBox(width: 12),
                            Icon(
                              LucideIcons.clock,
                              size: 12,
                              color: PColors.info.withValues(alpha: 0.7),
                            ),
                            const SizedBox(width: 4),
                            Text(
                              '${stage.estimatedMinutes} dk',
                              style: GoogleFonts.inter(
                                color: PColors.textDim,
                                fontSize: 11,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),

                  // Status Icon
                  if (status == StageStatus.completed)
                    Container(
                      width: 32,
                      height: 32,
                      decoration: BoxDecoration(
                        color: PColors.success.withValues(alpha: 0.15),
                        shape: BoxShape.circle,
                      ),
                      child: Icon(
                        LucideIcons.check,
                        color: PColors.success,
                        size: 18,
                      ),
                    )
                  else if (status == StageStatus.locked)
                    Container(
                      width: 32,
                      height: 32,
                      decoration: BoxDecoration(
                        color: PColors.textDim.withValues(alpha: 0.15),
                        shape: BoxShape.circle,
                      ),
                      child: Icon(
                        LucideIcons.lock,
                        color: PColors.textDim,
                        size: 18,
                      ),
                    ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildConnector() {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8),
      width: 2,
      height: 24,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            PColors.primary.withValues(alpha: 0.5),
            PColors.primary.withValues(alpha: 0.2),
          ],
        ),
      ),
    );
  }

  Color _getStageColor(StageStatus status) {
    switch (status) {
      case StageStatus.completed:
        return PColors.success;
      case StageStatus.inProgress:
      case StageStatus.unlocked:
        return PColors.primary;
      case StageStatus.locked:
        return PColors.textDim;
    }
  }

  IconData _getStageIcon(StageType type, StageStatus status) {
    if (status == StageStatus.completed) {
      return LucideIcons.check;
    } else if (status == StageStatus.locked) {
      return LucideIcons.lock;
    }

    switch (type) {
      case StageType.learn:
        return LucideIcons.bookOpen;
      case StageType.apply:
        return LucideIcons.code;
    }
  }
}
