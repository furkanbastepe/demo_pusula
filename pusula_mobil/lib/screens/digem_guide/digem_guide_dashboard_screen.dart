import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import '../../core/core.dart';
import '../../widgets/common/aurora_background.dart';
import '../../widgets/common/glass_morphic_card.dart';

class DigemGuideDashboardScreen extends StatelessWidget {
  const DigemGuideDashboardScreen({super.key});

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
                        onPressed: () => context.go('/role-selection'),
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
                              'DİGEM REHBERİ',
                              style: GoogleFonts.poppins(
                                fontSize: 24,
                                fontWeight: FontWeight.bold,
                                color: PColors.text,
                              ),
                            ),
                            Text(
                              'Gençleri yönet, proje yayınla, ortaklıkları koordine et',
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

                  // Statistics Row (6 cards in 2 rows)
                  Row(
                    children: [
                      Expanded(
                        child: _buildStatsCard(
                          'Kayıtlı Genç',
                          '1,247',
                          LucideIcons.users,
                          PColors.primary,
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: _buildStatsCard(
                          'Aktif Atölye',
                          '18',
                          LucideIcons.graduationCap,
                          PColors.accent,
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: _buildStatsCard(
                          'Aktif Proje',
                          '12',
                          LucideIcons.briefcase,
                          PColors.info,
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 12),

                  Row(
                    children: [
                      Expanded(
                        child: _buildStatsCard(
                          'Başvurular',
                          '89',
                          LucideIcons.fileText,
                          PColors.success,
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: _buildStatsCard(
                          'Tamamlanan',
                          '34',
                          LucideIcons.circleCheck,
                          PColors.success,
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: _buildStatsCard(
                          'Ortaklar',
                          '8',
                          LucideIcons.building2,
                          PColors.info,
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 24),

                  // Quick Actions
                  Row(
                    children: [
                      Expanded(
                        child: _buildQuickActionButton(
                          context,
                          'Atölye Oluştur',
                          LucideIcons.plus,
                          PColors.accent,
                          () => _showCreateWorkshopDialog(context),
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: _buildQuickActionButton(
                          context,
                          'Proje Oluştur',
                          LucideIcons.briefcase,
                          PColors.primary,
                          () => _showCreateProjectDialog(context),
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 12),

                  Row(
                    children: [
                      Expanded(
                        child: _buildQuickActionButton(
                          context,
                          'Genç Kaydet',
                          LucideIcons.userPlus,
                          PColors.success,
                          () {},
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: _buildQuickActionButton(
                          context,
                          'Raporlar',
                          LucideIcons.fileText,
                          PColors.info,
                          () {},
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

                  const SizedBox(height: 24),

                  // Active Projects
                  Text(
                    'Aktif Projeler',
                    style: GoogleFonts.poppins(
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                      color: PColors.text,
                    ),
                  ),
                  const SizedBox(height: 16),

                  ..._getActiveProjects().map(
                    (project) => Container(
                      margin: const EdgeInsets.only(bottom: 16),
                      child: GlassMorphicCard(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Container(
                                  padding: const EdgeInsets.all(12),
                                  decoration: BoxDecoration(
                                    color: PColors.info.withValues(alpha: 0.15),
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                  child: const Icon(
                                    LucideIcons.building2,
                                    color: PColors.info,
                                    size: 24,
                                  ),
                                ),
                                const SizedBox(width: 16),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        project['title']!,
                                        style: GoogleFonts.poppins(
                                          fontSize: 16,
                                          fontWeight: FontWeight.w600,
                                          color: PColors.text,
                                        ),
                                      ),
                                      Text(
                                        project['description']!,
                                        style: GoogleFonts.inter(
                                          fontSize: 12,
                                          color: PColors.textDim,
                                        ),
                                        maxLines: 2,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    ],
                                  ),
                                ),
                                Container(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 8,
                                    vertical: 4,
                                  ),
                                  decoration: BoxDecoration(
                                    color: PColors.success.withValues(alpha: 0.15),
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  child: Text(
                                    '${project['applicants']} başvuru',
                                    style: GoogleFonts.inter(
                                      fontSize: 11,
                                      color: PColors.success,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 16),
                            Row(
                              children: [
                                Expanded(
                                  child: OutlinedButton(
                                    onPressed: () {},
                                    style: OutlinedButton.styleFrom(
                                      foregroundColor: PColors.textDim,
                                      side: const BorderSide(
                                        color: PColors.border,
                                      ),
                                    ),
                                    child: const Text('Düzenle'),
                                  ),
                                ),
                                const SizedBox(width: 12),
                                Expanded(
                                  child: ElevatedButton(
                                    onPressed: () {},
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: PColors.info,
                                    ),
                                    child: const Text('Başvuruları Gör'),
                                  ),
                                ),
                              ],
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

  Widget _buildStatsCard(
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

  Widget _buildQuickActionButton(
    BuildContext context,
    String label,
    IconData icon,
    Color color,
    VoidCallback onTap,
  ) {
    return GestureDetector(
      onTap: onTap,
      child: GlassMorphicCard(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, color: color, size: 20),
            const SizedBox(width: 8),
            Text(
              label,
              style: GoogleFonts.inter(
                fontSize: 13,
                fontWeight: FontWeight.w600,
                color: PColors.text,
              ),
            ),
          ],
        ),
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
      {
        'title': 'Yeni Başvuru',
        'description': 'Mehmet Demir E-ticaret projesine başvurdu',
        'time': '5 saat önce',
        'icon': LucideIcons.fileText,
        'color': PColors.info,
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

  List<Map<String, String>> _getActiveProjects() {
    return [
      {
        'title': 'E-ticaret Sitesi Geliştirme',
        'description': 'Modern, kullanıcı dostu e-ticaret platformu',
        'applicants': '15',
      },
      {
        'title': 'Mobil Uygulama Tasarımı',
        'description': 'iOS ve Android için mobil uygulama UI/UX',
        'applicants': '23',
      },
      {
        'title': 'Dijital Pazarlama Kampanyası',
        'description': 'Sosyal medya ve SEO odaklı kampanya',
        'applicants': '8',
      },
    ];
  }

  void _showCreateWorkshopDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => Dialog(
        backgroundColor: Colors.transparent,
        child: GlassMorphicCard(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                'Yeni Atölye Oluştur 🎯',
                style: GoogleFonts.poppins(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: PColors.text,
                ),
              ),
              const SizedBox(height: 16),
              TextField(
                decoration: const InputDecoration(
                  labelText: 'Atölye Adı',
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
                              'Atölye başarıyla oluşturuldu!',
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

  void _showCreateProjectDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => Dialog(
        backgroundColor: Colors.transparent,
        child: GlassMorphicCard(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                'Yeni Proje Oluştur 🚀',
                style: GoogleFonts.poppins(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: PColors.text,
                ),
              ),
              const SizedBox(height: 16),
              TextField(
                decoration: const InputDecoration(
                  labelText: 'Proje Başlığı',
                  hintText: 'Örn: Web Sitesi Geliştirme',
                ),
              ),
              const SizedBox(height: 16),
              TextField(
                maxLines: 3,
                decoration: const InputDecoration(
                  labelText: 'Proje Açıklaması',
                  hintText: 'Projenin detaylarını yazın...',
                ),
              ),
              const SizedBox(height: 16),
              TextField(
                decoration: const InputDecoration(
                  labelText: 'Gerekli Beceriler',
                  hintText: 'Örn: React, Node.js, MongoDB',
                ),
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
                              'Proje başarıyla oluşturuldu!',
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
