import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../core/core.dart';
import '../models/models.dart';

// ═══════════════════════════════════════════════════════════════════════════════════
// 🏆 ACHIEVEMENT NOTIFICATION DIALOG
// ═══════════════════════════════════════════════════════════════════════════════════

class AchievementNotificationDialog extends StatelessWidget {
  final Achievement achievement;
  final int bonusXP;

  const AchievementNotificationDialog({
    super.key,
    required this.achievement,
    this.bonusXP = 50,
  });

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.transparent,
      child: Container(
        padding: const EdgeInsets.all(24),
        decoration: BoxDecoration(
          color: PColors.surface,
          borderRadius: BorderRadius.circular(24),
          border: Border.all(
            color: PColors.accent,
            width: 2,
          ),
          boxShadow: [
            BoxShadow(
              color: PColors.accent.withValues(alpha: 0.3),
              blurRadius: 20,
              spreadRadius: 5,
            ),
          ],
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Achievement icon with glow
            Container(
              width: 100,
              height: 100,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: PColors.accent.withValues(alpha: 0.2),
                boxShadow: [
                  BoxShadow(
                    color: PColors.accent.withValues(alpha: 0.5),
                    blurRadius: 30,
                    spreadRadius: 10,
                  ),
                ],
              ),
              child: Center(
                child: Text(
                  achievement.iconPath,
                  style: const TextStyle(fontSize: 56),
                ),
              ),
            )
                .animate(onPlay: (controller) => controller.repeat())
                .shimmer(duration: 2000.ms, color: PColors.accent.withValues(alpha: 0.3))
                .scale(
                  duration: 1000.ms,
                  begin: const Offset(1, 1),
                  end: const Offset(1.1, 1.1),
                )
                .then()
                .scale(
                  duration: 1000.ms,
                  begin: const Offset(1.1, 1.1),
                  end: const Offset(1, 1),
                ),

            const SizedBox(height: 24),

            // Title
            Text(
              'Başarı Kazandın!',
              style: GoogleFonts.poppins(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: PColors.text,
              ),
            ).animate().fadeIn(delay: 300.ms).slideY(begin: 0.3),

            const SizedBox(height: 12),

            // Achievement title
            Text(
              achievement.title,
              style: GoogleFonts.poppins(
                fontSize: 20,
                fontWeight: FontWeight.w600,
                color: PColors.accent,
              ),
              textAlign: TextAlign.center,
            ).animate().fadeIn(delay: 500.ms).slideY(begin: 0.3),

            const SizedBox(height: 8),

            // Achievement description
            Text(
              achievement.description,
              style: GoogleFonts.inter(
                fontSize: 14,
                color: PColors.textDim,
              ),
              textAlign: TextAlign.center,
            ).animate().fadeIn(delay: 700.ms).slideY(begin: 0.3),

            const SizedBox(height: 20),

            // Bonus XP
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              decoration: BoxDecoration(
                color: PColors.accent.withValues(alpha: 0.15),
                borderRadius: BorderRadius.circular(20),
                border: Border.all(color: PColors.accent),
              ),
              child: Text(
                '+$bonusXP Bonus XP',
                style: GoogleFonts.inter(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: PColors.accent,
                ),
              ),
            ).animate().fadeIn(delay: 900.ms).scale(),

            const SizedBox(height: 24),

            // Close button
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () => Navigator.of(context).pop(),
                style: ElevatedButton.styleFrom(
                  backgroundColor: PColors.accent,
                  foregroundColor: PColors.background,
                  padding: const EdgeInsets.symmetric(vertical: 14),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(25),
                  ),
                ),
                child: Text(
                  'Harika!',
                  style: GoogleFonts.inter(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ).animate().fadeIn(delay: 1100.ms).slideY(begin: 0.3),
          ],
        ),
      ),
    );
  }

  static void show(BuildContext context, Achievement achievement, {int bonusXP = 50}) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => AchievementNotificationDialog(
        achievement: achievement,
        bonusXP: bonusXP,
      ),
    );
  }
}
