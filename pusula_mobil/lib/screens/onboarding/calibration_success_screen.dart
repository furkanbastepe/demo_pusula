import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import '../../core/core.dart';
import '../../widgets/common/aurora_background.dart';

class CalibrationSuccessScreen extends HookConsumerWidget {
  const CalibrationSuccessScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    useEffect(() {
      Timer(const Duration(seconds: 2), () {
        context.go('/home');
      });
      return null;
    }, []);

    return Scaffold(
      body: Stack(
        children: [
          AuroraBackground(),
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                      width: 120,
                      height: 120,
                      decoration: BoxDecoration(
                        color: PColors.success.withValues(alpha: 0.15),
                        borderRadius: BorderRadius.circular(60),
                        border: Border.all(
                          color: PColors.success.withValues(alpha: 0.3),
                          width: 2,
                        ),
                      ),
                      child: const Icon(
                        LucideIcons.circleCheck,
                        color: PColors.success,
                        size: 60,
                      ),
                    )
                    .animate()
                    .scale(
                      duration: const Duration(milliseconds: 800),
                      curve: Curves.elasticOut,
                    )
                    .fade(duration: const Duration(milliseconds: 600))
                    .then()
                    .shimmer(duration: const Duration(milliseconds: 1000)),

                const SizedBox(height: 40),

                Text(
                      'Tebrikler!',
                      style: GoogleFonts.poppins(
                        fontSize: 32,
                        fontWeight: FontWeight.w700,
                        color: PColors.text,
                      ),
                    )
                    .animate(delay: const Duration(milliseconds: 400))
                    .slideY(
                      begin: 1,
                      duration: const Duration(milliseconds: 600),
                      curve: Curves.easeOut,
                    )
                    .fade(duration: const Duration(milliseconds: 500)),

                const SizedBox(height: 16),

                Text(
                      'PUSULA\'ya hoş geldin!\nDijital yolculuğun başlıyor...',
                      style: GoogleFonts.inter(
                        fontSize: 16,
                        color: PColors.textDim,
                        height: 1.5,
                      ),
                      textAlign: TextAlign.center,
                    )
                    .animate(delay: const Duration(milliseconds: 600))
                    .slideY(
                      begin: 1,
                      duration: const Duration(milliseconds: 600),
                      curve: Curves.easeOut,
                    )
                    .fade(duration: const Duration(milliseconds: 500)),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
