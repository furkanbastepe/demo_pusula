import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import '../../core/core.dart';
import '../../widgets/common/aurora_background.dart';
import '../../widgets/common/glass_morphic_card.dart';

class DigemDashboardScreen extends StatelessWidget {
  const DigemDashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          AuroraBackground(),
          SafeArea(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Header
                  Row(
                    children: [
                      IconButton(
                        onPressed: () => Navigator.pop(context),
                        icon: const Icon(
                          LucideIcons.arrowLeft,
                          color: PColors.text,
                        ),
                      ),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'DİGEM Yönetim Paneli',
                              style: GoogleFonts.poppins(
                                fontSize: 24,
                                fontWeight: FontWeight.bold,
                                color: PColors.text,
                              ),
                            ),
                            Text(
                              'Gençleri yönet, etkinlik düzenle',
                              style: GoogleFonts.inter(
                                fontSize: 14,
                                color: PColors.textDim,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 24),

                  // DİGEM Stats
                  Row(
                    children: [
                      Expanded(
                        child: _buildDigemStatsCard(
                          'Kayıtlı Genç',
                          '1,247',
                          LucideIcons.users,
                          PColors.primary,
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: _buildDigemStatsCard(
                          'Aktif Atölye',
                          '18',
                          LucideIcons.graduationCap,
                          PColors.accent,
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: _buildDigemStatsCard(
                          'Bu Ay Mezun',
                          '89',
                          LucideIcons.award,
                          PColors.success,
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 24),

                  // Quick Actions
                  Row(
                    children: [
                      Expanded(
                        child: ElevatedButton.icon(
                          onPressed: () => _showCreateEventDialog(context),
                          icon: const Icon(LucideIcons.plus),
                          label: const Text('Etkinlik Oluştur'),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: PColors.accent,
                            foregroundColor: Colors.white,
                            padding: const EdgeInsets.symmetric(vertical: 12),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: OutlinedButton.icon(
                          onPressed: () {},
                          icon: const Icon(LucideIcons.userPlus),
                          label: const Text('Genç Kaydet'),
                          style: OutlinedButton.styleFrom(
                            foregroundColor: PColors.primary,
                            side: const BorderSide(color: PColors.primary),
                            padding: const EdgeInsets.symmetric(vertical: 12),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 24),

                  // Recent Activities
                  Text(
                    'Son Aktiviteler',
                    style: GoogleFonts.poppins(
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                      color: PColors.text,
                    ),
                  ),
                  const SizedBox(height: 16),

                  ..._getRecentActivities().map(
                    (activity) => Container(
                      margin: const EdgeInsets.only(bottom: 12),
                      child: GlassMorphicCard(
                        padding: const EdgeInsets.all(16),
                        child: Row(
                          children: [
                            Container(
                              padding: const EdgeInsets.all(8),
                              decoration: BoxDecoration(
                                color: (activity['color'] as Color).withValues(
                                  alpha: 0.15,
                                ),
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Icon(
                                activity['icon'] as IconData,
                                color: activity['color'] as Color,
                                size: 20,
                              ),
                            ),
                            const SizedBox(width: 16),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    activity['title']!,
                                    style: GoogleFonts.poppins(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w600,
                                      color: PColors.text,
                                    ),
                                  ),
                                  Text(
                                    activity['description']!,
                                    style: GoogleFonts.inter(
                                      fontSize: 12,
                                      color: PColors.textDim,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Text(
                              activity['time']!,
                              style: GoogleFonts.inter(
                                fontSize: 11,
                                color: PColors.textDim,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),

                  const SizedBox(height: 24),

                  // Upcoming Workshops
                  Text(
                    'Yaklaşan Atölyeler',
                    style: GoogleFonts.poppins(
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                      color: PColors.text,
                    ),
                  ),
                  const SizedBox(height: 16),

                  ..._getUpcomingWorkshops().map(
                    (workshop) => Container(
                      margin: const EdgeInsets.only(bottom: 12),
                      child: GlassMorphicCard(
                        child: Row(
                          children: [
                            Container(
                              padding: const EdgeInsets.all(12),
                              decoration: BoxDecoration(
                                gradient: LinearGradient(
                                  colors: [
                                    PColors.accent,
                                    PColors.accent.withValues(alpha: 0.7),
                                  ],
                                ),
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: const Icon(
                                LucideIcons.graduationCap,
                                color: Colors.white,
                                size: 20,
                              ),
                            ),
                            const SizedBox(width: 16),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    workshop['title']!,
                                    style: GoogleFonts.poppins(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w600,
                                      color: PColors.text,
                                    ),
                                  ),
                                  Text(
                                    '${workshop['date']} • ${workshop['participants']} katılımcı',
                                    style: GoogleFonts.inter(
                                      fontSize: 12,
                                      color: PColors.textDim,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            TextButton(
                              onPressed: () {},
                              child: const Text('Yönet'),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDigemStatsCard(
    String title,
    String value,
    IconData icon,
    Color color,
  ) {
    return GlassMorphicCard(
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: color.withValues(alpha: 0.15),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(icon, color: color, size: 24),
          ),
          const SizedBox(height: 12),
          Text(
            value,
            style: GoogleFonts.poppins(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: color,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            title,
            style: GoogleFonts.inter(fontSize: 11, color: PColors.textDim),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  List<Map<String, dynamic>> _getRecentActivities() {
    return [
      {
        'title': 'Yeni Genç Kaydı',
        'description': 'Ahmet Yılmaz DİGEM\'e katıldı',
        'time': '2 dk önce',
        'icon': LucideIcons.userPlus,
        'color': PColors.success,
      },
      {
        'title': 'Atölye Tamamlandı',
        'description': 'Python Temelleri atölyesi başarıyla bitti',
        'time': '1 saat önce',
        'icon': LucideIcons.circleCheck,
        'color': PColors.primary,
      },
      {
        'title': 'Seviye Yükseltme',
        'description': 'Zeynep Kaya Kalfa seviyesine yükseldi',
        'time': '3 saat önce',
        'icon': LucideIcons.trendingUp,
        'color': PColors.accent,
      },
    ];
  }

  List<Map<String, String>> _getUpcomingWorkshops() {
    return [
      {
        'title': 'React ile Web Geliştirme',
        'date': '25 Eylül, 14:00',
        'participants': '15',
      },
      {
        'title': 'Dijital Pazarlama Temelleri',
        'date': '26 Eylül, 10:00',
        'participants': '12',
      },
      {
        'title': 'UI/UX Tasarım Prensipleri',
        'date': '27 Eylül, 16:00',
        'participants': '18',
      },
    ];
  }

  void _showCreateEventDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => Dialog(
        backgroundColor: Colors.transparent,
        child: GlassMorphicCard(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                'Yeni Etkinlik Oluştur 🎯',
                style: GoogleFonts.poppins(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: PColors.text,
                ),
              ),
              const SizedBox(height: 16),
              TextField(
                decoration: const InputDecoration(
                  labelText: 'Etkinlik Adı',
                  hintText: 'Örn: Python Workshop',
                ),
              ),
              const SizedBox(height: 16),
              TextField(
                decoration: const InputDecoration(
                  labelText: 'Eğitmen',
                  hintText: 'Eğitmen adı',
                ),
              ),
              const SizedBox(height: 16),
              TextField(
                decoration: const InputDecoration(
                  labelText: 'Kapasite',
                  hintText: 'Maksimum katılımcı sayısı',
                ),
                keyboardType: TextInputType.number,
              ),
              const SizedBox(height: 20),
              Row(
                children: [
                  Expanded(
                    child: OutlinedButton(
                      onPressed: () => Navigator.pop(context),
                      child: const Text('İptal'),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.pop(context);
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text(
                              'Etkinlik başarıyla oluşturuldu!',
                              style: GoogleFonts.inter(color: Colors.white),
                            ),
                            backgroundColor: PColors.success,
                            behavior: SnackBarBehavior.floating,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                          ),
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: PColors.accent,
                      ),
                      child: const Text('Oluştur'),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
