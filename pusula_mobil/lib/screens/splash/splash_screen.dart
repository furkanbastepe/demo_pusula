import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import 'package:pusula/core/core.dart';
import 'package:pusula/widgets/common/aurora_background.dart';

/// Premium Splash Screen - Professional & Corporate
/// 
/// Subtle animations that convey quality without being flashy or game-like.
/// - Smooth rotation (2s)
/// - Subtle breathing pulse (2s, scale 1.0 → 1.08)
/// - Professional glow (3s, alpha 0.2 → 0.4)
/// - NO particles (too playful)
/// - NO bright effects (too casual)
class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> 
    with TickerProviderStateMixin {
  
  // Animation 1: Compass Rotation (2s, smooth)
  late AnimationController _rotationController;
  
  // Animation 2: Breathing Pulse (2s, subtle)
  late AnimationController _pulseController;
  late Animation<double> _pulseAnimation;
  
  // Animation 3: Professional Glow (3s, not flashy)
  late AnimationController _glowController;
  late Animation<double> _glowAnimation;
  
  // Animation 4: Text Fade (1s)
  late AnimationController _fadeController;
  late Animation<double> _fadeAnimation;

  @override
  void initState() {
    super.initState();
    
    // 1. Rotation (smooth, professional)
    _rotationController = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    )..repeat();
    
    // 2. Pulse (subtle breathing - 1.0 → 1.08, not 1.15)
    _pulseController = AnimationController(
      duration: const Duration(milliseconds: 2000),
      vsync: this,
    )..repeat(reverse: true);
    
    _pulseAnimation = Tween<double>(
      begin: 1.0,
      end: 1.08, // Subtle, not exaggerated
    ).animate(CurvedAnimation(
      parent: _pulseController,
      curve: Curves.easeInOut,
    ));
    
    // 3. Glow (professional - alpha 0.2 → 0.4, not 0.8)
    _glowController = AnimationController(
      duration: const Duration(milliseconds: 3000),
      vsync: this,
    )..repeat(reverse: true);
    
    _glowAnimation = Tween<double>(
      begin: 0.2, // Subtle start
      end: 0.4,   // Professional peak (not bright)
    ).animate(CurvedAnimation(
      parent: _glowController,
      curve: Curves.easeInOut,
    ));
    
    // 4. Text fade
    _fadeController = AnimationController(
      duration: const Duration(milliseconds: 1000),
      vsync: this,
    );
    
    _fadeAnimation = CurvedAnimation(
      parent: _fadeController,
      curve: Curves.easeIn,
    );
    
    _initSplash();
  }

  void _initSplash() async {
    await Future.delayed(const Duration(milliseconds: 500));
    await _fadeController.forward();
    await Future.delayed(const Duration(milliseconds: 2500));
    if (mounted) {
      context.go('/login');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Professional Aurora Background
          const AuroraBackground(),
          
          // Content
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Compass with subtle animations
                AnimatedBuilder(
                  animation: Listenable.merge([
                    _rotationController,
                    _pulseController,
                    _glowController,
                  ]),
                  builder: (context, child) {
                    return Transform.scale(
                      scale: _pulseAnimation.value,
                      child: Transform.rotate(
                        angle: _rotationController.value * 2 * pi,
                        child: Container(
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            boxShadow: [
                              BoxShadow(
                                color: PColors.primary.withValues(
                                  alpha: _glowAnimation.value,
                                ),
                                blurRadius: 30, // Subtle blur
                                spreadRadius: 5, // Not too much
                              ),
                            ],
                          ),
                          child: const Icon(
                            LucideIcons.compass,
                            size: 120,
                            color: PColors.primary,
                          ),
                        ),
                      ),
                    );
                  },
                ),
                
                const SizedBox(height: 32),
                
                // Text with professional fade
                FadeTransition(
                  opacity: _fadeAnimation,
                  child: Column(
                    children: [
                      Text(
                        'PUSULA',
                        style: GoogleFonts.poppins(
                          fontSize: 48,
                          fontWeight: FontWeight.bold,
                          color: PColors.text,
                          letterSpacing: 2,
                        ),
                      )
                          .animate(onPlay: (controller) => controller.repeat())
                          .shimmer(
                            duration: 2000.ms,
                            color: PColors.primary.withValues(alpha: 0.4),
                            size: 0.5,
                          ),
                      const SizedBox(height: 8),
                      Text(
                        'Potansiyelini Deneyime Dönüştür',
                        style: GoogleFonts.inter(
                          fontSize: 16,
                          color: PColors.textDim,
                          letterSpacing: 0.5,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _rotationController.dispose();
    _pulseController.dispose();
    _glowController.dispose();
    _fadeController.dispose();
    super.dispose();
  }
}
