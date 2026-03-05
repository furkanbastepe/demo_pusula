import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import '../../core/core.dart';
import '../../widgets/common/aurora_background.dart';
import '../../widgets/common/glass_morphic_card.dart';

class RoleSelectionScreen extends StatelessWidget {
  const RoleSelectionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          AuroraBackground(),
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const SizedBox(height: 40),
                    Container(
                      padding: const EdgeInsets.all(20),
                      decoration: BoxDecoration(
                        gradient: RadialGradient(
                          colors: [
                            PColors.primary.withValues(alpha: 0.1),
                            Colors.transparent,
                          ],
                        ),
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(
                        LucideIcons.users,
                        size: 80,
                        color: PColors.primary,
                      ),
                    ).animate().scale(),
                    const SizedBox(height: 24),
                    Text(
                      'Rolünü Seç',
                      style: GoogleFonts.poppins(
                        fontSize: 28,
                        fontWeight: FontWeight.w700,
                        color: PColors.text,
                      ),
                      textAlign: TextAlign.center,
                    ).animate().fadeIn(delay: 200.ms),
                    const SizedBox(height: 12),
                    Text(
                      'Rolüne göre özelleştirilmiş deneyim sunuyoruz',
                      style: GoogleFonts.inter(
                        fontSize: 16,
                        color: PColors.textDim,
                      ),
                      textAlign: TextAlign.center,
                    ).animate().fadeIn(delay: 400.ms),
                    const SizedBox(height: 48),
                    Column(
                      children: [
                        _buildRoleCard(
                          context: context,
                          title: 'Genç',
                          subtitle:
                              'Kariyerine gerçek projelerle başla, potansiyelini ortaya çıkar',
                          icon: LucideIcons.graduationCap,
                          color: PColors.primary,
                          onTap: () => context.go('/onboarding'),
                          features: [
                            'Usta-çırak sistemi ile ilerle',
                            'Beceri atölyelerine katıl',
                            'Gerçek deneyim kazan ve sertifikayla kanıtla',
                            'Mentörlük al',
                          ],
                        ).animate().fadeIn(delay: 600.ms).slideX(begin: -0.3),
                        const SizedBox(height: 20),
                        _buildRoleCard(
                          context: context,
                          title: 'DİGEM REHBERİ',
                          subtitle: 'Gençleri yönet, proje yayınla, ortaklıkları koordine et',
                          icon: LucideIcons.shieldCheck,
                          color: PColors.accent,
                          onTap: () => context.go('/digem-guide'),
                          features: [
                            'Gençleri kaydet ve gelişimlerini takip et',
                            'Atölye ve etkinlik düzenle',
                            'İş ortağı projeleri yayınla',
                            'Başvuruları değerlendir ve eşleştir',
                            'Ortaklık koordinasyonu yap',
                            'Raporlama ve analitik',
                          ],
                        ).animate().fadeIn(delay: 700.ms).slideX(begin: -0.3),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildRoleCard({
    required BuildContext context,
    required String title,
    required String subtitle,
    required IconData icon,
    required Color color,
    required VoidCallback onTap,
    required List<String> features,
  }) {
    return GestureDetector(
      onTap: () {
        HapticFeedback.lightImpact();
        onTap();
      },
      child: GlassMorphicCard(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    gradient: RadialGradient(
                      colors: [color.withValues(alpha: 0.2), color.withValues(alpha: 0.05)],
                    ),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Icon(icon, color: color, size: 24),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        title,
                        style: GoogleFonts.poppins(
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                          color: PColors.text,
                        ),
                      ),
                      Text(
                        subtitle,
                        style: GoogleFonts.inter(
                          fontSize: 14,
                          color: PColors.textDim,
                        ),
                      ),
                    ],
                  ),
                ),
                const Icon(
                  LucideIcons.chevronRight,
                  color: PColors.textDim,
                  size: 20,
                ),
              ],
            ),
            const SizedBox(height: 16),
            ...features.map(
              (feature) => Padding(
                padding: const EdgeInsets.only(bottom: 8),
                child: Row(
                  children: [
                    Icon(LucideIcons.circleCheck, color: color, size: 16),
                    const SizedBox(width: 8),
                    Expanded(
                      child: Text(
                        feature,
                        style: GoogleFonts.inter(
                          fontSize: 12,
                          color: PColors.textDim,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
