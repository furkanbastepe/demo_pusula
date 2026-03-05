import 'dart:math' as math;
import 'package:flutter/material.dart';
import '../../core/core.dart';

/// Hybrid Aurora Background - Professional & Corporate
/// 
/// Combines moving linear gradient (12s) with subtle bokeh circles (18s)
/// for a premium, elegant background that's not distracting.
/// 
/// Performance: 60fps target, hardware-accelerated
class AuroraBackground extends StatefulWidget {
  const AuroraBackground({super.key});
  
  @override
  State<AuroraBackground> createState() => _AuroraBackgroundState();
}

class _AuroraBackgroundState extends State<AuroraBackground> 
    with TickerProviderStateMixin {
  
  // Bokeh circles animation (18 seconds - slow, meditative)
  late AnimationController _bokehController;
  
  // Linear gradient animation (12 seconds - smooth movement)
  late AnimationController _gradientController;
  late Animation<Alignment> _topAlignment;
  late Animation<Alignment> _bottomAlignment;

  @override
  void initState() {
    super.initState();
    
    // Bokeh circles controller
    _bokehController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 18),
    )..repeat();
    
    // Linear gradient controller
    _gradientController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 12),
    )..repeat();
    
    // Top alignment animation (circular movement)
    _topAlignment = TweenSequence<Alignment>([
      TweenSequenceItem(
        tween: AlignmentTween(
          begin: Alignment.topLeft,
          end: Alignment.topRight,
        ),
        weight: 1,
      ),
      TweenSequenceItem(
        tween: AlignmentTween(
          begin: Alignment.topRight,
          end: Alignment.bottomRight,
        ),
        weight: 1,
      ),
      TweenSequenceItem(
        tween: AlignmentTween(
          begin: Alignment.bottomRight,
          end: Alignment.bottomLeft,
        ),
        weight: 1,
      ),
      TweenSequenceItem(
        tween: AlignmentTween(
          begin: Alignment.bottomLeft,
          end: Alignment.topLeft,
        ),
        weight: 1,
      ),
    ]).animate(_gradientController);
    
    // Bottom alignment animation (opposite direction for depth)
    _bottomAlignment = TweenSequence<Alignment>([
      TweenSequenceItem(
        tween: AlignmentTween(
          begin: Alignment.bottomRight,
          end: Alignment.bottomLeft,
        ),
        weight: 1,
      ),
      TweenSequenceItem(
        tween: AlignmentTween(
          begin: Alignment.bottomLeft,
          end: Alignment.topLeft,
        ),
        weight: 1,
      ),
      TweenSequenceItem(
        tween: AlignmentTween(
          begin: Alignment.topLeft,
          end: Alignment.topRight,
        ),
        weight: 1,
      ),
      TweenSequenceItem(
        tween: AlignmentTween(
          begin: Alignment.topRight,
          end: Alignment.bottomRight,
        ),
        weight: 1,
      ),
    ]).animate(_gradientController);
  }

  @override
  void dispose() {
    _bokehController.dispose();
    _gradientController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return RepaintBoundary(
      child: Stack(
        children: [
          // Layer 1: Moving Linear Gradient (base layer)
          AnimatedBuilder(
            animation: _gradientController,
            builder: (context, child) {
              return Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: _topAlignment.value,
                    end: _bottomAlignment.value,
                    colors: [
                      PColors.gradientStart.withValues(alpha: 0.12),
                      PColors.background,
                      PColors.gradientEnd.withValues(alpha: 0.08),
                      PColors.gradientPurple.withValues(alpha: 0.05),
                    ],
                  ),
                ),
              );
            },
          ),
          
          // Layer 2: Subtle Bokeh Circles (depth layer)
          AnimatedBuilder(
            animation: _bokehController,
            builder: (context, child) {
              return CustomPaint(
                painter: _SubtleBokehPainter(_bokehController.value),
                size: Size.infinite,
              );
            },
          ),
        ],
      ),
    );
  }
}

/// Subtle Bokeh Painter - Professional, not flashy
/// 
/// Creates 4 bokeh circles with very subtle opacity (0.05-0.12)
/// for a premium, corporate feel.
class _SubtleBokehPainter extends CustomPainter {
  final double progress;
  
  _SubtleBokehPainter(this.progress);

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()..style = PaintingStyle.fill;
    
    // Only 4 circles for professional look (not too busy)
    for (int i = 0; i < 4; i++) {
      _drawBokehCircle(canvas, size, i, paint);
    }
  }

  void _drawBokehCircle(Canvas canvas, Size size, int index, Paint paint) {
    final phaseShift = index * (2 * math.pi / 4);
    final angle = progress * 2 * math.pi + phaseShift;
    
    // Subtle movement radius (not too much)
    final movementRadius = size.width * 0.15 * (1 + index * 0.08);
    final centerX = size.width * 0.5 + movementRadius * math.cos(angle);
    final centerY = size.height * 0.5 + movementRadius * math.sin(angle);
    
    // Breathing effect (very subtle)
    final baseRadius = size.width * (0.25 + 
        0.05 * (0.5 + 0.5 * math.sin(progress * 2 * math.pi + phaseShift)));
    
    // Professional color palette
    final colors = [
      PColors.primary,
      PColors.accent,
      PColors.gradientPurple,
      PColors.gradientEnd,
    ];
    
    // Very subtle opacity (0.05-0.12) - professional, not flashy
    final opacity = 0.05 + 
        0.07 * (0.5 + 0.5 * math.sin(progress * 2 * math.pi + phaseShift * 2));
    
    paint.shader = RadialGradient(
      colors: [
        colors[index].withValues(alpha: opacity),
        colors[index].withValues(alpha: opacity * 0.5),
        colors[index].withValues(alpha: 0.0),
      ],
      stops: const [0.0, 0.5, 1.0],
    ).createShader(Rect.fromCircle(
      center: Offset(centerX, centerY),
      radius: baseRadius,
    ));
    
    canvas.drawCircle(Offset(centerX, centerY), baseRadius, paint);
  }

  @override
  bool shouldRepaint(_SubtleBokehPainter oldDelegate) {
    return oldDelegate.progress != progress;
  }
}
