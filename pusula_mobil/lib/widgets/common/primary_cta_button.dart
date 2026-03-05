import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../core/core.dart';

// ═══════════════════════════════════════════════════════════════════════════════════
// 🎯 PRIMARY CTA BUTTON - Layer 2 Component
// ═══════════════════════════════════════════════════════════════════════════════════
//
// Primary call-to-action button for critical user actions.
// Always opaque (Layer 2) with high contrast for maximum visibility and clarity.
//
// Usage:
// - Lesson progression: "Dersi Tamamla", "Devam Et"
// - Project actions: "Projeye Katıl"
// - Authentication: "Giriş Yap"
// - Any primary action that drives user progression
//
// Technical Specifications:
// - Background: PColors.primary (full opacity)
// - Border Radius: 28px (more rounded than glass buttons)
// - Padding: 24px horizontal, 16px vertical
// - Text: GoogleFonts.inter, 16px, weight 600
// - Width: Full width by default (with horizontal margin)
// - Shadow: Elevated with primary color glow
// ═══════════════════════════════════════════════════════════════════════════════════

class PrimaryCTAButton extends StatelessWidget {
  final String label;
  final VoidCallback? onPressed;
  final bool isLoading;
  final bool isFullWidth;
  final IconData? icon;
  final EdgeInsetsGeometry? margin;

  const PrimaryCTAButton({
    super.key,
    required this.label,
    this.onPressed,
    this.isLoading = false,
    this.isFullWidth = true,
    this.icon,
    this.margin,
  });

  @override
  Widget build(BuildContext context) {
    final isDisabled = onPressed == null || isLoading;

    return Container(
      width: isFullWidth ? double.infinity : null,
      margin: margin ?? const EdgeInsets.symmetric(horizontal: 20),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: isDisabled ? null : () {
            HapticFeedback.lightImpact();
            onPressed?.call();
          },
          borderRadius: BorderRadius.circular(AuroraGlassTheme.ctaBorderRadius),
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 150),
            padding: AuroraGlassTheme.ctaPadding,
            constraints: const BoxConstraints(
              minHeight: AuroraGlassTheme.minTouchTarget,
            ),
            decoration: BoxDecoration(
              color: isDisabled 
                  ? PColors.textDim.withValues(alpha: 0.3)
                  : PColors.primary,
              borderRadius: BorderRadius.circular(AuroraGlassTheme.ctaBorderRadius),
              boxShadow: isDisabled ? null : PShadows.glowPrimary(),
            ),
            child: _buildContent(isDisabled),
          ),
        ),
      ),
    );
  }

  Widget _buildContent(bool isDisabled) {
    if (isLoading) {
      return const Center(
        child: SizedBox(
          width: 24,
          height: 24,
          child: CircularProgressIndicator(
            strokeWidth: 2.5,
            valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
          ),
        ),
      );
    }

    final textWidget = Text(
      label,
      style: GoogleFonts.inter(
        color: Colors.white,
        fontSize: AuroraGlassTheme.ctaTextSize,
        fontWeight: AuroraGlassTheme.ctaFontWeight,
      ),
      textAlign: TextAlign.center,
    );

    if (icon != null) {
      return Row(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            icon,
            size: 20,
            color: Colors.white,
          ),
          const SizedBox(width: 12),
          textWidget,
        ],
      );
    }

    return Center(child: textWidget);
  }
}
