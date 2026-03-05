import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import '../../core/core.dart';
import '../../widgets/common/aurora_background.dart';

// ═══════════════════════════════════════════════════════════════════════════════════
// 🔐 LOGIN SCREEN - pusulafnl.txt İÇERİK + AnimatedBackground
// ═══════════════════════════════════════════════════════════════════════════════════

// Glassmorphic TextField Widget
class _GlassmorphicTextField extends StatelessWidget {
  final TextEditingController controller;
  final String labelText;
  final String hintText;
  final IconData prefixIcon;
  final bool obscureText;
  final TextInputType? keyboardType;

  const _GlassmorphicTextField({
    required this.controller,
    required this.labelText,
    required this.hintText,
    required this.prefixIcon,
    this.obscureText = false,
    this.keyboardType,
  });

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(16),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 15, sigmaY: 15),
        child: Container(
          decoration: BoxDecoration(
            color: PColors.surface.withValues(alpha: 0.35),
            borderRadius: BorderRadius.circular(16),
            border: Border.all(
              color: Colors.white.withValues(alpha: 0.15),
              width: 1.5,
            ),
          ),
          child: TextField(
            controller: controller,
            obscureText: obscureText,
            keyboardType: keyboardType,
            style: GoogleFonts.inter(
              color: PColors.text,
              fontSize: 16,
            ),
            decoration: InputDecoration(
              labelText: labelText,
              labelStyle: GoogleFonts.inter(
                color: PColors.textDim,
                fontSize: 14,
              ),
              hintText: hintText,
              hintStyle: GoogleFonts.inter(
                color: PColors.textDim.withValues(alpha: 0.5),
                fontSize: 14,
              ),
              prefixIcon: Icon(
                prefixIcon,
                color: PColors.primary,
                size: 20,
              ),
              border: InputBorder.none,
              contentPadding: const EdgeInsets.symmetric(
                horizontal: 16,
                vertical: 16,
              ),
              floatingLabelBehavior: FloatingLabelBehavior.auto,
            ),
          ),
        ),
      ),
    );
  }
}

class LoginScreen extends ConsumerStatefulWidget {
  const LoginScreen({super.key});

  @override
  ConsumerState<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends ConsumerState<LoginScreen> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          AuroraBackground(),
          SafeArea(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(24),
              child: ConstrainedBox(
                constraints: BoxConstraints(
                  minHeight: MediaQuery.of(context).size.height - 
                             MediaQuery.of(context).padding.top - 
                             MediaQuery.of(context).padding.bottom - 48,
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    const SizedBox(height: 20),
                    
                    const Icon(
                      LucideIcons.compass,
                      size: 80,
                      color: PColors.primary,
                    ).animate().scale(),
                    
                    const SizedBox(height: 24),
                    
                    Text(
                      'Hoş Geldin',
                      style: GoogleFonts.poppins(
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                        color: PColors.text,
                      ),
                      textAlign: TextAlign.center,
                    ).animate().fadeIn(delay: 200.ms),
                    
                    const SizedBox(height: 8),
                    
                    Text(
                      'Topluluğa katıl, deneyim kazanmaya başla',
                      style: GoogleFonts.inter(
                        fontSize: 16,
                        color: PColors.textDim,
                      ),
                      textAlign: TextAlign.center,
                    ).animate().fadeIn(delay: 400.ms),
                    
                    const SizedBox(height: 48),
                    
                    _GlassmorphicTextField(
                      controller: _emailController,
                      labelText: 'E-posta',
                      hintText: 'ornek@email.com',
                      prefixIcon: LucideIcons.mail,
                      keyboardType: TextInputType.emailAddress,
                    ).animate().fadeIn(delay: 600.ms).slideY(begin: 0.2),
                    
                    const SizedBox(height: 16),
                    
                    _GlassmorphicTextField(
                      controller: _passwordController,
                      labelText: 'Şifre',
                      hintText: 'En az 6 karakter',
                      prefixIcon: LucideIcons.lock,
                      obscureText: true,
                    ).animate().fadeIn(delay: 700.ms).slideY(begin: 0.2),
                    
                    const SizedBox(height: 24),
                    
                    SizedBox(
                      height: 50,
                      child: ElevatedButton(
                        onPressed: () {
                          HapticFeedback.lightImpact();
                          context.go('/role-selection');
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: PColors.primary,
                          foregroundColor: PColors.background,
                          padding: const EdgeInsets.symmetric(vertical: 12),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          elevation: 8,
                          shadowColor: PColors.primary.withValues(alpha: 0.3),
                        ),
                        child: Text(
                          'Giriş Yap',
                          style: GoogleFonts.inter(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ).animate().fadeIn(delay: 800.ms).slideY(begin: 0.3),
                    
                    const SizedBox(height: 16),
                    
                    SizedBox(
                      height: 50,
                      child: OutlinedButton(
                        onPressed: () {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text(
                                'Kayıt özelliği yakında eklenecek!',
                                style: GoogleFonts.inter(color: PColors.background),
                              ),
                              backgroundColor: PColors.primary,
                              duration: const Duration(seconds: 2),
                              behavior: SnackBarBehavior.floating,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                            ),
                          );
                        },
                        style: OutlinedButton.styleFrom(
                          foregroundColor: PColors.primary,
                          side: const BorderSide(color: PColors.primary),
                          padding: const EdgeInsets.symmetric(vertical: 12),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                        child: Text(
                          'Hesap Oluştur',
                          style: GoogleFonts.inter(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ).animate().fadeIn(delay: 900.ms).slideY(begin: 0.3),
                    
                    const SizedBox(height: 20),
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
