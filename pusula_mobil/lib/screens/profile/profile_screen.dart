import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import 'package:flutter_animate/flutter_animate.dart';

import '../../core/core.dart';
import '../../data/data.dart';
import '../../providers/providers.dart';
import '../../widgets/widgets.dart';
import '../home/main_layout.dart';

// ═══════════════════════════════════════════════════════════════════════════════════
// 👤 PROFILE SCREEN - FULL IMPLEMENTATION FROM main_old.dart
// ═══════════════════════════════════════════════════════════════════════════════════

class ProfileScreen extends ConsumerWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final user = ref.watch(userProvider) ?? MockData.currentUser;

    return MainLayout(
      child: CustomScrollView(
        slivers: [
          SliverAppBar(
            expandedHeight: 200,
            floating: false,
            pinned: true,
            backgroundColor: Colors.transparent,
            flexibleSpace: FlexibleSpaceBar(
              background: Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      user.levelColor.withValues(alpha: 0.3),
                      Colors.transparent,
                    ],
                  ),
                ),
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const SizedBox(height: 40),
                      Container(
                        width: 100,
                        height: 100,
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            colors: [
                              user.levelColor,
                              user.levelColor.withValues(alpha: 0.7),
                            ],
                          ),
                          borderRadius: BorderRadius.circular(50),
                          boxShadow: PShadows.glow(user.levelColor),
                        ),
                        child: user.avatar != null
                            ? ClipRRect(
                                borderRadius: BorderRadius.circular(50),
                                child: Image.asset(
                                  user.avatar!,
                                  fit: BoxFit.cover,
                                ),
                              )
                            : _buildAvatarPlaceholder(user),
                      ).animate().scale().fadeIn(),
                      const SizedBox(height: 16),
                      Text(
                        user.name,
                        style: GoogleFonts.poppins(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: PColors.text,
                        ),
                      ).animate().fadeIn(delay: 200.ms),
                      const SizedBox(height: 4),
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 12,
                          vertical: 6,
                        ),
                        decoration: BoxDecoration(
                          color: user.levelColor.withValues(alpha: 0.15),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Text(
                          user.levelName,
                          style: GoogleFonts.inter(
                            fontSize: 11,
                            color: user.levelColor,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ).animate().fadeIn(delay: 300.ms),
                    ],
                  ),
                ),
              ),
            ),
            actions: [
              Container(
                margin: const EdgeInsets.only(right: 16),
                decoration: BoxDecoration(
                  color: PColors.surface.withValues(alpha: 0.8),
                  borderRadius: BorderRadius.circular(25),
                ),
                child: IconButton(
                  icon: const Icon(LucideIcons.settings, color: PColors.text),
                  onPressed: () => _showSettingsDialog(context),
                ),
              ),
            ],
          ),

          SliverPadding(
            padding: const EdgeInsets.all(16),
            sliver: SliverList(
              delegate: SliverChildListDelegate([
                // Stats Cards
                _buildStatsCards(user).animate().fadeIn().slideY(begin: 0.3),

                const SizedBox(height: 20),

                // Level Progress
                _buildLevelProgress(
                  user,
                ).animate(delay: 100.ms).fadeIn().slideY(begin: 0.3),

                const SizedBox(height: 20),

                // Skills Section
                _buildSkillsSection(
                  user,
                ).animate(delay: 200.ms).fadeIn().slideY(begin: 0.3),

                const SizedBox(height: 20),

                // Recent Activity
                _buildRecentActivity(
                  user,
                ).animate(delay: 300.ms).fadeIn().slideY(begin: 0.3),

                const SizedBox(height: 20),

                // Quick Actions
                _buildQuickActions(
                  context,
                ).animate(delay: 400.ms).fadeIn().slideY(begin: 0.3),

                const SizedBox(height: 100),
              ]),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAvatarPlaceholder(AppUser user) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [user.levelColor, user.levelColor.withValues(alpha: 0.7)],
        ),
        borderRadius: BorderRadius.circular(50),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(25),
        child: Image.asset(
          user.avatar!,
          fit: BoxFit.cover,
          width: 50,
          height: 50,
        ),
      ),
    );
  }

  Widget _buildStatsCards(AppUser user) {
    return Row(
      children: [
        Expanded(
          child: _buildStatCard(
            'Tamamlanan',
            '${user.completedProjects}',
            'Proje',
            LucideIcons.circleCheck,
            PColors.success,
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: _buildStatCard(
            'Gönüllülük',
            '${user.volunteerHours}',
            'Saat',
            LucideIcons.heart,
            PColors.warning,
          ),
        ),
      ],
    );
  }

  Widget _buildStatCard(
    String title,
    String value,
    String subtitle,
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
              borderRadius: BorderRadius.circular(20),
            ),
            child: Icon(icon, color: color, size: 24),
          ),
          const SizedBox(height: 12),
          Text(
            value,
            style: GoogleFonts.poppins(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: color,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            title,
            style: GoogleFonts.inter(
              fontSize: 12,
              color: PColors.text,
              fontWeight: FontWeight.w600,
            ),
          ),
          if (subtitle.isNotEmpty && !subtitle.startsWith('⭐')) ...[
            const SizedBox(height: 2),
            Text(
              subtitle,
              style: GoogleFonts.inter(fontSize: 10, color: PColors.textDim),
              textAlign: TextAlign.center,
            ),
          ] else if (subtitle.startsWith('⭐')) ...[
            const SizedBox(height: 2),
            Text(subtitle, style: const TextStyle(fontSize: 8)),
          ],
        ],
      ),
    );
  }

  Widget _buildLevelProgress(AppUser user) {
    return GlassMorphicCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Seviye İlerlemen 🎯',
                style: GoogleFonts.poppins(
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                  color: PColors.text,
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 6,
                ),
                decoration: BoxDecoration(
                  color: user.levelColor.withValues(alpha: 0.15),
                  borderRadius: BorderRadius.circular(15),
                ),
                child: Text(
                  user.levelName,
                  style: GoogleFonts.inter(
                    fontSize: 12,
                    color: user.levelColor,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),

          const SizedBox(height: 16),

          // Progress Bar
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: PColors.surfaceHi.withValues(alpha: 0.3),
              borderRadius: BorderRadius.circular(16),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Seviye İlerlemen',
                      style: GoogleFonts.poppins(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: PColors.text,
                      ),
                    ),
                    Text(
                      '${user.xp} / ${user.xpToNextLevel} XP',
                      style: GoogleFonts.inter(
                        fontSize: 12,
                        color: PColors.textDim,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                LinearProgressIndicator(
                  value: user.progressToNextLevel,
                  backgroundColor: PColors.border,
                  valueColor: AlwaysStoppedAnimation<Color>(user.levelColor),
                  minHeight: 8,
                ).animate().scaleX(duration: 800.ms),
                const SizedBox(height: 8),
                Text(
                  'Bir sonraki seviyeye ${(user.xpToNextLevel - user.xp).clamp(0, double.infinity)} XP kaldı',
                  style: GoogleFonts.inter(
                    fontSize: 12,
                    color: PColors.textDim,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSkillsSection(AppUser user) {
    return GlassMorphicCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Beceri Alanım 💡',
            style: GoogleFonts.poppins(
              fontSize: 18,
              fontWeight: FontWeight.w600,
              color: PColors.text,
            ),
          ),
          const SizedBox(height: 16),

          // Main skill path
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  PColors.primary.withValues(alpha: 0.1),
                  PColors.primary.withValues(alpha: 0.05),
                ],
              ),
              borderRadius: BorderRadius.circular(16),
              border: Border.all(color: PColors.primary.withValues(alpha: 0.3)),
            ),
            child: Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: PColors.primary.withValues(alpha: 0.15),
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: Icon(
                    PusulaCore.skillPaths[user.skillPath] ?? LucideIcons.user,
                    color: PColors.primary,
                    size: 24,
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Ana Yol',
                        style: GoogleFonts.inter(
                          fontSize: 12,
                          color: PColors.textDim,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      Text(
                        user.skillPath,
                        style: GoogleFonts.poppins(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          color: PColors.primary,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(height: 16),

          // Skills
          if (user.skills.isNotEmpty) ...[
            Text(
              'Sahip Olduğum Beceriler:',
              style: GoogleFonts.poppins(
                fontSize: 14,
                fontWeight: FontWeight.w600,
                color: PColors.text,
              ),
            ),
            const SizedBox(height: 12),
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: user.skills
                  .map(
                    (skill) => Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 8,
                      ),
                      decoration: BoxDecoration(
                        color: PColors.accent.withValues(alpha: 0.15),
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(
                          color: PColors.accent.withValues(alpha: 0.3),
                        ),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const Icon(
                            LucideIcons.circleCheck,
                            color: PColors.accent,
                            size: 14,
                          ),
                          const SizedBox(width: 4),
                          Text(
                            skill,
                            style: GoogleFonts.inter(
                              fontSize: 12,
                              color: PColors.accent,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                    ),
                  )
                  .toList(),
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildRecentActivity(AppUser user) {
    final activities = [
      {
        'title': 'İBB Trafik Projesi Başvurusu Onaylandı',
        'time': '2 gün önce',
        'icon': LucideIcons.circleCheck,
        'color': PColors.success,
      },
      {
        'title': 'Veri Analizi Atölyesine Katıldı',
        'time': '5 gün önce',
        'icon': LucideIcons.graduationCap,
        'color': PColors.accent,
      },
      {
        'title': 'Yaşlılar İçin Gönüllülük Tamamlandı',
        'time': '1 hafta önce',
        'icon': LucideIcons.heart,
        'color': PColors.warning,
      },
      {
        'title': 'Kalfa Seviyesine Yükseldi',
        'time': '2 hafta önce',
        'icon': LucideIcons.trendingUp,
        'color': user.levelColor,
      },
    ];

    return GlassMorphicCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Son Aktiviteler 📋',
            style: GoogleFonts.poppins(
              fontSize: 18,
              fontWeight: FontWeight.w600,
              color: PColors.text,
            ),
          ),
          const SizedBox(height: 16),
          ...activities.map(
            (activity) => Container(
              margin: const EdgeInsets.only(bottom: 12),
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: PColors.surfaceHi.withValues(alpha: 0.3),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: (activity['color'] as Color).withValues(alpha: 0.15),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Icon(
                      activity['icon'] as IconData,
                      color: activity['color'] as Color,
                      size: 16,
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          activity['title'] as String,
                          style: GoogleFonts.poppins(
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                            color: PColors.text,
                          ),
                        ),
                        Text(
                          activity['time'] as String,
                          style: GoogleFonts.inter(
                            fontSize: 12,
                            color: PColors.textDim,
                          ),
                        ),
                      ],
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

  Widget _buildQuickActions(BuildContext context) {
    final actions = [
      {
        'title': 'Profili Düzenle',
        'icon': LucideIcons.pencil,
        'color': PColors.primary,
        'action': 'edit_profile',
      },
      {
        'title': 'Portföy',
        'icon': LucideIcons.award,
        'color': PColors.accent,
        'action': 'certificates',
      },
      {
        'title': 'Bildirimler',
        'icon': LucideIcons.bell,
        'color': PColors.info,
        'action': 'notifications',
      },
      {
        'title': 'Yardım',
        'icon': LucideIcons.lifeBuoy,
        'color': PColors.textDim,
        'action': 'help',
      },
    ];

    return GlassMorphicCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Hızlı İşlemler ⚡',
            style: GoogleFonts.poppins(
              fontSize: 18,
              fontWeight: FontWeight.w600,
              color: PColors.text,
            ),
          ),
          const SizedBox(height: 16),
          GridView.count(
            crossAxisCount: 2,
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            crossAxisSpacing: 12,
            mainAxisSpacing: 12,
            childAspectRatio: 2.5,
            children: actions
                .map(
                  (action) => GestureDetector(
                    onTap: () =>
                        _handleQuickAction(context, action['action'] as String),
                    child: Container(
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: (action['color'] as Color).withValues(alpha: 0.15),
                        borderRadius: BorderRadius.circular(16),
                        border: Border.all(
                          color: (action['color'] as Color).withValues(alpha: 0.3),
                        ),
                      ),
                      child: Row(
                        children: [
                          Icon(
                            action['icon'] as IconData,
                            color: action['color'] as Color,
                            size: 20,
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: Text(
                              action['title'] as String,
                              style: GoogleFonts.inter(
                                fontSize: 12,
                                color: PColors.text,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                )
                .toList(),
          ),
        ],
      ),
    );
  }

  void _showSettingsDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => Dialog(
        backgroundColor: Colors.transparent,
        child: GlassMorphicCard(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                'Ayarlar ⚙️',
                style: GoogleFonts.poppins(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: PColors.text,
                ),
              ),
              const SizedBox(height: 16),
              _buildSettingItem('Bildirimler', LucideIcons.bell, true),
              _buildSettingItem('Dark Mode', LucideIcons.moon, true),
              _buildSettingItem('Konum Paylaş', LucideIcons.mapPin, false),
              const SizedBox(height: 16),
              Row(
                children: [
                  Expanded(
                    child: OutlinedButton(
                      onPressed: () => Navigator.pop(context),
                      style: OutlinedButton.styleFrom(
                        foregroundColor: PColors.textDim,
                        side: const BorderSide(color: PColors.border),
                      ),
                      child: const Text('İptal'),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () => Navigator.pop(context),
                      child: const Text('Kaydet'),
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

  Widget _buildSettingItem(String title, IconData icon, bool value) {
    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      child: Row(
        children: [
          Icon(icon, color: PColors.textDim, size: 20),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              title,
              style: GoogleFonts.inter(fontSize: 14, color: PColors.text),
            ),
          ),
          Switch(
            value: value,
            onChanged: (val) {},
            activeThumbColor: PColors.primary,
          ),
        ],
      ),
    );
  }

  void _handleQuickAction(BuildContext context, String action) {
    String message;
    switch (action) {
      case 'edit_profile':
        message = 'Profil düzenleme özelliği yakında aktif olacak!';
        break;
      case 'certificates':
        message =
            'Sertifikalarınız henüz yok. Projeleri tamamlayarak sertifika kazanın!';
        break;
      case 'notifications':
        message = 'Bildirim ayarları geliştiriliyor.';
        break;
      case 'help':
        message = 'Yardım için support@pusula.com adresine yazabilirsiniz.';
        break;
      default:
        message = 'Bu özellik yakında aktif olacak!';
    }

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message, style: GoogleFonts.inter(color: Colors.white)),
        backgroundColor: PColors.info,
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        duration: const Duration(seconds: 3),
      ),
    );
  }
}
