import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../core/core.dart';
import '../models/models.dart';

// ═══════════════════════════════════════════════════════════════════════════════════
// 📚 COURSE CARD WIDGET
// ═══════════════════════════════════════════════════════════════════════════════════

class CourseCard extends StatelessWidget {
  final Course course;
  final double progress;
  final int completedLessons;
  final VoidCallback onTap;

  const CourseCard({
    super.key,
    required this.course,
    required this.progress,
    required this.completedLessons,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Semantics(
      label: '${course.title} kursu, ${(progress * 100).toInt()} yüzde tamamlandı, $completedLessons ders tamamlandı',
      button: true,
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          margin: const EdgeInsets.only(bottom: 16),
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: PColors.surface.withValues(alpha: 0.8),
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: PColors.border.withValues(alpha: 0.3),
          ),
          boxShadow: PShadows.premium(),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                // Icon
                Container(
                  width: 60,
                  height: 60,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        PColors.primary,
                        PColors.primary.withValues(alpha: 0.7),
                      ],
                    ),
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: Center(
                    child: Text(
                      course.iconPath,
                      style: const TextStyle(fontSize: 32),
                    ),
                  ),
                ),
                const SizedBox(width: 16),
                // Title and description
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        course.title,
                        style: GoogleFonts.poppins(
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                          color: PColors.text,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        course.description,
                        style: GoogleFonts.inter(
                          fontSize: 13,
                          color: PColors.textDim,
                        ),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            // Progress bar
            ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: LinearProgressIndicator(
                value: progress,
                backgroundColor: PColors.surfaceHi,
                valueColor: AlwaysStoppedAnimation<Color>(PColors.primary),
                minHeight: 8,
              ),
            ),
            const SizedBox(height: 12),
            // Stats
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  '$completedLessons/${course.totalLessons} ders tamamlandı',
                  style: GoogleFonts.inter(
                    fontSize: 12,
                    color: PColors.textDim,
                  ),
                ),
                Text(
                  '${(progress * 100).toInt()}%',
                  style: GoogleFonts.inter(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: PColors.primary,
                  ),
                ),
              ],
            ),
          ],
        ),
        ),
      ),
    );
  }
}
