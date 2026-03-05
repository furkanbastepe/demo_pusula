import 'package:flutter/material.dart';

// ═══════════════════════════════════════════════════════════════════════════════════
// 🌌 AURORA GLASS THEME CONSTANTS
// ═══════════════════════════════════════════════════════════════════════════════════
// 
// Aurora Glass is a three-layer design philosophy:
// - Layer 0: Dynamic Aurora Background (animated bokeh-style radial gradients)
// - Layer 1: Glass Surfaces (semi-transparent cards with glowing edges)
// - Layer 2: Opaque Controls (high contrast text, icons, and CTA buttons)
//
// This file contains all constants and specifications for the Aurora Glass system.
// ═══════════════════════════════════════════════════════════════════════════════════

class AuroraGlassTheme {
  const AuroraGlassTheme._();

  // ═══════════════════════════════════════════════════════════════════════════════
  // LAYER 0: DYNAMIC AURORA (Background)
  // ═══════════════════════════════════════════════════════════════════════════════
  
  /// Animation duration for aurora background (slow, meditative movement)
  static const auroraDuration = Duration(seconds: 18);
  
  /// Number of bokeh circles in the aurora background
  static const auroraCircleCount = 4;
  
  /// Opacity range for aurora gradients (subtle, not overwhelming)
  static const auroraOpacityMin = 0.05;
  static const auroraOpacityMax = 0.15;
  
  /// Minimum and maximum radius for bokeh circles (as fraction of screen size)
  static const auroraRadiusMin = 0.3;
  static const auroraRadiusMax = 0.6;

  // ═══════════════════════════════════════════════════════════════════════════════
  // LAYER 1: GLASS SURFACES (Content Containers)
  // ═══════════════════════════════════════════════════════════════════════════════
  
  /// Surface opacity for glass cards (aurora visible through glass)
  static const glassOpacity = 0.35;
  
  /// Blur radius for backdrop filter on glass surfaces
  static const glassBlur = 15.0;
  
  /// Border opacity for glowing edge effect
  static const glassBorderOpacity = 0.15;
  
  /// Border width for glowing edge
  static const glassBorderWidth = 1.5;
  
  /// Border radius for glass cards
  static const glassBorderRadius = 20.0;
  
  /// Opacity for glass button normal state
  static const glassButtonOpacity = 0.1;
  
  /// Border opacity for glass button normal state
  static const glassButtonBorderOpacity = 0.2;
  
  /// Border width for glass button
  static const glassButtonBorderWidth = 1.0;

  // ═══════════════════════════════════════════════════════════════════════════════
  // LAYER 2: OPAQUE CONTROLS (Actions & Text)
  // ═══════════════════════════════════════════════════════════════════════════════
  
  /// Border radius for Primary CTA buttons (more rounded than glass)
  static const ctaBorderRadius = 28.0;
  
  /// Padding for Primary CTA buttons
  static const ctaPadding = EdgeInsets.symmetric(horizontal: 24, vertical: 16);
  
  /// Text size for Primary CTA buttons
  static const ctaTextSize = 16.0;
  
  /// Font weight for Primary CTA buttons
  static const ctaFontWeight = FontWeight.w600;

  // ═══════════════════════════════════════════════════════════════════════════════
  // INTERACTIONS (Fill & Glow Pattern)
  // ═══════════════════════════════════════════════════════════════════════════════
  
  /// Duration for Fill & Glow state transitions
  static const interactionDuration = Duration(milliseconds: 150);
  
  /// Curve for Fill & Glow animations
  static const interactionCurve = Curves.easeOut;
  
  /// Glow shadow opacity for filled state
  static const glowShadowOpacity = 0.3;
  
  /// Glow shadow blur radius
  static const glowShadowBlur = 20.0;
  
  /// Glow shadow spread radius
  static const glowShadowSpread = 0.0;

  // ═══════════════════════════════════════════════════════════════════════════════
  // NAVIGATION
  // ═══════════════════════════════════════════════════════════════════════════════
  
  /// Navigation bar background opacity
  static const navBarOpacity = 0.95;
  
  /// Navigation bar blur radius
  static const navBarBlur = 15.0;
  
  /// Active tab capsule border radius
  static const activeTabBorderRadius = 20.0;
  
  /// Active tab capsule padding
  static const activeTabPadding = EdgeInsets.symmetric(horizontal: 16, vertical: 8);
  
  /// Navigation icon size
  static const navIconSize = 24.0;
  
  /// Navigation label size
  static const navLabelSize = 11.0;
  
  /// Active navigation label font weight
  static const navLabelWeightActive = FontWeight.w600;
  
  /// Inactive navigation label font weight
  static const navLabelWeightInactive = FontWeight.w400;

  // ═══════════════════════════════════════════════════════════════════════════════
  // ACCESSIBILITY
  // ═══════════════════════════════════════════════════════════════════════════════
  
  /// Minimum touch target size (48x48 dp for accessibility)
  static const minTouchTarget = 48.0;
  
  /// Minimum contrast ratio for WCAG AA compliance
  static const minContrastRatio = 4.5;

  // ═══════════════════════════════════════════════════════════════════════════════
  // PERFORMANCE
  // ═══════════════════════════════════════════════════════════════════════════════
  
  /// Target frame rate for animations
  static const targetFps = 60;
  
  /// Maximum acceptable frame rendering time (ms)
  static const maxFrameTime = 16.67; // 1000ms / 60fps
}
