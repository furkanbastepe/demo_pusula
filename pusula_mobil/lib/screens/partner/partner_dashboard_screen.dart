import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import '../../core/core.dart';
import '../../widgets/common/aurora_background.dart';
import '../../widgets/common/glass_morphic_card.dart';

class PartnerDashboardScreen extends StatelessWidget {
  const PartnerDashboardScreen({super.key});

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
                              'İş Ortağı Paneli',
                              style: GoogleFonts.poppins(
                                fontSize: 24,
                                fontWeight: FontWeight.bold,
                                color: PColors.text,
                              ),
                            ),
                            Text(
                              'Proje yayınla, genç yetenekler bul',
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

                  // Stats Cards
                  Row(
                    children: [
                      Expanded(
                        child: _buildStatsCard(
                          'Aktif Projeler',
                          '12',
                          LucideIcons.briefcase,
                          PColors.primary,
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: _buildStatsCard(
                          'Başvurular',
                          '89',
                          LucideIcons.users,
                          PColors.success,
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: _buildStatsCard(
                          'Tamamlanan',
                          '34',
                          LucideIcons.circleCheck,
                          PColors.accent,
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 24),

                  // Create Project Button
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton.icon(
                      onPressed: () => _showCreateProjectDialog(context),
                      icon: const Icon(LucideIcons.plus),
                      label: Text(
                        'Yeni Proje Oluştur',
                        style: GoogleFonts.inter(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: PColors.primary,
                        foregroundColor: Colors.white,
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                    ),
                  ),

                  const SizedBox(height: 24),

                  // Active Projects List
                  Text(
                    'Aktif Projelerim',
                    style: GoogleFonts.poppins(
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                      color: PColors.text,
                    ),
                  ),
                  const SizedBox(height: 16),

                  // Project Cards
                  ..._getPartnerProjects().map(
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
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: color,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            title,
            style: GoogleFonts.inter(fontSize: 12, color: PColors.textDim),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  List<Map<String, String>> _getPartnerProjects() {
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
