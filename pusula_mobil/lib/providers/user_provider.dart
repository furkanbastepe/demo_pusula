import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../data/data.dart';

// ═══════════════════════════════════════════════════════════════════════════════════
// 🔄 USER STATE PROVIDERS
// ═══════════════════════════════════════════════════════════════════════════════════

final userProvider = StateProvider<AppUser?>((ref) => MockData.currentUser);

final selectedCityProvider = StateProvider<String?>((ref) => null);

final selectedSkillsProvider = StateProvider<List<String>>((ref) => []);
