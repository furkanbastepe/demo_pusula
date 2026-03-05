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
// 🎯 PROBLEM DETAIL SHEET - Problem-Based Learning
// ═══════════════════════════════════════════════════════════════════════════════════

class ProblemDetailSheet extends ConsumerStatefulWidget {
  final Problem problem;
  final double matchScore;

  const ProblemDetailSheet({
    super.key,
    required this.problem,
    this.matchScore = 0.0,
  });

  @override
  ConsumerState<ProblemDetailSheet> createState() => _ProblemDetailSheetState();
}

class _ProblemDetailSheetState extends ConsumerState<ProblemDetailSheet> {
  bool _isSaved = false;

  @override
  Widget build(BuildContext context) {
    final workshopsAsync = ref.watch(problemWorkshopsProvider(widget.problem.id));

    return DraggableScrollableSheet(
      initialChildSize: 0.9,
      minChildSize: 0.5,
      maxChildSize: 0.95,
      builder: (context, scrollController) {
        return Container(
          decoration: BoxDecoration(
            color: PColors.background,
            borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
          ),
          child: Column(
            children: [
              // Handle bar
              Container(
                margin: const EdgeInsets.only(top: 12, bottom: 8),
                width: 40,
                height: 4,
                decoration: BoxDecoration(
                  color: PColors.textDim.withValues(alpha: 0.3),
                  borderRadius: BorderRadius.circular(2),
                ),
              ),

              // Header
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Row(
                  children: [
                    IconButton(
                      icon: const Icon(LucideIcons.x, color: PColors.text),
                      onPressed: () => Navigator.pop(context),
                    ),
                    const Spacer(),
                    IconButton(
                      icon: Icon(
                        _isSaved ? LucideIcons.bookmark : LucideIcons.bookmark,
                        color: _isSaved ? PColors.warning : PColors.textDim,
                      ),
                      onPressed: _toggleSave,
                    ),
                  ],
                ),
              ),

              // Content
              Expanded(
                child: SingleChildScrollView(
                  controller: scrollController,
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Title and organization
                      _buildHeader(),

                      const SizedBox(height: 16),

                      // Badges
                      _buildBadges(),

                      const SizedBox(height: 24),

                      // Description
                      _buildDescription(),

                      const SizedBox(height: 24),

                      // Required skills
                      _buildRequiredSkills(),

                      const SizedBox(height: 24),

                      // Constraints
                      if (widget.problem.constraints.isNotEmpty)
                        _buildConstraints(),

                      const SizedBox(height: 24),

                      // Active workshops
                      workshopsAsync.when(
                        data: (workshops) => _buildWorkshopsSection(workshops),
                        loading: () => const Center(
                          child: CircularProgressIndicator(),
                        ),
                        error: (_, __) => const SizedBox(),
                      ),

                      const SizedBox(height: 24),

                      // Action buttons
                      _buildActionButtons(workshopsAsync),

                      const SizedBox(height: 32),
                    ],
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildHeader() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          widget.problem.title,
          style: GoogleFonts.poppins(
            fontSize: 20,
            fontWeight: FontWeight.w600,
            color: PColors.text,
            height: 1.3,
          ),
        ),
        const SizedBox(height: 8),
        Row(
          children: [
            Icon(
              LucideIcons.building2,
              size: 16,
              color: PColors.textDim,
            ),
            const SizedBox(width: 6),
            Text(
              widget.problem.organization,
              style: GoogleFonts.inter(
                fontSize: 14,
                color: PColors.textDim,
              ),
            ),
            const SizedBox(width: 12),
            Icon(
              LucideIcons.mapPin,
              size: 16,
              color: PColors.textDim,
            ),
            const SizedBox(width: 6),
            Text(
              widget.problem.city,
              style: GoogleFonts.inter(
                fontSize: 14,
                color: PColors.textDim,
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildBadges() {
    return Wrap(
      spacing: 8,
      runSpacing: 8,
      children: [
        // Impact area
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
          decoration: BoxDecoration(
            color: widget.problem.impactArea.color.withValues(alpha: 0.15),
            borderRadius: BorderRadius.circular(8),
            border: Border.all(
              color: widget.problem.impactArea.color.withValues(alpha: 0.3),
            ),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                widget.problem.impactArea.icon,
                size: 16,
                color: widget.problem.impactArea.color,
              ),
              const SizedBox(width: 6),
              Text(
                widget.problem.impactArea.displayName,
                style: GoogleFonts.inter(
                  fontSize: 12,
                  color: widget.problem.impactArea.color,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ),

        // Urgency
        if (widget.problem.isUrgent)
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            decoration: BoxDecoration(
              color: widget.problem.urgencyColor.withValues(alpha: 0.15),
              borderRadius: BorderRadius.circular(8),
              border: Border.all(
                color: widget.problem.urgencyColor.withValues(alpha: 0.3),
              ),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(
                  LucideIcons.clock,
                  size: 16,
                  color: widget.problem.urgencyColor,
                ),
                const SizedBox(width: 6),
                Text(
                  '${widget.problem.daysUntilDeadline} gün kaldı',
                  style: GoogleFonts.inter(
                    fontSize: 12,
                    color: widget.problem.urgencyColor,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),

        // Match score
        if (widget.matchScore > 70)
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            decoration: BoxDecoration(
              color: PColors.success.withValues(alpha: 0.15),
              borderRadius: BorderRadius.circular(8),
              border: Border.all(
                color: PColors.success.withValues(alpha: 0.3),
              ),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Icon(
                  LucideIcons.heart,
                  size: 16,
                  color: PColors.success,
                ),
                const SizedBox(width: 6),
                Text(
                  '${widget.matchScore.toInt()}% uyum',
                  style: GoogleFonts.inter(
                    fontSize: 12,
                    color: PColors.success,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),

        // Impact score
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
          decoration: BoxDecoration(
            color: widget.problem.impactColor.withValues(alpha: 0.15),
            borderRadius: BorderRadius.circular(8),
            border: Border.all(
              color: widget.problem.impactColor.withValues(alpha: 0.3),
            ),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                LucideIcons.target,
                size: 16,
                color: widget.problem.impactColor,
              ),
              const SizedBox(width: 6),
              Text(
                'Etki: ${widget.problem.impactScore}',
                style: GoogleFonts.inter(
                  fontSize: 12,
                  color: widget.problem.impactColor,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildDescription() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Problem Açıklaması',
          style: GoogleFonts.poppins(
            fontSize: 16,
            fontWeight: FontWeight.w600,
            color: PColors.text,
          ),
        ),
        const SizedBox(height: 8),
        Text(
          widget.problem.description,
          style: GoogleFonts.inter(
            fontSize: 14,
            color: PColors.text,
            height: 1.6,
          ),
        ),
      ],
    );
  }

  Widget _buildRequiredSkills() {
    if (widget.problem.requiredSkills.isEmpty) return const SizedBox();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Gerekli Yetenekler',
          style: GoogleFonts.poppins(
            fontSize: 16,
            fontWeight: FontWeight.w600,
            color: PColors.text,
          ),
        ),
        const SizedBox(height: 12),
        Wrap(
          spacing: 8,
          runSpacing: 8,
          children: widget.problem.requiredSkills.map((skill) {
            return Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
              decoration: BoxDecoration(
                color: PColors.primary.withValues(alpha: 0.15),
                borderRadius: BorderRadius.circular(8),
                border: Border.all(
                  color: PColors.primary.withValues(alpha: 0.3),
                ),
              ),
              child: Text(
                skill,
                style: GoogleFonts.inter(
                  fontSize: 13,
                  color: PColors.primary,
                  fontWeight: FontWeight.w500,
                ),
              ),
            );
          }).toList(),
        ),
      ],
    );
  }

  Widget _buildConstraints() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Kısıtlar ve Kaynaklar',
          style: GoogleFonts.poppins(
            fontSize: 16,
            fontWeight: FontWeight.w600,
            color: PColors.text,
          ),
        ),
        const SizedBox(height: 12),
        GlassMorphicCard(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (widget.problem.constraints['budget'] != null) ...[
                _buildConstraintItem(
                  LucideIcons.dollarSign,
                  'Bütçe',
                  widget.problem.constraints['budget'] as String,
                ),
                const SizedBox(height: 12),
              ],
              if (widget.problem.constraints['timeline'] != null) ...[
                _buildConstraintItem(
                  LucideIcons.calendar,
                  'Zaman Çizelgesi',
                  widget.problem.constraints['timeline'] as String,
                ),
                const SizedBox(height: 12),
              ],
              if (widget.problem.constraints['technical'] != null)
                _buildConstraintItem(
                  LucideIcons.settings,
                  'Teknik Gereksinimler',
                  widget.problem.constraints['technical'] as String,
                ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildConstraintItem(IconData icon, String title, String value) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(icon, size: 20, color: PColors.info),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: GoogleFonts.inter(
                  fontSize: 13,
                  color: PColors.textDim,
                  fontWeight: FontWeight.w500,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                value,
                style: GoogleFonts.inter(
                  fontSize: 14,
                  color: PColors.text,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildWorkshopsSection(List<SolutionWorkshop> workshops) {
    if (workshops.isEmpty) return const SizedBox();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Aktif Atölyeler (${workshops.length})',
          style: GoogleFonts.poppins(
            fontSize: 16,
            fontWeight: FontWeight.w600,
            color: PColors.text,
          ),
        ),
        const SizedBox(height: 12),
        ...workshops.map((workshop) => _buildWorkshopCard(workshop)),
      ],
    );
  }

  Widget _buildWorkshopCard(SolutionWorkshop workshop) {
    return GlassMorphicCard(
      margin: const EdgeInsets.only(bottom: 12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                child: Text(
                  workshop.name,
                  style: GoogleFonts.poppins(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: PColors.text,
                  ),
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: workshop.status.color.withValues(alpha: 0.15),
                  borderRadius: BorderRadius.circular(6),
                ),
                child: Text(
                  workshop.status.displayName,
                  style: GoogleFonts.inter(
                    fontSize: 11,
                    color: workshop.status.color,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Row(
            children: [
              Icon(LucideIcons.users, size: 14, color: PColors.textDim),
              const SizedBox(width: 6),
              Text(
                workshop.participantCountText,
                style: GoogleFonts.inter(
                  fontSize: 12,
                  color: PColors.textDim,
                ),
              ),
              const SizedBox(width: 16),
              Icon(LucideIcons.calendar, size: 14, color: PColors.textDim),
              const SizedBox(width: 6),
              Text(
                _formatDate(workshop.createdAt),
                style: GoogleFonts.inter(
                  fontSize: 12,
                  color: PColors.textDim,
                ),
              ),
            ],
          ),
        ],
      ),
    ).animate().fadeIn(duration: 300.ms);
  }

  Widget _buildActionButtons(AsyncValue<List<SolutionWorkshop>> workshopsAsync) {
    return Column(
      children: [
        SizedBox(
          width: double.infinity,
          child: GlassButton(
            label: 'Atölyeye Katıl',
            onPressed: () => _joinWorkshop(workshopsAsync),
          ),
        ),
        const SizedBox(height: 12),
        SizedBox(
          width: double.infinity,
          child: GlassButton(
            label: 'Yeni Atölye Oluştur',
            onPressed: _createWorkshop,
          ),
        ),
      ],
    );
  }

  void _toggleSave() {
    setState(() {
      _isSaved = !_isSaved;
    });

    final problemService = ref.read(problemServiceProvider);
    // In production, would get actual user ID
    const userId = 'default_user';

    if (_isSaved) {
      problemService.saveProblem(userId, widget.problem.id);
      _showSnackBar('Problem kaydedildi');
    } else {
      problemService.unsaveProblem(userId, widget.problem.id);
      _showSnackBar('Kayıt kaldırıldı');
    }
  }

  void _joinWorkshop(AsyncValue<List<SolutionWorkshop>> workshopsAsync) {
    workshopsAsync.whenData((workshops) {
      if (workshops.isEmpty) {
        _createWorkshop();
        return;
      }

      // Show workshop selection dialog
      showDialog(
        context: context,
        builder: (context) => _WorkshopSelectionDialog(
          workshops: workshops,
          onJoin: (workshop) {
            Navigator.pop(context);
            _performJoinWorkshop(workshop.id);
          },
          onCreateNew: () {
            Navigator.pop(context);
            _createWorkshop();
          },
        ),
      );
    });
  }

  void _performJoinWorkshop(String workshopId) async {
    try {
      final workshopService = ref.read(workshopServiceProvider);
      const userId = 'default_user'; // In production, get from auth

      await workshopService.joinWorkshop(workshopId, userId);
      
      if (mounted) {
        _showSnackBar('Atölyeye katıldınız!');
        Navigator.pop(context);
      }
    } catch (e) {
      if (mounted) {
        _showSnackBar('Hata: ${e.toString()}');
      }
    }
  }

  void _createWorkshop() async {
    try {
      final workshopService = ref.read(workshopServiceProvider);
      const userId = 'default_user'; // In production, get from auth

      await workshopService.createWorkshop(widget.problem.id, userId);
      
      if (mounted) {
        _showSnackBar('Yeni atölye oluşturuldu!');
        ref.invalidate(problemWorkshopsProvider(widget.problem.id));
      }
    } catch (e) {
      if (mounted) {
        _showSnackBar('Hata: ${e.toString()}');
      }
    }
  }

  void _showSnackBar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: PColors.surface,
        behavior: SnackBarBehavior.floating,
      ),
    );
  }

  String _formatDate(DateTime date) {
    final now = DateTime.now();
    final difference = now.difference(date);

    if (difference.inDays == 0) {
      return 'Bugün';
    } else if (difference.inDays == 1) {
      return 'Dün';
    } else if (difference.inDays < 7) {
      return '${difference.inDays} gün önce';
    } else {
      return '${date.day}/${date.month}/${date.year}';
    }
  }
}

// ═══════════════════════════════════════════════════════════════════════════════════
// WORKSHOP SELECTION DIALOG
// ═══════════════════════════════════════════════════════════════════════════════════

class _WorkshopSelectionDialog extends StatelessWidget {
  final List<SolutionWorkshop> workshops;
  final Function(SolutionWorkshop) onJoin;
  final VoidCallback onCreateNew;

  const _WorkshopSelectionDialog({
    required this.workshops,
    required this.onJoin,
    required this.onCreateNew,
  });

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.transparent,
      child: GlassMorphicCard(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Atölye Seç',
              style: GoogleFonts.poppins(
                fontSize: 18,
                fontWeight: FontWeight.w600,
                color: PColors.text,
              ),
            ),
            const SizedBox(height: 16),
            ...workshops.map((workshop) => _buildWorkshopOption(workshop)),
            const SizedBox(height: 12),
            const Divider(color: PColors.border),
            const SizedBox(height: 12),
            SizedBox(
              width: double.infinity,
              child: GlassButton(
                label: 'Yeni Atölye Oluştur',
                onPressed: onCreateNew,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildWorkshopOption(SolutionWorkshop workshop) {
    return GestureDetector(
      onTap: () => onJoin(workshop),
      child: Container(
        margin: const EdgeInsets.only(bottom: 8),
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: PColors.surface.withValues(alpha: 0.5),
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: PColors.border),
        ),
        child: Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    workshop.name,
                    style: GoogleFonts.poppins(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: PColors.text,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    '${workshop.currentParticipants}/${workshop.maxParticipants} katılımcı',
                    style: GoogleFonts.inter(
                      fontSize: 12,
                      color: PColors.textDim,
                    ),
                  ),
                ],
              ),
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              decoration: BoxDecoration(
                color: workshop.status.color.withValues(alpha: 0.15),
                borderRadius: BorderRadius.circular(6),
              ),
              child: Text(
                workshop.status.displayName,
                style: GoogleFonts.inter(
                  fontSize: 11,
                  color: workshop.status.color,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
