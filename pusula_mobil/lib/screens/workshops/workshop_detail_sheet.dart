import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import '../../core/core.dart';
import '../../data/data.dart';

class WorkshopDetailSheet extends StatelessWidget {
  final Workshop workshop;

  const WorkshopDetailSheet({super.key, required this.workshop});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.85,
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
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          workshop.title,
                          style: GoogleFonts.poppins(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: PColors.text,
                          ),
                        ),
                      ),
                      GestureDetector(
                        onTap: () => Navigator.pop(context),
                        child: Container(
                          padding: const EdgeInsets.all(8),
                          decoration: BoxDecoration(
                            color: PColors.surfaceHi,
                            borderRadius: BorderRadius.circular(25),
                          ),
                          child: const Icon(
                            LucideIcons.x,
                            color: PColors.textDim,
                            size: 16,
                          ),
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 24),

                  // Workshop info
                  Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: PColors.surfaceHi,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Column(
                      children: [
                        _buildWorkshopInfoRow(
                          LucideIcons.user,
                          'Eğitmen',
                          '${workshop.instructorName} (${workshop.instructorLevel.name})',
                        ),
                        const SizedBox(height: 12),
                        _buildWorkshopInfoRow(
                          LucideIcons.calendar,
                          'Tarih & Saat',
                          workshop.formattedDateTime,
                        ),
                        const SizedBox(height: 12),
                        _buildWorkshopInfoRow(
                          LucideIcons.clock,
                          'Süre',
                          '${workshop.duration} dakika',
                        ),
                        const SizedBox(height: 12),
                        _buildWorkshopInfoRow(
                          LucideIcons.mapPin,
                          'Konum',
                          workshop.digemCenter,
                        ),
                        const SizedBox(height: 12),
                        _buildWorkshopInfoRow(
                          LucideIcons.users,
                          'Katılımcı',
                          '${workshop.currentParticipants}/${workshop.maxParticipants}',
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 24),

                  // Skills to gain
                  if (workshop.skillsToGain.isNotEmpty) ...[
                    Text(
                      'Kazanacağın Beceriler ✨',
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
                      children: workshop.skillsToGain
                          .map(
                            (skill) => Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 12,
                                vertical: 8,
                              ),
                              decoration: BoxDecoration(
                                color: PColors.accent.withValues(alpha: 0.15),
                                borderRadius: BorderRadius.circular(25),
                                border: Border.all(
                                  color: PColors.accent.withValues(alpha: 0.3),
                                ),
                              ),
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Icon(
                                    LucideIcons.circleCheck,
                                    color: PColors.accent,
                                    size: 14,
                                  ),
                                  const SizedBox(width: 4),
                                  Text(
                                    skill,
                                    style: GoogleFonts.inter(
                                      fontSize: 12,
                                      color: PColors.accent,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          )
                          .toList(),
                    ),
                    const SizedBox(height: 32),
                  ],

                  // Join Button
                  SizedBox(
                    width: double.infinity,
                    height: 56,
                    child: ElevatedButton(
                      onPressed: workshop.isAvailable
                          ? () {
                              HapticFeedback.lightImpact();
                              Navigator.pop(context);
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text(
                                    'Atölyeye kaydın tamamlandı! Bildirim alacaksın.',
                                    style: GoogleFonts.inter(
                                      color: Colors.white,
                                    ),
                                  ),
                                  backgroundColor: PColors.success,
                                  behavior: SnackBarBehavior.floating,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                ),
                              );
                            }
                          : null,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: workshop.isAvailable
                            ? PColors.accent
                            : PColors.border,
                        foregroundColor: workshop.isAvailable
                            ? Colors.white
                            : PColors.textDim,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(28),
                        ),
                        elevation: workshop.isAvailable ? 8 : 0,
                        shadowColor: workshop.isAvailable
                            ? PColors.accent.withValues(alpha: 0.3)
                            : null,
                      ),
                      child: Text(
                        workshop.isAvailable
                            ? 'Atölyeye Kayıt Ol'
                            : 'Kontenjan Dolu',
                        style: GoogleFonts.poppins(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
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

  Widget _buildWorkshopInfoRow(IconData icon, String label, String value) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: const EdgeInsets.all(6),
          decoration: BoxDecoration(
            color: PColors.accent.withValues(alpha: 0.15),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Icon(icon, color: PColors.accent, size: 16),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                label,
                style: GoogleFonts.inter(
                  fontSize: 12,
                  color: PColors.textDim,
                  fontWeight: FontWeight.w500,
                ),
              ),
              Text(
                value,
                style: GoogleFonts.inter(
                  fontSize: 14,
                  color: PColors.text,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
