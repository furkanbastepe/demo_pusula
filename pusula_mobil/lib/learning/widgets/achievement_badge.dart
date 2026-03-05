import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../core/core.dart';
import '../models/models.dart';

// ═══════════════════════════════════════════════════════════════════════════════════
// 🏆 ACHIEVEMENT BADGE WIDGET
// ═══════════════════════════════════════════════════════════════════════════════════

class AchievementBadge extends StatelessWidget {
  final Achievement achievement;
  final bool isEarned;

  const AchievementBadge({
    super.key,
    required this.achievement,
    required this.isEarned,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 80,
      margin: const EdgeInsets.only(right: 12),
      child: Column(
        children: [
          Container(
            width: 60,
            height: 60,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: isEarned
                  ? PColors.accent.withValues(alpha: 0.2)
                  : PColors.surfaceHi,
              border: Border.all(
                color: isEarned ? PColors.accent : PColors.border,
                width: 2,
              ),
            ),
            child: Center(
              child: Text(
                achievement.iconPath,
                style: TextStyle(
                  fontSize: 28,
                  color: isEarned ? null : Colors.grey.withValues(alpha: 0.3),
                ),
              ),
            ),
          ),
          const SizedBox(height: 8),
          Text(
            achievement.title,
            style: GoogleFonts.inter(
              fontSize: 11,
              color: isEarned ? PColors.text : PColors.textDim,
              fontWeight: isEarned ? FontWeight.w600 : FontWeight.normal,
            ),
            textAlign: TextAlign.center,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ),
    );
  }
}
