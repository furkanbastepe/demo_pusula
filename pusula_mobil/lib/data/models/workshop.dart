import 'user_level.dart';

// ═══════════════════════════════════════════════════════════════════════════════════
// 📊 WORKSHOP MODEL
// ═══════════════════════════════════════════════════════════════════════════════════

class Workshop {
  final String id;
  final String title;
  final String instructorName;
  final UserLevel instructorLevel;
  final DateTime dateTime;
  final int duration;
  final String digemCenter;
  final List<String> skillsToGain;
  final String imageUrl;
  final int maxParticipants;
  final int currentParticipants;

  const Workshop({
    required this.id,
    required this.title,
    required this.instructorName,
    required this.instructorLevel,
    required this.dateTime,
    this.duration = 45,
    required this.digemCenter,
    required this.skillsToGain,
    required this.imageUrl,
    this.maxParticipants = 8,
    this.currentParticipants = 0,
  });

  bool get isAvailable => currentParticipants < maxParticipants;

  String get formattedDateTime {
    final days = ['Pazartesi', 'Salı', 'Çarşamba', 'Perşembe', 'Cuma', 'Cumartesi', 'Pazar'];
    return '${days[dateTime.weekday - 1]} ${dateTime.hour}:${dateTime.minute.toString().padLeft(2, '0')}';
  }
}
