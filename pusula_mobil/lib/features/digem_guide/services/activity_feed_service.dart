import '../models/activity_item.dart';

class ActivityFeedService {
  static final List<ActivityItem> _activities = _mockActivityData();

  Future<List<ActivityItem>> getRecentActivities({int limit = 10}) async {
    await Future.delayed(const Duration(milliseconds: 300));
    final sorted = List<ActivityItem>.from(_activities)
      ..sort((a, b) => b.timestamp.compareTo(a.timestamp));
    return sorted.take(limit).toList();
  }

  static List<ActivityItem> _mockActivityData() {
    final now = DateTime.now();
    return [
      ActivityItem(
        id: 'act_1',
        type: ActivityType.youthRegistration,
        title: 'Yeni Genç Kaydı',
        description: 'Ahmet Yılmaz DİGEM\'e katıldı',
        timestamp: now.subtract(const Duration(minutes: 2)),
        metadata: {'youthId': 'youth_1'},
      ),
      ActivityItem(
        id: 'act_2',
        type: ActivityType.workshopCompleted,
        title: 'Atölye Tamamlandı',
        description: 'Python Temelleri atölyesi başarıyla tamamlandı',
        timestamp: now.subtract(const Duration(hours: 1)),
        metadata: {'workshopId': 'workshop_2'},
      ),
      ActivityItem(
        id: 'act_3',
        type: ActivityType.levelProgression,
        title: 'Seviye Yükseltme',
        description: 'Zeynep Kaya Kalfa seviyesine yükseldi',
        timestamp: now.subtract(const Duration(hours: 3)),
        metadata: {'youthId': 'youth_2', 'newLevel': 'kalfa'},
      ),
    ];
  }
}
