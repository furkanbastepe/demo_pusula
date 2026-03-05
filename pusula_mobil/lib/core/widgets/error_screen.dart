import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import '../theme/colors.dart';
import '../../widgets/common/aurora_background.dart';
import '../../widgets/common/glass_button.dart';

// ═══════════════════════════════════════════════════════════════════════════════════
// ❌ ERROR SCREEN
// ═══════════════════════════════════════════════════════════════════════════════════

class ErrorScreen extends StatelessWidget {
  final Exception? error;
  final VoidCallback? onRetry;

  const ErrorScreen({
    super.key,
    this.error,
    this.onRetry,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: PColors.background,
      body: Stack(
        children: [
          AuroraBackground(),
          SafeArea(
            child: Center(
              child: Padding(
                padding: const EdgeInsets.all(32),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      width: 100,
                      height: 100,
                      decoration: BoxDecoration(
                        color: PColors.warning.withValues(alpha: 0.15),
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(
                        LucideIcons.triangleAlert,
                        size: 50,
                        color: PColors.warning,
                      ),
                    ),
                    const SizedBox(height: 24),
                    Text(
                      'Bir Hata Oluştu',
                      style: GoogleFonts.poppins(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: PColors.text,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 12),
                    Text(
                      error != null
                          ? 'Sayfa yüklenirken bir sorun oluştu.'
                          : 'Aradığınız sayfa bulunamadı.',
                      style: GoogleFonts.inter(
                        fontSize: 14,
                        color: PColors.textDim,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 32),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        if (onRetry != null) ...[
                          GlassButton(
                            label: 'Tekrar Dene',
                            icon: LucideIcons.refreshCw,
                            onPressed: onRetry,
                          ),
                          const SizedBox(width: 12),
                        ],
                        GlassButton(
                          label: 'Ana Sayfa',
                          icon: LucideIcons.house,
                          onPressed: () => context.go('/home'),
                        ),
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
}
