import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import '../../core/core.dart';
import '../../providers/providers.dart';

// ═══════════════════════════════════════════════════════════════════════════════════
// 🏠 MAIN LAYOUT - Aurora Glass Navigation
// ═══════════════════════════════════════════════════════════════════════════════════
//
// Main app layout with Aurora Glass navigation system:
// - 5 tabs: Ana Sayfa, Projeler, Akademi, Topluluk, Profil
// - Fill & Glow interaction: Inactive tabs = glass, Active tab = filled capsule
// - Glass background with backdrop blur
// - No FAB (AI moved to HomeScreen AppBar)
// - Haptic feedback on tab taps
// ═══════════════════════════════════════════════════════════════════════════════════

class MainLayout extends ConsumerWidget {
  final Widget child;

  const MainLayout({super.key, required this.child});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentIndex = ref.watch(navigationIndexProvider);

    return Scaffold(
      backgroundColor: Colors.transparent,
      body: child,
      bottomNavigationBar: _buildGlassNavigationBar(context, ref, currentIndex),
    );
  }

  Widget _buildGlassNavigationBar(
    BuildContext context,
    WidgetRef ref,
    int currentIndex,
  ) {
    return Container(
      decoration: BoxDecoration(
        color: PColors.surface.withValues(alpha: AuroraGlassTheme.navBarOpacity),
        border: const Border(
          top: BorderSide(color: PColors.border, width: 1),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.1),
            blurRadius: 20,
            spreadRadius: -5,
          ),
        ],
      ),
      child: ClipRRect(
        child: BackdropFilter(
          filter: ImageFilter.blur(
            sigmaX: AuroraGlassTheme.navBarBlur,
            sigmaY: AuroraGlassTheme.navBarBlur,
          ),
          child: SafeArea(
            child: Container(
              height: 70,
              padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  _buildNavItem(
                    context,
                    ref,
                    icon: LucideIcons.house,
                    label: 'Ana Sayfa',
                    index: 0,
                    currentIndex: currentIndex,
                    route: '/home',
                  ),
                  _buildNavItem(
                    context,
                    ref,
                    icon: LucideIcons.briefcase,
                    label: 'Projeler',
                    index: 1,
                    currentIndex: currentIndex,
                    route: '/projects',
                  ),
                  _buildNavItem(
                    context,
                    ref,
                    icon: LucideIcons.target,
                    label: 'Akademi',
                    index: 2,
                    currentIndex: currentIndex,
                    route: '/learning',
                  ),
                  _buildNavItem(
                    context,
                    ref,
                    icon: LucideIcons.users,
                    label: 'Topluluk',
                    index: 3,
                    currentIndex: currentIndex,
                    route: '/community',
                  ),
                  _buildNavItem(
                    context,
                    ref,
                    icon: LucideIcons.user,
                    label: 'Profil',
                    index: 4,
                    currentIndex: currentIndex,
                    route: '/profile',
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildNavItem(
    BuildContext context,
    WidgetRef ref, {
    required IconData icon,
    required String label,
    required int index,
    required int currentIndex,
    required String route,
  }) {
    final isSelected = currentIndex == index;

    return Flexible(
      child: GestureDetector(
        onTap: () {
          HapticFeedback.lightImpact();
          ref.read(navigationIndexProvider.notifier).state = index;
          context.go(route);
        },
        behavior: HitTestBehavior.opaque,
        child: AnimatedContainer(
          duration: AuroraGlassTheme.interactionDuration,
          curve: AuroraGlassTheme.interactionCurve,
          padding: isSelected
              ? const EdgeInsets.symmetric(horizontal: 12, vertical: 8)
              : const EdgeInsets.symmetric(horizontal: 4, vertical: 8),
          decoration: BoxDecoration(
            color: isSelected ? PColors.primary : Colors.transparent,
            borderRadius: BorderRadius.circular(
              AuroraGlassTheme.activeTabBorderRadius,
            ),
            boxShadow: isSelected ? PShadows.glowPrimary() : null,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                icon,
                color: isSelected ? Colors.white : PColors.textDim,
                size: 20,
              ),
              const SizedBox(height: 2),
              Flexible(
                child: Text(
                  label,
                  style: GoogleFonts.inter(
                    color: isSelected ? Colors.white : PColors.textDim,
                    fontSize: 10,
                    fontWeight: isSelected
                        ? FontWeight.w600
                        : FontWeight.w500,
                  ),
                  textAlign: TextAlign.center,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
