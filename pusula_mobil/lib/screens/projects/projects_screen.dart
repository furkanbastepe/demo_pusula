import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import '../../core/core.dart';
import '../../data/data.dart';
import '../../providers/providers.dart';
import '../../services/services.dart';
import '../../widgets/common/common.dart';
import '../home/main_layout.dart';
import 'task_detail_sheet.dart';

class ProjectsScreen extends ConsumerWidget {
  const ProjectsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final user = ref.watch(userProvider) ?? MockData.currentUser;
    final allTasks = MockData.tasks;

    return MainLayout(
      child: CustomScrollView(
        slivers: [
          SliverAppBar(
            title: Text(
              'Projeler',
              style: GoogleFonts.poppins(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: PColors.text,
              ),
            ),
            backgroundColor: Colors.transparent,
            floating: true,
            pinned: true,
            flexibleSpace: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    PColors.background.withValues(alpha: 0.9),
                    PColors.background.withValues(alpha: 0.7),
                  ],
                ),
              ),
            ),
            actions: [
              Container(
                margin: const EdgeInsets.only(right: 16),
                decoration: BoxDecoration(
                  color: PColors.primary.withValues(alpha: 0.15),
                  borderRadius: BorderRadius.circular(25),
                ),
                child: IconButton(
                  icon: const Icon(LucideIcons.funnel, color: PColors.primary),
                  onPressed: () => _showFilterDialog(context),
                ),
              ),
            ],
          ),

          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Stats cards
                  _buildStatsCards(
                    user,
                    allTasks,
                  ).animate().fadeIn().slideY(begin: -0.2),

                  const SizedBox(height: 24),

                  // Filter tabs
                  _buildFilterTabs()
                      .animate(delay: 100.ms)
                      .fadeIn()
                      .slideY(begin: 0.2),
                ],
              ),
            ),
          ),

          SliverPadding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            sliver: SliverList(
              delegate: SliverChildBuilderDelegate((context, index) {
                final task = allTasks[index];
                final matchScore = PusulaMatchingEngine.calculateTaskMatch(
                  user,
                  task,
                );

                return Container(
                  margin: const EdgeInsets.only(bottom: 16),
                  child: _buildProjectCard(context, task, matchScore, user)
                      .animate(delay: (200 + index * 50).ms)
                      .fadeIn()
                      .slideX(begin: 0.3),
                );
              }, childCount: allTasks.length),
            ),
          ),

          const SliverToBoxAdapter(child: SizedBox(height: 100)),
        ],
      ),
    );
  }

  Widget _buildStatsCards(AppUser user, List<Task> tasks) {
    final availableTasks = tasks.where((task) => task.isAvailable).length;
    final myLevelTasks = tasks
        .where(
          (task) =>
              task.requiredLevel.index <= user.level.index && task.isAvailable,
        )
        .length;
    final urgentTasks = tasks
        .where((task) => task.isUrgent && task.isAvailable)
        .length;

    return Row(
      children: [
        Expanded(
          child: _buildStatCard(
            'Mevcut Projeler',
            '$availableTasks',
            LucideIcons.briefcase,
            PColors.primary,
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: _buildStatCard(
            'Seviyeme Uygun',
            '$myLevelTasks',
            LucideIcons.target,
            PColors.success,
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: _buildStatCard(
            'Acil Projeler',
            '$urgentTasks',
            LucideIcons.zap,
            PColors.warning,
          ),
        ),
      ],
    );
  }

  Widget _buildStatCard(
    String title,
    String value,
    IconData icon,
    Color color,
  ) {
    return GlassMorphicCard(
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: color.withValues(alpha: 0.15),
              borderRadius: BorderRadius.circular(15),
            ),
            child: Icon(icon, color: color, size: 20),
          ),
          const SizedBox(height: 8),
          Text(
            value,
            style: GoogleFonts.poppins(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: color,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            title,
            style: GoogleFonts.inter(fontSize: 11, color: PColors.textDim),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  Widget _buildFilterTabs() {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: [
          _buildFilterTab('Tümü', true),
          const SizedBox(width: 8),
          _buildFilterTab('Belediye', false),
          const SizedBox(width: 8),
          _buildFilterTab('KOBİ', false),
          const SizedBox(width: 8),
          _buildFilterTab('Gönüllülük', false),
          const SizedBox(width: 8),
          _buildFilterTab('Acil', false),
        ],
      ),
    );
  }

  Widget _buildFilterTab(String label, bool isSelected) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        color: isSelected ? PColors.primary : PColors.surfaceHi,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: isSelected ? PColors.primary : PColors.border,
        ),
      ),
      child: Text(
        label,
        style: GoogleFonts.inter(
          fontSize: 12,
          color: isSelected ? Colors.white : PColors.textDim,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }

  Widget _buildProjectCard(
    BuildContext context,
    Task task,
    double matchScore,
    AppUser user,
  ) {
    final canApply = user.level.index >= task.requiredLevel.index;

    return GlassMorphicCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: SizedBox(
                  width: 80,
                  height: 80,
                  child: ProjectImage(
                    imageUrl: task.imageUrl,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 8,
                            vertical: 4,
                          ),
                          decoration: BoxDecoration(
                            color: task.typeColor.withValues(alpha: 0.15),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Text(
                            task.typeDescription,
                            style: GoogleFonts.inter(
                              fontSize: 10,
                              color: task.typeColor,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                        if (task.isUrgent) ...[
                          const SizedBox(width: 8),
                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 8,
                              vertical: 4,
                            ),
                            decoration: BoxDecoration(
                              color: PColors.warning.withValues(alpha: 0.15),
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Text(
                              'ACİL',
                              style: GoogleFonts.inter(
                                fontSize: 10,
                                color: PColors.warning,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        ],
                        if (matchScore > 70) ...[
                          const SizedBox(width: 8),
                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 8,
                              vertical: 4,
                            ),
                            decoration: BoxDecoration(
                              color: PColors.success.withValues(alpha: 0.15),
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                const Icon(
                                  LucideIcons.heart,
                                  size: 10,
                                  color: PColors.success,
                                ),
                                const SizedBox(width: 2),
                                Text(
                                  '${matchScore.toInt()}%',
                                  style: GoogleFonts.inter(
                                    fontSize: 10,
                                    color: PColors.success,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ],
                    ),
                    const SizedBox(height: 8),
                    Text(
                      task.title,
                      style: GoogleFonts.poppins(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: PColors.text,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 4),
                    Text(
                      task.organization,
                      style: GoogleFonts.inter(
                        fontSize: 12,
                        color: PColors.textDim,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),

          const SizedBox(height: 16),

          Text(
            task.description,
            style: GoogleFonts.inter(
              fontSize: 13,
              color: PColors.textDim,
              height: 1.4,
            ),
            maxLines: 3,
            overflow: TextOverflow.ellipsis,
          ),

          const SizedBox(height: 16),

          // Required skills
          if (task.requiredSkills.isNotEmpty) ...[
            Text(
              'Aranan Beceriler:',
              style: GoogleFonts.poppins(
                fontSize: 12,
                fontWeight: FontWeight.w600,
                color: PColors.text,
              ),
            ),
            const SizedBox(height: 8),
            Wrap(
              spacing: 6,
              runSpacing: 6,
              children: task.requiredSkills
                  .map(
                    (skill) => Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 8,
                        vertical: 4,
                      ),
                      decoration: BoxDecoration(
                        color: task.typeColor.withValues(alpha: 0.1),
                        borderRadius: BorderRadius.circular(15),
                        border: Border.all(
                          color: task.typeColor.withValues(alpha: 0.3),
                        ),
                      ),
                      child: Text(
                        skill,
                        style: GoogleFonts.inter(
                          fontSize: 10,
                          color: task.typeColor,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  )
                  .toList(),
            ),
            const SizedBox(height: 16),
          ],

          Row(
            children: [
              Row(
                children: [
                  Icon(LucideIcons.users, size: 14, color: PColors.info),
                  const SizedBox(width: 4),
                  Text(
                    '${task.currentParticipants}/${task.maxParticipants}',
                    style: GoogleFonts.inter(fontSize: 12, color: PColors.info),
                  ),
                ],
              ),
              const SizedBox(width: 16),
              Row(
                children: [
                  Icon(LucideIcons.star, size: 14, color: PColors.accent),
                  const SizedBox(width: 4),
                  Text(
                    '+${task.xpReward} XP',
                    style: GoogleFonts.inter(
                      fontSize: 12,
                      color: PColors.accent,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
              const SizedBox(width: 16),
              Row(
                children: [
                  Icon(LucideIcons.mapPin, size: 14, color: PColors.textDim),
                  const SizedBox(width: 4),
                  Text(
                    PusulaCore.digemCities[task.city] ?? task.city,
                    style: GoogleFonts.inter(
                      fontSize: 12,
                      color: PColors.textDim,
                    ),
                  ),
                ],
              ),
              const Spacer(),
              ElevatedButton(
                onPressed: task.isAvailable && canApply
                    ? () {
                        showModalBottomSheet(
                          context: context,
                          backgroundColor: Colors.transparent,
                          isScrollControlled: true,
                          builder: (context) => TaskDetailSheet(
                            task: task,
                            matchScore: matchScore,
                          ),
                        );
                      }
                    : null,
                style: ElevatedButton.styleFrom(
                  backgroundColor: task.isAvailable && canApply
                      ? task.typeColor
                      : PColors.border,
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 8,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
                child: Text(
                  !canApply
                      ? 'Seviye Yok'
                      : task.isAvailable
                      ? 'İncele'
                      : 'Dolu',
                  style: GoogleFonts.inter(
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  void _showFilterDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => Dialog(
        backgroundColor: Colors.transparent,
        child: GlassMorphicCard(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                'Filtrele & Sırala 🔍',
                style: GoogleFonts.poppins(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: PColors.text,
                ),
              ),
              const SizedBox(height: 20),
              Text(
                'Filtreleme özelliği yakında aktif olacak!\nŞimdilik tüm projeleri görebilirsin.',
                style: GoogleFonts.inter(fontSize: 14, color: PColors.textDim),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () => Navigator.pop(context),
                child: const Text('Tamam'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
