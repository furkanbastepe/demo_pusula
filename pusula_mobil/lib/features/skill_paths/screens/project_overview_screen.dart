import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:go_router/go_router.dart';

import '../../../core/theme/colors.dart';
import '../../../widgets/common/glass_morphic_card.dart';
import '../providers/projects_provider.dart';
import '../providers/progress_provider.dart';
import '../models/project_simulation.dart';
import '../models/project_module.dart';

/// Project Overview Screen
/// 
/// Displays Duolingo-style vertical module path with project context.
/// Shows modules as connected nodes with lock/progress/completed states.
class ProjectOverviewScreen extends HookConsumerWidget {
  final String projectId;

  const ProjectOverviewScreen({
    super.key,
    required this.projectId,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final projectAsync = ref.watch(projectProvider(projectId));
    final progressAsync = ref.watch(projectProgressProvider(projectId));

    // Auto-start project if not started
    useEffect(() {
      if (progressAsync.value == null) {
        Future.microtask(() {
          ref.read(progressNotifierProvider.notifier).startProject(projectId);
        });
      }
      return null;
    }, [progressAsync.value]);

    return Scaffold(
      backgroundColor: Colors.transparent,
      extendBodyBehindAppBar: true,
      body: SafeArea(
        child: projectAsync.when(
          data: (project) {
            if (project == null) {
              return Center(
                child: Text(
                  'Proje bulunamadı',
                  style: GoogleFonts.inter(color: PColors.textDim),
                ),
              );
            }

            return CustomScrollView(
              slivers: [
                // App Bar
                SliverAppBar(
                  backgroundColor: Colors.transparent,
                  elevation: 0,
                  floating: true,
                  snap: true,
                  leading: IconButton(
                    icon: Icon(LucideIcons.arrowLeft, color: PColors.text),
                    onPressed: () => context.go('/skill-paths'),
                  ),
                  actions: [
                    // AI Coach Button
                    IconButton(
                      icon: Icon(LucideIcons.bot, color: PColors.primary),
                      onPressed: () {
                        // TODO: Open AI Coach
                      },
                      tooltip: 'AI Koç',
                    ),
                  ],
                ),

                // Hero Section
                SliverToBoxAdapter(
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(20, 8, 20, 24),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Emoji + Title
                        Row(
                          children: [
                            Container(
                              width: 64,
                              height: 64,
                              decoration: BoxDecoration(
                                color: PColors.primary.withValues(alpha: 0.1),
                                borderRadius: BorderRadius.circular(20),
                              ),
                              child: Center(
                                child: Text(
                                  project.emoji,
                                  style: const TextStyle(fontSize: 36),
                                ),
                              ),
                            ),
                            const SizedBox(width: 16),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    project.title,
                                    style: GoogleFonts.poppins(
                                      fontSize: 24,
                                      fontWeight: FontWeight.bold,
                                      color: PColors.text,
                                    ),
                                  ),
                                  Text(
                                    project.skillPath,
                                    style: GoogleFonts.inter(
                                      fontSize: 14,
                                      color: PColors.primary,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ).animate().fadeIn().slideY(begin: -0.2),
                        const SizedBox(height: 20),

                        // Progress Summary
                        progressAsync.when(
                          data: (progress) => _ProgressSummary(
                            project: project,
                            progress: progress,
                          ),
                          loading: () => const SizedBox.shrink(),
                          error: (_, __) => const SizedBox.shrink(),
                        ),
                      ],
                    ),
                  ),
                ),

                // Project Context Card
                SliverToBoxAdapter(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: _ProjectContextCard(project: project),
                  ),
                ),

                const SliverToBoxAdapter(child: SizedBox(height: 24)),

                // Module Path Title
                SliverToBoxAdapter(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Text(
                      'Öğrenme Yolu',
                      style: GoogleFonts.poppins(
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                        color: PColors.text,
                      ),
                    ).animate().fadeIn(delay: 200.ms),
                  ),
                ),

                const SliverToBoxAdapter(child: SizedBox(height: 16)),

                // Module Path (Duolingo-style)
                SliverToBoxAdapter(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: progressAsync.when(
                      data: (progress) => _ModulePath(
                        project: project,
                        progress: progress,
                      ),
                      loading: () => const Center(
                        child: CircularProgressIndicator(color: PColors.primary),
                      ),
                      error: (_, __) => _ModulePath(
                        project: project,
                        progress: null,
                      ),
                    ),
                  ),
                ),

                const SliverToBoxAdapter(child: SizedBox(height: 32)),

                // Start/Continue Button
                SliverToBoxAdapter(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: progressAsync.when(
                      data: (progress) => _ActionButton(
                        project: project,
                        progress: progress,
                      ),
                      loading: () => const SizedBox.shrink(),
                      error: (_, __) => _ActionButton(
                        project: project,
                        progress: null,
                      ),
                    ),
                  ),
                ),

                const SliverToBoxAdapter(child: SizedBox(height: 32)),
              ],
            );
          },
          loading: () => const Center(
            child: CircularProgressIndicator(color: PColors.primary),
          ),
          error: (error, stack) => Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.error_outline, size: 48, color: PColors.warning),
                const SizedBox(height: 16),
                Text(
                  'Proje yüklenemedi',
                  style: GoogleFonts.inter(fontSize: 16, color: PColors.text),
                ),
                const SizedBox(height: 8),
                Text(
                  error.toString(),
                  style: GoogleFonts.inter(fontSize: 12, color: PColors.textDim),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

/// Progress Summary Widget
class _ProgressSummary extends StatelessWidget {
  final ProjectSimulation project;
  final dynamic progress;

  const _ProgressSummary({
    required this.project,
    required this.progress,
  });

  @override
  Widget build(BuildContext context) {
    if (progress == null) {
      return GlassMorphicCard(
        child: Row(
          children: [
            _StatItem(
              icon: LucideIcons.zap,
              label: 'Toplam XP',
              value: '${project.totalXP}',
              color: PColors.accent,
            ),
            const SizedBox(width: 24),
            _StatItem(
              icon: LucideIcons.clock,
              label: 'Tahmini Süre',
              value: '${project.estimatedHours}s',
              color: PColors.primary,
            ),
          ],
        ),
      ).animate(delay: 100.ms).fadeIn().slideY(begin: 0.2);
    }

    final progressPercent = progress.overallProgress;
    return GlassMorphicCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'İlerleme',
                style: GoogleFonts.inter(
                  fontSize: 14,
                  color: PColors.textDim,
                ),
              ),
              Text(
                '${progressPercent.toStringAsFixed(0)}%',
                style: GoogleFonts.poppins(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: PColors.primary,
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: LinearProgressIndicator(
              value: progressPercent / 100,
              backgroundColor: PColors.surface,
              valueColor: AlwaysStoppedAnimation(PColors.primary),
              minHeight: 8,
            ),
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              _StatItem(
                icon: LucideIcons.zap,
                label: 'Kazanılan XP',
                value: '${progress.earnedXP}/${project.totalXP}',
                color: PColors.accent,
              ),
              const SizedBox(width: 24),
              _StatItem(
                icon: Icons.check_circle,
                label: 'Tamamlanan',
                value: '${progress.totalStagesCompleted} aşama',
                color: PColors.success,
              ),
            ],
          ),
        ],
      ),
    ).animate(delay: 100.ms).fadeIn().slideY(begin: 0.2);
  }
}

/// Stat Item Widget
class _StatItem extends StatelessWidget {
  final IconData icon;
  final String label;
  final String value;
  final Color color;

  const _StatItem({
    required this.icon,
    required this.label,
    required this.value,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(icon, size: 18, color: color),
        const SizedBox(width: 8),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              label,
              style: GoogleFonts.inter(
                fontSize: 11,
                color: PColors.textDim,
              ),
            ),
            Text(
              value,
              style: GoogleFonts.inter(
                fontSize: 14,
                fontWeight: FontWeight.w600,
                color: PColors.text,
              ),
            ),
          ],
        ),
      ],
    );
  }
}

/// Project Context Card Widget
class _ProjectContextCard extends HookWidget {
  final ProjectSimulation project;

  const _ProjectContextCard({required this.project});

  @override
  Widget build(BuildContext context) {
    final isExpanded = useState(false);

    return GlassMorphicCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          InkWell(
            onTap: () => isExpanded.value = !isExpanded.value,
            child: Row(
              children: [
                Icon(
                  LucideIcons.briefcase,
                  size: 20,
                  color: PColors.primary,
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Text(
                    'Proje Hakkında',
                    style: GoogleFonts.poppins(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: PColors.text,
                    ),
                  ),
                ),
                Icon(
                  isExpanded.value
                      ? LucideIcons.chevronUp
                      : LucideIcons.chevronDown,
                  size: 20,
                  color: PColors.textDim,
                ),
              ],
            ),
          ),
          if (isExpanded.value) ...[
            const SizedBox(height: 16),
            _ContextItem(
              label: 'Şirket',
              value: project.context.companyName,
            ),
            const SizedBox(height: 12),
            _ContextItem(
              label: 'Senaryo',
              value: project.context.scenario,
            ),
            const SizedBox(height: 12),
            Text(
              'Çıktılar:',
              style: GoogleFonts.inter(
                fontSize: 12,
                fontWeight: FontWeight.w600,
                color: PColors.textDim,
              ),
            ),
            const SizedBox(height: 8),
            ...project.context.deliverables.map(
              (deliverable) => Padding(
                padding: const EdgeInsets.only(bottom: 6),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Icon(
                      Icons.check,
                      size: 16,
                      color: PColors.primary,
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      child: Text(
                        deliverable,
                        style: GoogleFonts.inter(
                          fontSize: 13,
                          color: PColors.text,
                          height: 1.4,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ],
      ),
    ).animate(delay: 150.ms).fadeIn().slideY(begin: 0.2);
  }
}

/// Context Item Widget
class _ContextItem extends StatelessWidget {
  final String label;
  final String value;

  const _ContextItem({
    required this.label,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: GoogleFonts.inter(
            fontSize: 12,
            fontWeight: FontWeight.w600,
            color: PColors.textDim,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          value,
          style: GoogleFonts.inter(
            fontSize: 13,
            color: PColors.text,
            height: 1.5,
          ),
        ),
      ],
    );
  }
}

/// Module Path Widget (Duolingo-style)
class _ModulePath extends StatelessWidget {
  final ProjectSimulation project;
  final dynamic progress;

  const _ModulePath({
    required this.project,
    required this.progress,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        for (int i = 0; i < project.modules.length; i++) ...[
          _ModuleNode(
            projectId: project.id,
            module: project.modules[i],
            index: i,
            isLocked: _isModuleLocked(i),
            isCompleted: _isModuleCompleted(i),
            progress: _getModuleProgress(i),
          ).animate(delay: (200 + i * 100).ms).fadeIn().slideX(
                begin: i.isEven ? -0.3 : 0.3,
              ),
          if (i < project.modules.length - 1)
            _PathConnector(
              isCompleted: _isModuleCompleted(i),
            ).animate(delay: (250 + i * 100).ms).fadeIn(),
        ],
      ],
    );
  }

  bool _isModuleLocked(int index) {
    if (progress == null) return index > 0;
    if (index == 0) return false;
    
    // Check if previous module is completed
    final previousModule = project.modules[index - 1];
    final previousProgress = progress.moduleProgress[previousModule.id];
    return previousProgress?.isCompleted != true;
  }

  bool _isModuleCompleted(int index) {
    if (progress == null) return false;
    final module = project.modules[index];
    final moduleProgress = progress.moduleProgress[module.id];
    return moduleProgress?.isCompleted == true;
  }

  double? _getModuleProgress(int index) {
    if (progress == null) return null;
    final module = project.modules[index];
    final moduleProgress = progress.moduleProgress[module.id];
    return moduleProgress?.progressPercentage;
  }
}

/// Module Node Widget
class _ModuleNode extends StatelessWidget {
  final String projectId;
  final ProjectModule module;
  final int index;
  final bool isLocked;
  final bool isCompleted;
  final double? progress;

  const _ModuleNode({
    required this.projectId,
    required this.module,
    required this.index,
    required this.isLocked,
    required this.isCompleted,
    this.progress,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: isLocked
          ? null
          : () {
              context.go('/skill-paths/$projectId/module/${module.id}');
            },
      child: GlassMorphicCard(
        child: Row(
          children: [
            // Module Icon/Status
            Container(
              width: 56,
              height: 56,
              decoration: BoxDecoration(
                color: _getStatusColor().withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(16),
                border: Border.all(
                  color: _getStatusColor().withValues(alpha: 0.3),
                  width: 2,
                ),
              ),
              child: Center(
                child: Icon(
                  _getStatusIcon(),
                  color: _getStatusColor(),
                  size: 28,
                ),
              ),
            ),
            const SizedBox(width: 16),

            // Module Info
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Modül ${index + 1}',
                    style: GoogleFonts.inter(
                      fontSize: 11,
                      color: PColors.textDim,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    module.title,
                    style: GoogleFonts.poppins(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: isLocked ? PColors.textDim : PColors.text,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    module.description,
                    style: GoogleFonts.inter(
                      fontSize: 12,
                      color: PColors.textDim,
                      height: 1.3,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      Icon(LucideIcons.zap, size: 14, color: PColors.accent),
                      const SizedBox(width: 4),
                      Text(
                        '${module.xpReward} XP',
                        style: GoogleFonts.inter(
                          fontSize: 12,
                          color: PColors.textDim,
                        ),
                      ),
                      const SizedBox(width: 12),
                      Icon(LucideIcons.clock, size: 14, color: PColors.textDim),
                      const SizedBox(width: 4),
                      Text(
                        '${module.estimatedMinutes}dk',
                        style: GoogleFonts.inter(
                          fontSize: 12,
                          color: PColors.textDim,
                        ),
                      ),
                    ],
                  ),
                  if (progress != null && progress! > 0 && !isCompleted) ...[
                    const SizedBox(height: 8),
                    ClipRRect(
                      borderRadius: BorderRadius.circular(4),
                      child: LinearProgressIndicator(
                        value: progress! / 100,
                        backgroundColor: PColors.surface,
                        valueColor: AlwaysStoppedAnimation(PColors.primary),
                        minHeight: 4,
                      ),
                    ),
                  ],
                ],
              ),
            ),

            // Arrow
            if (!isLocked)
              Icon(
                LucideIcons.chevronRight,
                color: PColors.textDim,
                size: 20,
              ),
          ],
        ),
      ),
    );
  }

  Color _getStatusColor() {
    if (isCompleted) return PColors.success;
    if (isLocked) return PColors.textDim;
    return PColors.primary;
  }

  IconData _getStatusIcon() {
    if (isCompleted) return Icons.check_circle;
    if (isLocked) return LucideIcons.lock;
    return Icons.play_circle;
  }
}

/// Path Connector Widget
class _PathConnector extends StatelessWidget {
  final bool isCompleted;

  const _PathConnector({required this.isCompleted});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 3,
      height: 32,
      margin: const EdgeInsets.only(left: 28),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: isCompleted
              ? [PColors.success, PColors.success.withValues(alpha: 0.3)]
              : [
                  PColors.textDim.withValues(alpha: 0.3),
                  PColors.textDim.withValues(alpha: 0.1)
                ],
        ),
      ),
    );
  }
}

/// Action Button Widget
class _ActionButton extends StatelessWidget {
  final ProjectSimulation project;
  final dynamic progress;

  const _ActionButton({
    required this.project,
    required this.progress,
  });

  @override
  Widget build(BuildContext context) {
    final buttonText = progress == null ? 'Başla' : 'Devam Et';

    return ElevatedButton(
      onPressed: () {
        // TODO: Navigate to first incomplete stage
      },
      style: ElevatedButton.styleFrom(
        backgroundColor: PColors.primary,
        foregroundColor: Colors.white,
        padding: const EdgeInsets.symmetric(vertical: 16),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        elevation: 0,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            buttonText,
            style: GoogleFonts.inter(
              fontSize: 16,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(width: 8),
          Icon(
            LucideIcons.arrowRight,
            size: 20,
          ),
        ],
      ),
    ).animate(delay: 300.ms).fadeIn().slideY(begin: 0.3);
  }
}
