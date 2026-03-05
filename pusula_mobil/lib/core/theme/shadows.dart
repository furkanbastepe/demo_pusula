import 'package:flutter/material.dart';
import 'colors.dart';

// ═══════════════════════════════════════════════════════════════════════════════════
// 🎨 SHADOW EFFECTS
// ═══════════════════════════════════════════════════════════════════════════════════

class PShadows {
  const PShadows._();
  
  static List<BoxShadow> soft() => const [
    BoxShadow(
      color: Colors.black54, 
      blurRadius: 22, 
      spreadRadius: -14, 
      offset: Offset(0, 16)
    )
  ];
  
  static List<BoxShadow> glow(Color c) => [
    BoxShadow(
      color: c.withValues(alpha: 0.2), 
      blurRadius: 36, 
      spreadRadius: -4, 
      offset: const Offset(0, 10)
    )
  ];
  
  /// Glow effect for Fill & Glow interaction pattern (Aurora Glass)
  static List<BoxShadow> glowPrimary() => [
    BoxShadow(
      color: PColors.primary.withValues(alpha: 0.3),
      blurRadius: 20,
      spreadRadius: 0,
      offset: const Offset(0, 8),
    ),
  ];
  
  static List<BoxShadow> premium() => [
    BoxShadow(
      color: Colors.black.withValues(alpha: 0.1),
      blurRadius: 20,
      spreadRadius: -8,
      offset: const Offset(0, 8),
    ),
    BoxShadow(
      color: PColors.primary.withValues(alpha: 0.05),
      blurRadius: 32,
      spreadRadius: -12,
      offset: const Offset(0, 16),
    ),
  ];
}
