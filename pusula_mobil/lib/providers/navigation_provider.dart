import 'package:flutter_riverpod/flutter_riverpod.dart';

// ═══════════════════════════════════════════════════════════════════════════════════
// 🔄 NAVIGATION STATE PROVIDER
// ═══════════════════════════════════════════════════════════════════════════════════

final navigationIndexProvider = StateProvider<int>((ref) => 0);
