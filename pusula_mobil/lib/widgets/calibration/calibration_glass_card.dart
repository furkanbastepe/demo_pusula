import 'dart:ui';
import 'package:flutter/material.dart';
import '../../core/core.dart';

/// Calibration Glass Card - Aurora Glass Design
/// 
/// Professional glass card with:
/// - 0.35 opacity (aurora visible through glass)
/// - 15px blur (enhanced glass effect)
/// - Glowing edge (white 0.15 opacity, 1.5px width)
/// - 20px border radius (soft, premium)
class CalibrationGlassMorphicCard extends StatelessWidget {
  final Widget child;
  final EdgeInsetsGeometry? padding;
  final EdgeInsetsGeometry? margin;

  const CalibrationGlassMorphicCard({
    super.key,
    required this.child,
    this.padding,
    this.margin,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: margin,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(20),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 15, sigmaY: 15),
          child: Container(
            padding: padding ?? const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: PColors.surface.withValues(alpha: 0.35),
              borderRadius: BorderRadius.circular(20),
              border: Border.all(
                color: Colors.white.withValues(alpha: 0.15),
                width: 1.5,
              ),
            ),
            child: child,
          ),
        ),
      ),
    );
  }
}
