import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../core/core.dart';

// ═══════════════════════════════════════════════════════════════════════════════════
// 🔘 GLASS BUTTON - Fill & Glow Interaction Pattern
// ═══════════════════════════════════════════════════════════════════════════════════
//
// Secondary action button that implements the Fill & Glow interaction pattern.
// Transforms from glass appearance (Layer 1) to filled appearance (Layer 2) on press.
//
// States:
// - Normal: Semi-transparent glass with glowing border
// - Pressed: Opaque with primary color fill and glow shadow
// - Disabled: Dimmed glass appearance
//
// Technical Specifications:
// - Normal: white 0.1 opacity background, white 0.2 opacity border
// - Pressed: PColors.primary background, no border, glow shadow
// - Transition: 150ms with easeOut curve
// - Haptic: Light impact feedback on press
// - Touch Target: Minimum 48x48 dp
// ═══════════════════════════════════════════════════════════════════════════════════

class GlassButton extends StatefulWidget {
  final String label;
  final VoidCallback? onPressed;
  final IconData? icon;
  final bool isLoading;
  final double? width;
  final EdgeInsetsGeometry? padding;

  const GlassButton({
    super.key,
    required this.label,
    this.onPressed,
    this.icon,
    this.isLoading = false,
    this.width,
    this.padding,
  });

  @override
  State<GlassButton> createState() => _GlassButtonState();
}

class _GlassButtonState extends State<GlassButton> {
  bool _isPressed = false;

  @override
  Widget build(BuildContext context) {
    final isDisabled = widget.onPressed == null || widget.isLoading;
    
    return GestureDetector(
      onTapDown: isDisabled ? null : (_) {
        setState(() => _isPressed = true);
        HapticFeedback.lightImpact();
      },
      onTapUp: isDisabled ? null : (_) {
        setState(() => _isPressed = false);
        widget.onPressed?.call();
      },
      onTapCancel: isDisabled ? null : () {
        setState(() => _isPressed = false);
      },
      child: AnimatedContainer(
        duration: AuroraGlassTheme.interactionDuration,
        curve: AuroraGlassTheme.interactionCurve,
        width: widget.width,
        padding: widget.padding ?? const EdgeInsets.symmetric(
          horizontal: 20,
          vertical: 12,
        ),
        constraints: const BoxConstraints(
          minHeight: AuroraGlassTheme.minTouchTarget,
        ),
        decoration: BoxDecoration(
          color: _getBackgroundColor(isDisabled),
          borderRadius: BorderRadius.circular(AuroraGlassTheme.glassBorderRadius),
          border: _getBorder(isDisabled),
          boxShadow: _getShadow(isDisabled),
        ),
        child: _buildContent(isDisabled),
      ),
    );
  }

  Color _getBackgroundColor(bool isDisabled) {
    if (isDisabled) {
      return Colors.white.withValues(alpha: 0.05);
    }
    if (_isPressed) {
      return PColors.primary;
    }
    return Colors.white.withValues(alpha: AuroraGlassTheme.glassButtonOpacity);
  }

  Border? _getBorder(bool isDisabled) {
    if (_isPressed) {
      return null; // No border when pressed (filled state)
    }
    
    final opacity = isDisabled 
        ? 0.1 
        : AuroraGlassTheme.glassButtonBorderOpacity;
    
    return Border.all(
      color: Colors.white.withValues(alpha: opacity),
      width: AuroraGlassTheme.glassButtonBorderWidth,
    );
  }

  List<BoxShadow>? _getShadow(bool isDisabled) {
    if (isDisabled) return null;
    if (_isPressed) {
      return PShadows.glowPrimary();
    }
    return null;
  }

  Widget _buildContent(bool isDisabled) {
    final textColor = _isPressed 
        ? Colors.white 
        : (isDisabled 
            ? PColors.textDim.withValues(alpha: 0.5)
            : PColors.text);

    if (widget.isLoading) {
      return Center(
        child: SizedBox(
          width: 20,
          height: 20,
          child: CircularProgressIndicator(
            strokeWidth: 2,
            valueColor: AlwaysStoppedAnimation<Color>(textColor),
          ),
        ),
      );
    }

    if (widget.icon != null) {
      return Row(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            widget.icon,
            size: 18,
            color: textColor,
          ),
          const SizedBox(width: 8),
          Text(
            widget.label,
            style: TextStyle(
              color: textColor,
              fontSize: 14,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      );
    }

    return Center(
      child: Text(
        widget.label,
        style: TextStyle(
          color: textColor,
          fontSize: 14,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }
}
