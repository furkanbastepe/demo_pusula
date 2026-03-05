// ═══════════════════════════════════════════════════════════════════════════════════
// 📋 ACTIVITY ITEM MODEL
// ═══════════════════════════════════════════════════════════════════════════════════

enum ActivityType {
  youthRegistration,
  workshopCompleted,
  levelProgression,
  newApplication,
  applicationAccepted,
  projectCompleted,
  partnerJoined,
}

class ActivityItem {
  final String id;
  final ActivityType type;
  final String title;
  final String description;
  final DateTime timestamp;
  final Map<String, dynamic> metadata;

  const ActivityItem({
    required this.id,
    required this.type,
    required this.title,
    required this.description,
    required this.timestamp,
    required this.metadata,
  });

  factory ActivityItem.fromJson(Map<String, dynamic> json) {
    return ActivityItem(
      id: json['id'] as String,
      type: ActivityType.values.firstWhere(
        (e) => e.name == json['type'],
        orElse: () => ActivityType.youthRegistration,
      ),
      title: json['title'] as String,
      description: json['description'] as String,
      timestamp: json['timestamp'] != null
          ? DateTime.parse(json['timestamp'] as String)
          : DateTime.now(),
      metadata: json['metadata'] as Map<String, dynamic>? ?? {},
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'type': type.name,
      'title': title,
      'description': description,
      'timestamp': timestamp.toIso8601String(),
      'metadata': metadata,
    };
  }

  ActivityItem copyWith({
    String? id,
    ActivityType? type,
    String? title,
    String? description,
    DateTime? timestamp,
    Map<String, dynamic>? metadata,
  }) {
    return ActivityItem(
      id: id ?? this.id,
      type: type ?? this.type,
      title: title ?? this.title,
      description: description ?? this.description,
      timestamp: timestamp ?? this.timestamp,
      metadata: metadata ?? this.metadata,
    );
  }

  String get relativeTime {
    final now = DateTime.now();
    final difference = now.difference(timestamp);

    if (difference.inSeconds < 60) {
      return '${difference.inSeconds} saniye önce';
    } else if (difference.inMinutes < 60) {
      return '${difference.inMinutes} dakika önce';
    } else if (difference.inHours < 24) {
      return '${difference.inHours} saat önce';
    } else if (difference.inDays < 7) {
      return '${difference.inDays} gün önce';
    } else if (difference.inDays < 30) {
      return '${(difference.inDays / 7).floor()} hafta önce';
    } else if (difference.inDays < 365) {
      return '${(difference.inDays / 30).floor()} ay önce';
    } else {
      return '${(difference.inDays / 365).floor()} yıl önce';
    }
  }

  String get typeLabel {
    switch (type) {
      case ActivityType.youthRegistration:
        return 'Genç Kaydı';
      case ActivityType.workshopCompleted:
        return 'Atölye Tamamlandı';
      case ActivityType.levelProgression:
        return 'Seviye Yükseltme';
      case ActivityType.newApplication:
        return 'Yeni Başvuru';
      case ActivityType.applicationAccepted:
        return 'Başvuru Kabul';
      case ActivityType.projectCompleted:
        return 'Proje Tamamlandı';
      case ActivityType.partnerJoined:
        return 'Yeni Ortak';
    }
  }
}
