import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'core/core.dart';
import 'widgets/common/aurora_background.dart';

// ═══════════════════════════════════════════════════════════════════════════════════
// 🎯 MAIN APPLICATION CLASS
// ═══════════════════════════════════════════════════════════════════════════════════

class PusulaApp extends ConsumerWidget {
  const PusulaApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final router = ref.watch(routerProvider);

    return MaterialApp.router(
      title: 'PUSULA - Türkiye\'nin Dijital Köprüsü',
      theme: PTheme.dark,
      routerConfig: router,
      debugShowCheckedModeBanner: false,
      builder: (context, child) {
        // Global Aurora Background - persists across all screens
        return Stack(
          children: [
            const RepaintBoundary(
              child: AuroraBackground(),
            ),
            child ?? const SizedBox(),
          ],
        );
      },
      localizationsDelegates: const [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: const [Locale('tr', 'TR')],
    );
  }
}
