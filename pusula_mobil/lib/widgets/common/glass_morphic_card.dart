import 'dart:ui';
import 'package:flutter/material.dart';
import '../../core/core.dart';

// ═══════════════════════════════════════════════════════════════════════════════════
// 🌟 AURORA GLASS CARD - Layer 1 Component
// ═══════════════════════════════════════════════════════════════════════════════════
//
// Layer 1 of the Aurora Glass design philosophy.
// Semi-transparent glass surfaces that allow the aurora background to shine through
// while maintaining content readability. Features a glowing edge effect that simulates
// light refraction on frosted glass.
//
// Technical Specifications:
// - Opacity: 0.35 (aurora visible through glass)
// - Blur: 15px (enhanced glass effect)
// - Border: Glowing edge with white 0.15 opacity, 1.5px width
// - Border Radius: 20px (soft, premium feel)
// - Shadow: Premium depth shadow
// ═══════════════════════════════════════════════════════════════════════════════════

class GlassMorphicCard extends StatelessWidget {
  final Widget child;
  final double? blurRadius;
  final double? opacity;
  final double? borderOpacity;
  final double? borderWidth;
  final double? borderRadius;
  final EdgeInsetsGeometry? padding;
  final EdgeInsetsGeometry? margin;

  const GlassMorphicCard({
    super.key,
    required this.child,
    this.blurRadius,
    this.opacity,
    this.borderOpacity,
    this.borderWidth,
    this.borderRadius,
    this.padding,
    this.margin,
  });

  @override
  Widget build(BuildContext context) {
    final effectiveBlurRadius = blurRadius ?? AuroraGlassTheme.glassBlur;
    final effectiveOpacity = opacity ?? AuroraGlassTheme.glassOpacity;
    final effectiveBorderOpacity = borderOpacity ?? AuroraGlassTheme.glassBorderOpacity;
    final effectiveBorderWidth = borderWidth ?? AuroraGlassTheme.glassBorderWidth;
    final effectiveBorderRadius = borderRadius ?? AuroraGlassTheme.glassBorderRadius;

    return Container(
      margin: margin,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(effectiveBorderRadius),
        child: BackdropFilter(
          filter: ImageFilter.blur(
            sigmaX: effectiveBlurRadius, 
            sigmaY: effectiveBlurRadius,
          ),
          child: Container(
            padding: padding ?? const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: PColors.surface.withValues(alpha: effectiveOpacity),
              borderRadius: BorderRadius.circular(effectiveBorderRadius),
              border: Border.all(
                color: Colors.white.withValues(alpha: effectiveBorderOpacity),
                width: effectiveBorderWidth,
              ),
              boxShadow: PShadows.premium(),
            ),
            child: child,
          ),
        ),
      ),
    );
  }
}
