import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../core/theme/colors.dart';
import '../../../core/utils/navigation_utils.dart';
import '../../../widgets/common/glass_morphic_card.dart';
import '../../../screens/home/main_layout.dart';
import '../providers/projects_provider.dart';
import '../providers/progress_provider.dart';
import '../models/project_simulation.dart';

class SkillPathSelectionScreen extends HookConsumerWidget {
  const SkillPathSelectionScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final projectsAsync = ref.watch(projectsProvider);

    return MainLayout(
      child: CustomScrollView(
        slivers: [
          // AppBar with AI Assistant
          _buildAppBar(context),

          // Spacing
          const SliverToBoxAdapter(child: SizedBox(height: 20)),

          // Projects Grid
          projectsAsync.when(
            data: (projects) {
              if (projects.isEmpty) {
                return const SliverFillRemaining(
                  child: Center(child: Text('Henüz proje yok')),
                );
              }

              return SliverPadding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                sliver: SliverGrid(
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    childAspectRatio: 0.7,
                    crossAxisSpacing: 12,
                    mainAxisSpacing: 12,
                  ),
                  delegate: SliverChildBuilderDelegate((context, index) {
                    return RepaintBoundary(
                      child: _ProjectCard(
                        project: projects[index],
                        index: index,
                      ),
                    );
                  }, childCount: projects.length),
                ),
              );
            },
            loading: () => const SliverFillRemaining(
              child: Center(
                child: CircularProgressIndicator(color: PColors.primary),
              ),
            ),
            error: (error, stack) {
              print('Error loading projects: $error');
              return SliverFillRemaining(
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(Icons.error, size: 48, color: PColors.warning),
                      const SizedBox(height: 16),
                      Text(
                        'Projeler yüklenemedi',
                        style: GoogleFonts.inter(color: PColors.text),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        error.toString(),
                        style: GoogleFonts.inter(
                          fontSize: 12,
                          color: PColors.textDim,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                ),
              );
            },
          ),

          // Bottom spacing
          const SliverToBoxAdapter(child: SizedBox(height: 100)),
        ],
      ),
    );
  }

  Widget _buildAppBar(BuildContext context) {
    return SliverAppBar(
      floating: true,
      snap: true,
      backgroundColor: Colors.transparent,
      elevation: 0,
      title: Text(
        'Simülasyon Projeleri',
        style: GoogleFonts.poppins(
          color: PColors.text,
          fontSize: 24,
          fontWeight: FontWeight.w700,
        ),
      ),
      actions: [
        IconButton(
          icon: const Icon(
            LucideIcons.bot,
            color: PColors.primary,
          ),
          onPressed: () => openAIChat(context),
          tooltip: 'AI Asistan',
        ),
        const SizedBox(width: 8),
      ],
    );
  }

}

class _ProjectCard extends HookConsumerWidget {
  final ProjectSimulation project;
  final int index;

  const _ProjectCard({required this.project, required this.index});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isHovered = useState(false);

    return GestureDetector(
      onTap: () async {
        try {
          final progressNotifier = ref.read(progressNotifierProvider.notifier);
          await progressNotifier.startProject(project.id);

          if (context.mounted) {
            context.go('/skill-paths/${project.id}');
          }
        } catch (e) {
          print('Error starting project: $e');
        }
      },
      child: MouseRegion(
        onEnter: (_) => isHovered.value = true,
        onExit: (_) => isHovered.value = false,
        child: GlassMorphicCard(
          child: Padding(
            padding: const EdgeInsets.all(12),
            child: LayoutBuilder(
              builder: (context, constraints) {
                return Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Emoji
                    Container(
                      width: 48,
                      height: 48,
                      decoration: BoxDecoration(
                        color: PColors.primary.withValues(alpha: 0.1),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Center(
                        child: Text(
                          project.emoji,
                          style: const TextStyle(fontSize: 28),
                        ),
                      ),
                    ),
                    const SizedBox(height: 8),

                    // Title
                    SizedBox(
                      height: 52,
                      child: Text(
                        project.title,
                        style: GoogleFonts.poppins(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          color: PColors.text,
                          height: 1.35,
                        ),
                        maxLines: 3,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    const SizedBox(height: 6),

                    // Skill Path
                    Text(
                      project.skillPath,
                      style: GoogleFonts.inter(
                        fontSize: 11,
                        color: PColors.primary,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const Spacer(),

                    // Stats
                    Row(
                      children: [
                        const Icon(
                          LucideIcons.zap,
                          size: 12,
                          color: PColors.accent,
                        ),
                        const SizedBox(width: 3),
                        Flexible(
                          child: Text(
                            '${project.totalXP} XP',
                            style: GoogleFonts.inter(
                              fontSize: 11,
                              color: PColors.textDim,
                            ),
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        const SizedBox(width: 8),
                        const Icon(
                          LucideIcons.clock,
                          size: 12,
                          color: PColors.textDim,
                        ),
                        const SizedBox(width: 3),
                        Flexible(
                          child: Text(
                            '${project.estimatedHours}s',
                            style: GoogleFonts.inter(
                              fontSize: 11,
                              color: PColors.textDim,
                            ),
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),

                    // Start Button
                    Container(
                      height: 28,
                      decoration: BoxDecoration(
                        color: isHovered.value
                            ? PColors.primary
                            : PColors.primary.withValues(alpha: 0.1),
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(
                          color: PColors.primary.withValues(alpha: 0.3),
                        ),
                      ),
                      child: Center(
                        child: Text(
                          'Başla',
                          style: GoogleFonts.inter(
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                            color: isHovered.value
                                ? Colors.white
                                : PColors.primary,
                          ),
                        ),
                      ),
                    ),
                  ],
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
