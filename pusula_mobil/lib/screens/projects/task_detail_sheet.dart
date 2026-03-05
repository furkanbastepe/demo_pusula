import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import '../../core/core.dart';
import '../../data/data.dart';
import '../../widgets/common/common.dart';

class TaskDetailSheet extends StatelessWidget {
  final Task task;
  final double matchScore;

  const TaskDetailSheet({
    super.key,
    required this.task,
    required this.matchScore,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.9,
      decoration: const BoxDecoration(
        color: PColors.surface,
        borderRadius: BorderRadius.vertical(top: Radius.circular(25)),
      ),
      child: Column(
        children: [
          Container(
            margin: const EdgeInsets.only(top: 12),
            width: 40,
            height: 4,
            decoration: BoxDecoration(
              color: PColors.border,
              borderRadius: BorderRadius.circular(2),
            ),
          ),

          Expanded(
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Hero image
                  SizedBox(
                    height: 200,
                    width: double.infinity,
                    child: Stack(
                      children: [
                        ProjectImage(
                          imageUrl: task.imageUrl,
                          width: double.infinity,
                          height: 200,
                        ),

                        Container(
                          height: 200,
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              begin: Alignment.topCenter,
                              end: Alignment.bottomCenter,
                              colors: [
                                Colors.transparent,
                                Colors.black.withValues(alpha: 0.7),
                              ],
                            ),
                          ),
                        ),

                        Positioned(
                          top: 20,
                          right: 20,
                          child: GestureDetector(
                            onTap: () => Navigator.pop(context),
                            child: Container(
                              padding: const EdgeInsets.all(8),
                              decoration: BoxDecoration(
                                color: Colors.black.withValues(alpha: 0.5),
                                borderRadius: BorderRadius.circular(25),
                              ),
                              child: const Icon(
                                LucideIcons.x,
                                color: Colors.white,
                                size: 20,
                              ),
                            ),
                          ),
                        ),

                        Positioned(
                          bottom: 20,
                          left: 20,
                          right: 20,
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
                                      color: task.typeColor,
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                    child: Text(
                                      task.typeDescription,
                                      style: GoogleFonts.inter(
                                        fontSize: 12,
                                        color: Colors.white,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  ),
                                  if (matchScore > 70) ...[
                                    const SizedBox(width: 8),
                                    Container(
                                      padding: const EdgeInsets.symmetric(
                                        horizontal: 8,
                                        vertical: 4,
                                      ),
                                      decoration: BoxDecoration(
                                        color: PColors.success,
                                        borderRadius: BorderRadius.circular(8),
                                      ),
                                      child: Row(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          const Icon(
                                            LucideIcons.heart,
                                            size: 12,
                                            color: Colors.white,
                                          ),
                                          const SizedBox(width: 4),
                                          Text(
                                            '${matchScore.toInt()}% uyum',
                                            style: GoogleFonts.inter(
                                              fontSize: 12,
                                              color: Colors.white,
                                              fontWeight: FontWeight.w600,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ],
                              ),
                              const SizedBox(height: 12),
                              Text(
                                task.title,
                                style: GoogleFonts.poppins(
                                  fontSize: 22,
                                  fontWeight: FontWeight.w700,
                                  color: Colors.white,
                                ),
                              ),
                              const SizedBox(height: 4),
                              Text(
                                task.organization,
                                style: GoogleFonts.inter(
                                  fontSize: 14,
                                  color: Colors.white.withValues(alpha: 0.9),
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),

                  Padding(
                    padding: const EdgeInsets.all(20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Quick info
                        Row(
                          children: [
                            Expanded(
                              child: _buildQuickInfo(
                                LucideIcons.clock,
                                '${task.estimatedHours} saat',
                                'Tahmini süre',
                              ),
                            ),
                            Expanded(
                              child: _buildQuickInfo(
                                LucideIcons.mapPin,
                                PusulaCore.digemCities[task.city] ?? task.city,
                                'Konum',
                              ),
                            ),
                            Expanded(
                              child: _buildQuickInfo(
                                LucideIcons.calendar,
                                '${task.remainingDays} gün',
                                'Kalan süre',
                              ),
                            ),
                          ],
                        ),

                        const SizedBox(height: 24),

                        // Description
                        Text(
                          'Proje Açıklaması',
                          style: GoogleFonts.poppins(
                            fontSize: 18,
                            fontWeight: FontWeight.w600,
                            color: PColors.text,
                          ),
                        ),
                        const SizedBox(height: 12),
                        Text(
                          task.description,
                          style: GoogleFonts.inter(
                            fontSize: 14,
                            color: PColors.textDim,
                            height: 1.5,
                          ),
                        ),

                        const SizedBox(height: 24),

                        // Required skills
                        if (task.requiredSkills.isNotEmpty) ...[
                          Text(
                            'Aranan Beceriler',
                            style: GoogleFonts.poppins(
                              fontSize: 18,
                              fontWeight: FontWeight.w600,
                              color: PColors.text,
                            ),
                          ),
                          const SizedBox(height: 12),
                          Wrap(
                            spacing: 8,
                            runSpacing: 8,
                            children: task.requiredSkills
                                .map(
                                  (skill) => Container(
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 12,
                                      vertical: 8,
                                    ),
                                    decoration: BoxDecoration(
                                      color: task.typeColor.withValues(alpha: 0.15),
                                      borderRadius: BorderRadius.circular(25),
                                      border: Border.all(
                                        color: task.typeColor.withValues(alpha: 0.3),
                                      ),
                                    ),
                                    child: Text(
                                      skill,
                                      style: GoogleFonts.inter(
                                        fontSize: 12,
                                        color: task.typeColor,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  ),
                                )
                                .toList(),
                          ),
                          const SizedBox(height: 24),
                        ],

                        // XP and reward info
                        Container(
                          padding: const EdgeInsets.all(16),
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              colors: [
                                PColors.accent.withValues(alpha: 0.1),
                                PColors.accent.withValues(alpha: 0.05),
                              ],
                            ),
                            borderRadius: BorderRadius.circular(20),
                            border: Border.all(
                              color: PColors.accent.withValues(alpha: 0.3),
                            ),
                          ),
                          child: Row(
                            children: [
                              Container(
                                padding: const EdgeInsets.all(12),
                                decoration: BoxDecoration(
                                  color: PColors.accent.withValues(alpha: 0.15),
                                  borderRadius: BorderRadius.circular(15),
                                ),
                                child: const Icon(
                                  LucideIcons.star,
                                  color: PColors.accent,
                                  size: 24,
                                ),
                              ),
                              const SizedBox(width: 16),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'Kazanacağın XP',
                                      style: GoogleFonts.poppins(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w600,
                                        color: PColors.accent,
                                      ),
                                    ),
                                    Text(
                                      '+${task.xpReward} XP',
                                      style: GoogleFonts.poppins(
                                        fontSize: 20,
                                        fontWeight: FontWeight.w700,
                                        color: PColors.accent,
                                      ),
                                    ),
                                    Text(
                                      'Seviye ilerlemen için puan',
                                      style: GoogleFonts.inter(
                                        fontSize: 11,
                                        color: PColors.textDim,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),

                        const SizedBox(height: 32),

                        // Join Button
                        SizedBox(
                          width: double.infinity,
                          height: 56,
                          child: ElevatedButton(
                            onPressed: task.isAvailable
                                ? () {
                                    HapticFeedback.lightImpact();
                                    Navigator.pop(context);
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(
                                        content: Text(
                                          'Başvurun alındı! Değerlendirme süreci başladı.',
                                          style: GoogleFonts.inter(
                                            color: Colors.white,
                                          ),
                                        ),
                                        backgroundColor: PColors.success,
                                        behavior: SnackBarBehavior.floating,
                                        shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(
                                            12,
                                          ),
                                        ),
                                      ),
                                    );
                                  }
                                : null,
                            style: ElevatedButton.styleFrom(
                              backgroundColor: task.isAvailable
                                  ? task.typeColor
                                  : PColors.border,
                              foregroundColor: Colors.white,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(28),
                              ),
                              elevation: task.isAvailable ? 8 : 0,
                              shadowColor: task.isAvailable
                                  ? task.typeColor.withValues(alpha: 0.3)
                                  : null,
                            ),
                            child: Text(
                              task.isAvailable ? 'Projeye Katıl' : 'Proje Dolu',
                              style: GoogleFonts.poppins(
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        ),

                        const SizedBox(height: 20),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildQuickInfo(IconData icon, String value, String label) {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: PColors.primary.withValues(alpha: 0.1),
            borderRadius: BorderRadius.circular(15),
          ),
          child: Icon(icon, color: PColors.primary, size: 20),
        ),
        const SizedBox(height: 8),
        Text(
          value,
          style: GoogleFonts.poppins(
            fontSize: 14,
            fontWeight: FontWeight.w700,
            color: PColors.text,
          ),
          textAlign: TextAlign.center,
        ),
        Text(
          label,
          style: GoogleFonts.inter(fontSize: 11, color: PColors.textDim),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }
}
