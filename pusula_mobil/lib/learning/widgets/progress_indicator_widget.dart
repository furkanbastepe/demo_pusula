import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../core/core.dart';

// ═══════════════════════════════════════════════════════════════════════════════════
// 📊 PROGRESS INDICATOR WIDGET
// ═══════════════════════════════════════════════════════════════════════════════════

class ProgressIndicatorWidget extends StatelessWidget {
  final double progress;
  final bool showPercentage;

  const ProgressIndicatorWidget({
    super.key,
    required this.progress,
    this.showPercentage = true,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(10),
          child: LinearProgressIndicator(
            value: progress,
            backgroundColor: PColors.surfaceHi,
            valueColor: const AlwaysStoppedAnimation<Color>(PColors.primary),
            minHeight: 8,
          ),
        ),
        if (showPercentage) ...[
          const SizedBox(height: 8),
          Text(
            '${(progress * 100).toInt()}%',
            style: GoogleFonts.inter(
              fontSize: 14,
              fontWeight: FontWeight.w600,
              color: PColors.primary,
            ),
          ),
        ],
      ],
    );
  }
}
