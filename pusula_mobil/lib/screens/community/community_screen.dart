import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
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
// 🌐 COMMUNITY SCREEN - FULL IMPLEMENTATION FROM main_old.dart
// ═══════════════════════════════════════════════════════════════════════════════════

class CommunityScreen extends ConsumerWidget {
  const CommunityScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final user = ref.watch(userProvider) ?? MockData.currentUser;

    return MainLayout(
      child: DefaultTabController(
        length: 3,
        child: Column(
          children: [
            // Custom App Bar
            Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    PColors.background.withValues(alpha: 0.95),
                    PColors.background.withValues(alpha: 0.8),
                  ],
                ),
              ),
              child: SafeArea(
                child: Column(
                  children: [
                    // Title
                    Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 12,
                      ),
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          'Topluluk',
                          style: GoogleFonts.poppins(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                            color: PColors.text,
                          ),
                        ),
                      ),
                    ),

                    // Tab Bar
                    Container(
                      margin: const EdgeInsets.symmetric(horizontal: 16),
                      height: 50,
                      child: Container(
                        decoration: BoxDecoration(
                          color: PColors.surface.withValues(alpha: 0.6),
                          borderRadius: BorderRadius.circular(25),
                          border: Border.all(
                            color: PColors.border.withValues(alpha: 0.3),
                          ),
                        ),
                        child: TabBar(
                          padding: EdgeInsets.zero,
                          indicatorPadding: const EdgeInsets.only(
                            left: -4,
                            right: -4,
                            top: 42,
                            bottom: 2,
                          ),
                          indicator: BoxDecoration(
                            color: PColors.primary,
                            borderRadius: BorderRadius.circular(1),
                            boxShadow: [
                              BoxShadow(
                                color: PColors.primary.withValues(alpha: 0.3),
                                blurRadius: 8,
                                offset: const Offset(0, 2),
                              ),
                            ],
                          ),
                          labelStyle: GoogleFonts.inter(
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                          ),
                          unselectedLabelStyle: GoogleFonts.inter(
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                          ),
                          labelColor: PColors.primary,
                          unselectedLabelColor: PColors.textDim,
                          dividerColor: Colors.transparent,
                          overlayColor: WidgetStateProperty.all(
                            Colors.transparent,
                          ),
                          tabs: const [
                            Tab(
                              height: 42,
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Icon(LucideIcons.messageSquare, size: 12),
                                  SizedBox(width: 4),
                                  Text('Paylaşımlar'),
                                ],
                              ),
                            ),
                            Tab(
                              height: 42,
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Icon(LucideIcons.heart, size: 15),
                                  SizedBox(width: 4),
                                  Text('Gönüllülük'),
                                ],
                              ),
                            ),
                            Tab(
                              height: 42,
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Icon(LucideIcons.trophy, size: 15),
                                  SizedBox(width: 4),
                                  Text('Başarılar'),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),

                    const SizedBox(height: 12),
                  ],
                ),
              ),
            ),

            // Tab Bar View
            Expanded(
              child: TabBarView(
                children: [
                  _buildPostsTab(user),
                  _buildVolunteerTab(context),
                  _buildAchievementsTab(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  // ═══════════════════════════════════════════════════════════════════════════════════
  // 💬 POSTS TAB
  // ═══════════════════════════════════════════════════════════════════════════════════

  Widget _buildPostsTab(AppUser user) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          _buildCreatePostCard(user).animate().fadeIn().slideY(begin: -0.3),
          const SizedBox(height: 20),
          _buildCommunityStats()
              .animate(delay: 100.ms)
              .fadeIn()
              .slideY(begin: 0.3),
          const SizedBox(height: 20),
          ...MockData.communityPosts['posts'].asMap().entries.map((entry) {
            final index = entry.key;
            final post = entry.value;
            return Container(
              margin: const EdgeInsets.only(bottom: 16),
              child: _buildPostCard(post)
                  .animate(delay: (200 + index * 100).ms)
                  .fadeIn()
                  .slideX(begin: 0.3),
            );
          }).toList(),
          const SizedBox(height: 100),
        ],
      ),
    );
  }

  Widget _buildCreatePostCard(AppUser user) {
    return GlassMorphicCard(
      child: Row(
        children: [
          Container(
            width: 50,
            height: 50,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [user.levelColor, user.levelColor.withValues(alpha: 0.7)],
              ),
              borderRadius: BorderRadius.circular(25),
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
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              decoration: BoxDecoration(
                color: PColors.surfaceHi.withValues(alpha: 0.5),
                borderRadius: BorderRadius.circular(25),
                border: Border.all(color: PColors.border),
              ),
              child: Text(
                'Bugün ne öğrendin?',
                style: GoogleFonts.inter(fontSize: 14, color: PColors.textDim),
              ),
            ),
          ),
          const SizedBox(width: 12),
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: PColors.primary.withValues(alpha: 0.15),
              borderRadius: BorderRadius.circular(20),
            ),
            child: const Icon(
              LucideIcons.camera,
              color: PColors.primary,
              size: 20,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCommunityStats() {
    return GlassMorphicCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Topluluk İstatistikleri 📊',
            style: GoogleFonts.poppins(
              fontSize: 16,
              fontWeight: FontWeight.w600,
              color: PColors.text,
            ),
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              _buildStatItem('Aktif Üye', '12.8K+', PColors.primary),
              _buildStatItem('Bu Ay Paylaşım', '890+', PColors.success),
              _buildStatItem('Gönüllü Saat', '2.4K+', PColors.accent),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildStatItem(String label, String value, Color color) {
    return Expanded(
      child: Column(
        children: [
          Text(
            value,
            style: GoogleFonts.poppins(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: color,
            ),
          ),
          Text(
            label,
            style: GoogleFonts.inter(fontSize: 12, color: PColors.textDim),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  Widget _buildPostCard(Map<String, dynamic> post) {
    return GlassMorphicCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                width: 50,
                height: 50,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(25),
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(25),
                  child: ProjectImage(
                    imageUrl: post['authorAvatar'],
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Text(
                          post['author'],
                          style: GoogleFonts.poppins(
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                            color: PColors.text,
                          ),
                        ),
                        const SizedBox(width: 8),
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 8,
                            vertical: 2,
                          ),
                          decoration: BoxDecoration(
                            color: PColors.accent.withValues(alpha: 0.15),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Text(
                            post['level'],
                            style: GoogleFonts.inter(
                              fontSize: 10,
                              color: PColors.accent,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ],
                    ),
                    Text(
                      '${post['city']} • ${post['timeAgo']}',
                      style: GoogleFonts.inter(
                        fontSize: 12,
                        color: PColors.textDim,
                      ),
                    ),
                  ],
                ),
              ),
              const Icon(
                LucideIcons.flipVertical,
                color: PColors.textDim,
                size: 20,
              ),
            ],
          ),
          const SizedBox(height: 12),
          Text(
            post['content'],
            style: GoogleFonts.inter(
              fontSize: 14,
              color: PColors.text,
              height: 1.4,
            ),
          ),
          if (post['image'] != null) ...[
            const SizedBox(height: 12),
            ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: ProjectImage(
                imageUrl: post['image'],
                width: double.infinity,
                height: 200,
                fit: BoxFit.cover,
              ),
            ),
          ],
          const SizedBox(height: 16),
          Row(
            children: [
              _buildPostAction(
                LucideIcons.heart,
                '${post['likes']}',
                PColors.warning,
              ),
              const SizedBox(width: 20),
              _buildPostAction(
                LucideIcons.messageCircle,
                '${post['comments']}',
                PColors.info,
              ),
              const SizedBox(width: 20),
              _buildPostAction(LucideIcons.share2, 'Paylaş', PColors.textDim),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildPostAction(IconData icon, String text, Color color) {
    return GestureDetector(
      onTap: () {
        HapticFeedback.lightImpact();
      },
      child: Row(
        children: [
          Icon(icon, size: 18, color: color),
          const SizedBox(width: 6),
          Text(
            text,
            style: GoogleFonts.inter(
              fontSize: 12,
              color: color,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }

  // ═══════════════════════════════════════════════════════════════════════════════════
  // ❤️ VOLUNTEER TAB
  // ═══════════════════════════════════════════════════════════════════════════════════

  Widget _buildVolunteerTab(BuildContext context) {
    final volunteerTasks = MockData.tasks
        .where((task) => task.type == ProjectType.volunteer)
        .toList();

    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildVolunteerHeroCard().animate().fadeIn().slideY(begin: -0.2),
          const SizedBox(height: 20),
          _buildImpactStats()
              .animate(delay: 100.ms)
              .fadeIn()
              .slideY(begin: 0.2),
          const SizedBox(height: 20),
          Text(
            'Aktif Gönüllülük Projeleri ❤️',
            style: GoogleFonts.poppins(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: PColors.text,
            ),
          ).animate(delay: 200.ms).fadeIn().slideX(begin: -0.3),
          const SizedBox(height: 16),
          if (volunteerTasks.isEmpty)
            _buildEmptyVolunteersSection()
                .animate(delay: 300.ms)
                .fadeIn()
                .scale(begin: const Offset(0.8, 0.8))
          else
            ...volunteerTasks.asMap().entries.map((entry) {
              final index = entry.key;
              final task = entry.value;
              return Container(
                margin: const EdgeInsets.only(bottom: 16),
                child: _buildModernVolunteerCard(context, task)
                    .animate(delay: (300 + index * 100).ms)
                    .fadeIn()
                    .slideX(begin: 0.3),
              );
            }),
          const SizedBox(height: 100),
        ],
      ),
    );
  }

  Widget _buildVolunteerHeroCard() {
    return SizedBox(
      height: 180,
      child: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  PColors.success,
                  PColors.success.withValues(alpha: 0.8),
                  PColors.primary.withValues(alpha: 0.6),
                ],
              ),
              borderRadius: BorderRadius.circular(24),
              boxShadow: [
                BoxShadow(
                  color: PColors.success.withValues(alpha: 0.3),
                  blurRadius: 20,
                  spreadRadius: -5,
                  offset: const Offset(0, 10),
                ),
              ],
            ),
          ),
          Positioned(
            left: 24,
            top: 24,
            bottom: 24,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 6,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.white.withValues(alpha: 0.2),
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: Text(
                    '❤️ TOPLUMSAL ETKİ',
                    style: GoogleFonts.inter(
                      fontSize: 11,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 1.2,
                    ),
                  ),
                ),
                const SizedBox(height: 12),
                Text(
                  'Gönüllülükle\nDeğişim Yarat',
                  style: GoogleFonts.poppins(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                    height: 1.2,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  'Bu ay 456 saat gönüllülü olduk',
                  style: GoogleFonts.inter(
                    fontSize: 12,
                    color: Colors.white.withValues(alpha: 0.9),
                    height: 1.4,
                  ),
                ),
              ],
            ),
          ),
          Positioned(
            right: 20,
            top: 30,
            child: Container(
              width: 60,
              height: 60,
              decoration: BoxDecoration(
                color: Colors.white.withValues(alpha: 0.15),
                shape: BoxShape.circle,
              ),
              child: const Icon(
                LucideIcons.heart,
                color: Colors.white,
                size: 30,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildImpactStats() {
    return SizedBox(
      height: 145,
      child: Row(
        children: [
          Expanded(
            child: _buildImpactCard(
              '24',
              'Ağaç',
              'Dikildi',
              LucideIcons.trees,
              PColors.info,
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: _buildImpactCard(
              '89',
              'Kedi',
              'Beslendi',
              LucideIcons.cat,
              PColors.accent,
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: _buildImpactCard(
              '45',
              'Proje',
              'Tamamlandı',
              LucideIcons.circleCheck,
              PColors.success,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildImpactCard(
    String value,
    String label,
    String description,
    IconData icon,
    Color color,
  ) {
    return GlassMorphicCard(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: color.withValues(alpha: 0.15),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(icon, color: color, size: 20),
          ),
          const SizedBox(height: 8),
          Text(
            value,
            style: GoogleFonts.poppins(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: color,
            ),
          ),
          Text(
            label,
            style: GoogleFonts.inter(
              fontSize: 11,
              color: PColors.text,
              fontWeight: FontWeight.w600,
            ),
          ),
          Text(
            description,
            style: GoogleFonts.inter(fontSize: 9, color: PColors.textDim),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  Widget _buildModernVolunteerCard(BuildContext context, Task task) {
    return GlassMorphicCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                width: 70,
                height: 70,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16),
                  boxShadow: PShadows.soft(),
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(16),
                  child: ProjectImage(
                    imageUrl: task.imageUrl,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 8,
                            vertical: 4,
                          ),
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              colors: [
                                PColors.success,
                                PColors.success.withValues(alpha: 0.8),
                              ],
                            ),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Text(
                            'GÖNÜLLÜLÜK',
                            style: GoogleFonts.inter(
                              fontSize: 9,
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              letterSpacing: 0.5,
                            ),
                          ),
                        ),
                        if (task.isUrgent) ...[
                          const SizedBox(width: 8),
                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 8,
                              vertical: 4,
                            ),
                            decoration: BoxDecoration(
                              color: PColors.warning,
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Text(
                              'ACİL',
                              style: GoogleFonts.inter(
                                fontSize: 9,
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ],
                      ],
                    ),
                    const SizedBox(height: 8),
                    Text(
                      task.title,
                      style: GoogleFonts.poppins(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: PColors.text,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 4),
                    Text(
                      task.organization,
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
          const SizedBox(height: 16),
          Text(
            task.description,
            style: GoogleFonts.inter(
              fontSize: 13,
              color: PColors.textDim,
              height: 1.5,
            ),
            maxLines: 3,
            overflow: TextOverflow.ellipsis,
          ),
          const SizedBox(height: 16),
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: PColors.surfaceHi.withValues(alpha: 0.3),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          const Icon(
                            LucideIcons.users,
                            size: 14,
                            color: PColors.info,
                          ),
                          const SizedBox(width: 4),
                          Text(
                            '${task.currentParticipants}/${task.maxParticipants} gönüllü',
                            style: GoogleFonts.inter(
                              fontSize: 11,
                              color: PColors.info,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 4),
                      Row(
                        children: [
                          const Icon(
                            LucideIcons.clock,
                            size: 14,
                            color: PColors.textDim,
                          ),
                          const SizedBox(width: 4),
                          Text(
                            '${task.estimatedHours} saat',
                            style: GoogleFonts.inter(
                              fontSize: 11,
                              color: PColors.textDim,
                            ),
                          ),
                          const SizedBox(width: 12),
                          const Icon(
                            LucideIcons.mapPin,
                            size: 14,
                            color: PColors.textDim,
                          ),
                          const SizedBox(width: 4),
                          Text(
                            PusulaCore.digemCities[task.city] ?? task.city,
                            style: GoogleFonts.inter(
                              fontSize: 11,
                              color: PColors.textDim,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                ElevatedButton(
                  onPressed: task.isAvailable
                      ? () {
                          HapticFeedback.lightImpact();
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text(
                                'Gönüllülük başvurun alındı! Onay bekliyor.',
                                style: GoogleFonts.inter(color: Colors.white),
                              ),
                              backgroundColor: PColors.success,
                              behavior: SnackBarBehavior.floating,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                            ),
                          );
                        }
                      : null,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: task.isAvailable
                        ? PColors.success
                        : PColors.border,
                    foregroundColor: task.isAvailable
                        ? Colors.white
                        : PColors.textDim,
                    padding: const EdgeInsets.symmetric(
                      horizontal: 20,
                      vertical: 8,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    elevation: task.isAvailable ? 8 : 0,
                    shadowColor: task.isAvailable
                        ? PColors.success.withValues(alpha: 0.3)
                        : null,
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Icon(LucideIcons.heart, size: 14),
                      const SizedBox(width: 4),
                      Text(
                        task.isAvailable ? 'Katıl' : 'Dolu',
                        style: GoogleFonts.inter(
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildEmptyVolunteersSection() {
    return Center(
      child: GlassMorphicCard(
        child: Column(
          children: [
            Container(
              width: 80,
              height: 80,
              decoration: BoxDecoration(
                color: PColors.success.withValues(alpha: 0.1),
                shape: BoxShape.circle,
              ),
              child: const Icon(
                LucideIcons.heart,
                size: 40,
                color: PColors.success,
              ),
            ),
            const SizedBox(height: 16),
            Text(
              'Gönüllülük Bekliyor',
              style: GoogleFonts.poppins(
                fontSize: 16,
                fontWeight: FontWeight.w600,
                color: PColors.text,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              'Yardıma ihtiyaç duyan projeler\nyakında eklenecek!',
              style: GoogleFonts.inter(fontSize: 12, color: PColors.textDim),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }

  // ═══════════════════════════════════════════════════════════════════════════════════
  // 🏆 ACHIEVEMENTS TAB
  // ═══════════════════════════════════════════════════════════════════════════════════

  Widget _buildAchievementsTab() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildLeaderboard().animate().fadeIn().slideY(begin: -0.3),
          const SizedBox(height: 20),
          Text(
            'Başarı Hikayeleri ⭐',
            style: GoogleFonts.poppins(
              fontSize: 18,
              fontWeight: FontWeight.w600,
              color: PColors.text,
            ),
          ).animate().fadeIn().slideX(begin: -0.3),
          const SizedBox(height: 16),
          ...MockData.successStories.asMap().entries.map((entry) {
            final index = entry.key;
            final story = entry.value;
            return Container(
              margin: const EdgeInsets.only(bottom: 16),
              child: _buildSuccessStoryCard(story)
                  .animate(delay: (100 + index * 100).ms)
                  .fadeIn()
                  .slideX(begin: 0.3),
            );
          }),
          const SizedBox(height: 100),
        ],
      ),
    );
  }

  Widget _buildLeaderboard() {
    final leaders = [
      {
        'name': 'Ayşe Yılmaz',
        'city': 'İstanbul',
        'points': '2,456',
        'level': 'Büyük Usta',
      },
      {
        'name': 'Mehmet Kaya',
        'city': 'Ankara',
        'points': '2,234',
        'level': 'Büyük Usta',
      },
      {
        'name': 'Zeynep Özkan',
        'city': 'İzmir',
        'points': '2,102',
        'level': 'Usta',
      },
    ];

    return GlassMorphicCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Bu Ay Liderleri 🏆',
            style: GoogleFonts.poppins(
              fontSize: 16,
              fontWeight: FontWeight.w600,
              color: PColors.text,
            ),
          ),
          const SizedBox(height: 16),
          ...leaders.asMap().entries.map((entry) {
            final index = entry.key;
            final leader = entry.value;
            final medal = index == 0
                ? '🥇'
                : index == 1
                    ? '🥈'
                    : '🥉';
            return Container(
              margin: const EdgeInsets.only(bottom: 12),
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: PColors.surfaceHi.withValues(alpha: 0.3),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Row(
                children: [
                  Text(medal, style: const TextStyle(fontSize: 20)),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          leader['name']!,
                          style: GoogleFonts.poppins(
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                            color: PColors.text,
                          ),
                        ),
                        Text(
                          '${leader['city']} • ${leader['level']}',
                          style: GoogleFonts.inter(
                            fontSize: 12,
                            color: PColors.textDim,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 6,
                    ),
                    decoration: BoxDecoration(
                      color: PColors.accent.withValues(alpha: 0.15),
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: Text(
                      '${leader['points']} XP',
                      style: GoogleFonts.inter(
                        fontSize: 12,
                        color: PColors.accent,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ],
              ),
            );
          }),
        ],
      ),
    );
  }

  Widget _buildSuccessStoryCard(Map<String, dynamic> story) {
    return GlassMorphicCard(
      child: Row(
        children: [
          Container(
            width: 60,
            height: 60,
            decoration: BoxDecoration(borderRadius: BorderRadius.circular(30)),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(30),
              child: ProjectImage(
                imageUrl: story['image'],
                fit: BoxFit.cover,
              ),
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  story['name'],
                  style: GoogleFonts.poppins(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: PColors.text,
                  ),
                ),
                const SizedBox(height: 4),
                Row(
                  children: [
                    Text(
                      story['before'],
                      style: GoogleFonts.inter(
                        fontSize: 12,
                        color: PColors.textDim,
                      ),
                    ),
                    const Icon(
                      LucideIcons.arrowRight,
                      size: 12,
                      color: PColors.textDim,
                    ),
                    Text(
                      story['after'],
                      style: GoogleFonts.inter(
                        fontSize: 12,
                        color: PColors.success,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(width: 8),
                    const Icon(
                      LucideIcons.trendingUp,
                      size: 12,
                      color: PColors.success,
                    ),
                  ],
                ),
                const SizedBox(height: 6),
                Text(
                  story['story'],
                  style: GoogleFonts.inter(
                    fontSize: 12,
                    color: PColors.textDim,
                    height: 1.3,
                  ),
                ),
                const SizedBox(height: 8),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 8,
                    vertical: 4,
                  ),
                  decoration: BoxDecoration(
                    color: PColors.success.withValues(alpha: 0.15),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Text(
                    '🎉 ${story['achievement']}',
                    style: GoogleFonts.inter(
                      fontSize: 10,
                      color: PColors.success,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
