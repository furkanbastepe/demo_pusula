import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import '../../../core/core.dart';
import '../../../widgets/common/common.dart';
import '../models/models.dart';
import '../providers/providers.dart';

// ═══════════════════════════════════════════════════════════════════════════════════
// 🎯 WORKSHOP SCREEN - Problem-Based Learning
// ═══════════════════════════════════════════════════════════════════════════════════

class WorkshopScreen extends ConsumerWidget {
  final String workshopId;

  const WorkshopScreen({
    super.key,
    required this.workshopId,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final workshopAsync = ref.watch(workshopProvider(workshopId));

    return Scaffold(
      backgroundColor: PColors.background,
      body: workshopAsync.when(
        data: (workshop) {
          if (workshop == null) {
            return _buildNotFound(context);
          }
          return _buildWorkshopContent(context, ref, workshop);
        },
        loading: () => const Center(
          child: CircularProgressIndicator(color: PColors.primary),
        ),
        error: (error, stack) => _buildError(context, error.toString()),
      ),
    );
  }

  Widget _buildWorkshopContent(
    BuildContext context,
    WidgetRef ref,
    SolutionWorkshop workshop,
  ) {
    return CustomScrollView(
      slivers: [
        // AppBar
        SliverAppBar(
          floating: true,
          snap: true,
          backgroundColor: PColors.surface,
          title: Text(
            workshop.name,
            style: GoogleFonts.poppins(
              color: PColors.text,
              fontSize: 18,
              fontWeight: FontWeight.w600,
            ),
          ),
          actions: [
            Container(
              margin: const EdgeInsets.only(right: 8),
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
              decoration: BoxDecoration(
                color: workshop.status.color.withValues(alpha: 0.15),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Text(
                workshop.status.displayName,
                style: GoogleFonts.inter(
                  fontSize: 12,
                  color: workshop.status.color,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ],
        ),

        // Content
        SliverPadding(
          padding: const EdgeInsets.all(16),
          sliver: SliverList(
            delegate: SliverChildListDelegate([
              // Days counter
              if (workshop.daysActive != null)
                _buildDaysCounter(workshop.daysActive!),

              const SizedBox(height: 24),

              // Team members
              _buildTeamMembers(workshop),

              const SizedBox(height: 24),

              // Facilitator
              if (workshop.facilitatorId != null) _buildFacilitator(),

              const SizedBox(height: 24),

              // Progress
              _buildProgress(workshop),

              const SizedBox(height: 24),

              // Milestones
              _buildMilestones(workshop),

              const SizedBox(height: 24),

              // Deliverables
              _buildDeliverables(workshop),

              const SizedBox(height: 24),

              // Action buttons
              _buildActionButtons(context, workshop),

              const SizedBox(height: 100),
            ]),
          ),
        ),
      ],
    );
  }

  Widget _buildDaysCounter(int days) {
    return GlassMorphicCard(
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: PColors.info.withValues(alpha: 0.15),
              borderRadius: BorderRadius.circular(12),
            ),
            child: const Icon(
              LucideIcons.calendar,
              color: PColors.info,
              size: 24,
            ),
          ),
          const SizedBox(width: 16),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Gün $days',
                style: GoogleFonts.poppins(
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                  color: PColors.text,
                ),
              ),
              Text(
                'Atölye süresi',
                style: GoogleFonts.inter(
                  fontSize: 12,
                  color: PColors.textDim,
                ),
              ),
            ],
          ),
        ],
      ),
    ).animate().fadeIn().slideY(begin: -0.2);
  }

  Widget _buildTeamMembers(SolutionWorkshop workshop) {
    return GlassMorphicCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Takım Üyeleri (${workshop.currentParticipants})',
            style: GoogleFonts.poppins(
              fontSize: 16,
              fontWeight: FontWeight.w600,
              color: PColors.text,
            ),
          ),
          const SizedBox(height: 16),
          ...workshop.participantIds.asMap().entries.map((entry) {
            final index = entry.key;
            final userId = entry.value;
            return _buildMemberCard(userId, index == 0);
          }),
        ],
      ),
    ).animate().fadeIn(delay: 100.ms).slideY(begin: 0.2);
  }

  Widget _buildMemberCard(String userId, bool isLeader) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: PColors.surface.withValues(alpha: 0.5),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: PColors.border),
      ),
      child: Row(
        children: [
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [PColors.primary, PColors.primary.withValues(alpha: 0.7)],
              ),
              borderRadius: BorderRadius.circular(20),
            ),
            child: Center(
              child: Text(
                'U',
                style: GoogleFonts.poppins(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Text(
                      'Kullanıcı $userId',
                      style: GoogleFonts.poppins(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: PColors.text,
                      ),
                    ),
                    if (isLeader) ...[
                      const SizedBox(width: 8),
                      const Icon(
                        LucideIcons.crown,
                        size: 14,
                        color: PColors.warning,
                      ),
                    ],
                  ],
                ),
                Text(
                  isLeader ? 'Takım Lideri' : 'Takım Üyesi',
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
    );
  }

  Widget _buildFacilitator() {
    return GlassMorphicCard(
      child: Row(
        children: [
          Container(
            width: 50,
            height: 50,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [PColors.accent, PColors.accent.withValues(alpha: 0.7)],
              ),
              borderRadius: BorderRadius.circular(25),
            ),
            child: Center(
              child: Text(
                'F',
                style: GoogleFonts.poppins(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Kolaylaştırıcı',
                  style: GoogleFonts.inter(
                    fontSize: 12,
                    color: PColors.textDim,
                  ),
                ),
                Text(
                  'Deneyimli Mentor',
                  style: GoogleFonts.poppins(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: PColors.text,
                  ),
                ),
              ],
            ),
          ),
          GlassButton(
            label: 'İletişim',
            onPressed: () {},
          ),
        ],
      ),
    ).animate().fadeIn(delay: 150.ms).slideY(begin: 0.2);
  }

  Widget _buildProgress(SolutionWorkshop workshop) {
    return GlassMorphicCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'İlerleme',
                style: GoogleFonts.poppins(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: PColors.text,
                ),
              ),
              Text(
                '${workshop.progressPercentage.toInt()}%',
                style: GoogleFonts.poppins(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: PColors.success,
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: LinearProgressIndicator(
              value: workshop.progressPercentage / 100,
              backgroundColor: PColors.border,
              valueColor: const AlwaysStoppedAnimation<Color>(PColors.success),
              minHeight: 8,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            '${workshop.completedMilestones}/${workshop.milestones.length} kilometre taşı tamamlandı',
            style: GoogleFonts.inter(
              fontSize: 12,
              color: PColors.textDim,
            ),
          ),
        ],
      ),
    ).animate().fadeIn(delay: 200.ms).slideY(begin: 0.2);
  }

  Widget _buildMilestones(SolutionWorkshop workshop) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Kilometre Taşları',
          style: GoogleFonts.poppins(
            fontSize: 16,
            fontWeight: FontWeight.w600,
            color: PColors.text,
          ),
        ),
        const SizedBox(height: 16),
        ...workshop.milestones.map((milestone) => _buildMilestoneCard(milestone)),
      ],
    );
  }

  Widget _buildMilestoneCard(WorkshopMilestone milestone) {
    final icon = milestone.isCompleted
        ? LucideIcons.check
        : LucideIcons.circle;
    final color = milestone.isCompleted ? PColors.success : PColors.textDim;

    return GlassMorphicCard(
      margin: const EdgeInsets.only(bottom: 12),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, color: color, size: 24),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '${milestone.order}. ${milestone.title}',
                  style: GoogleFonts.poppins(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: PColors.text,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  milestone.description,
                  style: GoogleFonts.inter(
                    fontSize: 12,
                    color: PColors.textDim,
                  ),
                ),
                if (milestone.facilitatorFeedback != null) ...[
                  const SizedBox(height: 8),
                  Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: PColors.info.withValues(alpha: 0.1),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Text(
                      milestone.facilitatorFeedback!,
                      style: GoogleFonts.inter(
                        fontSize: 12,
                        color: PColors.info,
                        fontStyle: FontStyle.italic,
                      ),
                    ),
                  ),
                ],
              ],
            ),
          ),
        ],
      ),
    ).animate().fadeIn(delay: (250 + milestone.order * 50).ms);
  }

  Widget _buildDeliverables(SolutionWorkshop workshop) {
    final deliverables = workshop.teams.expand((t) => t.deliverables).toList();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Çıktılar (${deliverables.length})',
          style: GoogleFonts.poppins(
            fontSize: 16,
            fontWeight: FontWeight.w600,
            color: PColors.text,
          ),
        ),
        const SizedBox(height: 16),
        if (deliverables.isEmpty)
          GlassMorphicCard(
            child: Center(
              child: Text(
                'Henüz çıktı yok',
                style: GoogleFonts.inter(
                  fontSize: 14,
                  color: PColors.textDim,
                ),
              ),
            ),
          )
        else
          ...deliverables.map((d) => _buildDeliverableCard(d)),
      ],
    );
  }

  Widget _buildDeliverableCard(TeamDeliverable deliverable) {
    return GlassMorphicCard(
      margin: const EdgeInsets.only(bottom: 12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(
                deliverable.hasFile ? LucideIcons.file : LucideIcons.link,
                color: PColors.primary,
                size: 20,
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Text(
                  deliverable.title,
                  style: GoogleFonts.poppins(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: PColors.text,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Text(
            deliverable.description,
            style: GoogleFonts.inter(
              fontSize: 12,
              color: PColors.textDim,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildActionButtons(BuildContext context, SolutionWorkshop workshop) {
    return Column(
      children: [
        SizedBox(
          width: double.infinity,
          child: GlassButton(
            label: 'Takım Sohbeti',
            onPressed: () {},
          ),
        ),
        const SizedBox(height: 12),
        SizedBox(
          width: double.infinity,
          child: GlassButton(
            label: 'AI Asistan',
            onPressed: () {},
          ),
        ),
        const SizedBox(height: 12),
        SizedBox(
          width: double.infinity,
          child: GlassButton(
            label: 'Çıktı Gönder',
            onPressed: () {},
          ),
        ),
      ],
    );
  }

  Widget _buildNotFound(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(
            LucideIcons.searchX,
            size: 64,
            color: PColors.textDim,
          ),
          const SizedBox(height: 16),
          Text(
            'Atölye Bulunamadı',
            style: GoogleFonts.poppins(
              fontSize: 18,
              fontWeight: FontWeight.w600,
              color: PColors.text,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildError(BuildContext context, String error) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(
            LucideIcons.triangleAlert,
            size: 64,
            color: PColors.warning,
          ),
          const SizedBox(height: 16),
          Text(
            'Hata Oluştu',
            style: GoogleFonts.poppins(
              fontSize: 18,
              fontWeight: FontWeight.w600,
              color: PColors.text,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            error,
            style: GoogleFonts.inter(
              fontSize: 14,
              color: PColors.textDim,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
