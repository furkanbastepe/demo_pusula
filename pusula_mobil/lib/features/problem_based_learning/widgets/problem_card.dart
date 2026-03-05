import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import '../../../core/core.dart';
import '../../../widgets/common/common.dart';
import '../models/models.dart';

// ═══════════════════════════════════════════════════════════════════════════════════
// 🎯 PROBLEM CARD WIDGET - Problem-Based Learning
// ═══════════════════════════════════════════════════════════════════════════════════

class ProblemCard extends StatelessWidget {
  final Problem problem;
  final double matchScore;
  final VoidCallback? onTap;

  const ProblemCard({
    super.key,
    required this.problem,
    this.matchScore = 0.0,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: GlassMorphicCard(
        padding: EdgeInsets.zero,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            // Header with badges
            _buildHeader(),
            
            // Content
            Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  // Title
                  Text(
                    problem.title,
                    style: GoogleFonts.poppins(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: PColors.text,
                      height: 1.3,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  
                  const SizedBox(height: 6),
                  
                  // Organization
                  Row(
                    children: [
                      Icon(
                        LucideIcons.building2,
                        size: 12,
                        color: PColors.textDim,
                      ),
                      const SizedBox(width: 4),
                      Expanded(
                        child: Text(
                          problem.organization,
                          style: GoogleFonts.inter(
                            fontSize: 11,
                            color: PColors.textDim,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  ),
                  
                  const SizedBox(height: 8),
                  
                  // Impact and Match indicators
                  Wrap(
                    spacing: 8,
                    runSpacing: 8,
                    children: [
                      _buildImpactIndicator(),
                      if (matchScore > 70) _buildMatchBadge(),
                    ],
                  ),
                  
                  const SizedBox(height: 8),
                  
                  // Engagement stats
                  _buildEngagementStats(),
                  
                  const SizedBox(height: 10),
                  
                  // Action button
                  SizedBox(
                    width: double.infinity,
                    child: GlassButton(
                      label: 'İncele',
                      onPressed: onTap,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    ).animate().fadeIn(duration: 300.ms).slideX(begin: 0.2, end: 0);
  }

  Widget _buildHeader() {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: problem.impactArea.color.withValues(alpha: 0.1),
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
      ),
      child: Row(
        children: [
          // Impact area badge
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
            decoration: BoxDecoration(
              color: problem.impactArea.color,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(
                  problem.impactArea.icon,
                  size: 12,
                  color: Colors.white,
                ),
                const SizedBox(width: 4),
                Text(
                  problem.impactArea.displayName,
                  style: GoogleFonts.inter(
                    fontSize: 10,
                    color: Colors.white,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),
          
          const Spacer(),
        ],
      ),
    );
  }

  Widget _buildImpactIndicator() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: problem.impactColor.withValues(alpha: 0.15),
        borderRadius: BorderRadius.circular(6),
        border: Border.all(
          color: problem.impactColor.withValues(alpha: 0.3),
          width: 1,
        ),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            LucideIcons.target,
            size: 12,
            color: problem.impactColor,
          ),
          const SizedBox(width: 4),
          Text(
            'Etki: ${problem.impactScore}',
            style: GoogleFonts.inter(
              fontSize: 11,
              color: problem.impactColor,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMatchBadge() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: PColors.success.withValues(alpha: 0.15),
        borderRadius: BorderRadius.circular(6),
        border: Border.all(
          color: PColors.success.withValues(alpha: 0.3),
          width: 1,
        ),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Icon(
            LucideIcons.heart,
            size: 10,
            color: PColors.success,
          ),
          const SizedBox(width: 4),
          Text(
            '${matchScore.toInt()}% uyum',
            style: GoogleFonts.inter(
              fontSize: 10,
              color: PColors.success,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildEngagementStats() {
    return Row(
      children: [
        // Active workshops
        if (problem.engagement.activeWorkshops > 0) ...[
          Icon(
            LucideIcons.users,
            size: 12,
            color: PColors.info,
          ),
          const SizedBox(width: 4),
          Text(
            '${problem.engagement.activeWorkshops} atölye',
            style: GoogleFonts.inter(
              fontSize: 11,
              color: PColors.info,
            ),
          ),
        ],
      ],
    );
  }
}
