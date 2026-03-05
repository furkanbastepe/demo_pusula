import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import '../../core/core.dart';
import '../../data/data.dart';
import '../../widgets/common/common.dart';
import '../home/main_layout.dart';
import 'workshop_detail_sheet.dart';

class WorkshopsScreen extends ConsumerWidget {
  const WorkshopsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final workshops = MockData.workshops;

    return MainLayout(
      child: CustomScrollView(
        slivers: [
          SliverAppBar(
            title: Text(
              'Atölyeler',
              style: GoogleFonts.poppins(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: PColors.text,
              ),
            ),
            backgroundColor: Colors.transparent,
            floating: true,
            pinned: true,
            flexibleSpace: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    PColors.background.withValues(alpha: 0.9),
                    PColors.background.withValues(alpha: 0.7),
                  ],
                ),
              ),
            ),
            actions: [
              Container(
                margin: const EdgeInsets.only(right: 16),
                decoration: BoxDecoration(
                  color: PColors.accent.withValues(alpha: 0.15),
                  borderRadius: BorderRadius.circular(25),
                ),
                child: IconButton(
                  icon: const Icon(LucideIcons.calendar, color: PColors.accent),
                  onPressed: () => _showCalendarDialog(context),
                ),
              ),
            ],
          ),

          // Featured Workshop
          SliverToBoxAdapter(
            child: Container(
              margin: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Bu Hafta Öne Çıkanlar ⭐',
                    style: GoogleFonts.poppins(
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                      color: PColors.text,
                    ),
                  ).animate().fadeIn().slideX(begin: -0.3),
                  const SizedBox(height: 16),
                  if (workshops.isNotEmpty)
                    _buildFeaturedWorkshop(workshops[0])
                        .animate(delay: 100.ms)
                        .fadeIn()
                        .scale(begin: const Offset(0.9, 0.9)),
                ],
              ),
            ),
          ),

          // Categories
          SliverToBoxAdapter(
            child: Container(
              margin: const EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Kategoriler',
                    style: GoogleFonts.poppins(
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                      color: PColors.text,
                    ),
                  ).animate().fadeIn().slideX(begin: -0.3),
                  const SizedBox(height: 16),
                  _buildCategoriesSection()
                      .animate(delay: 200.ms)
                      .fadeIn()
                      .slideY(begin: 0.3),
                ],
              ),
            ),
          ),

          // Workshop List
          SliverPadding(
            padding: const EdgeInsets.all(16),
            sliver: SliverList(
              delegate: SliverChildBuilderDelegate((context, index) {
                final workshop = workshops[index];
                return Container(
                  margin: const EdgeInsets.only(bottom: 16),
                  child: _buildWorkshopCard(context, workshop)
                      .animate(delay: (300 + index * 100).ms)
                      .fadeIn()
                      .slideX(begin: 0.3),
                );
              }, childCount: workshops.length),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFeaturedWorkshop(Workshop workshop) {
    return GlassMorphicCard(
      padding: EdgeInsets.zero,
      child: SizedBox(
        height: 200,
        child: Stack(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: ProjectImage(
                imageUrl: workshop.imageUrl,
                width: double.infinity,
                height: 200,
                fit: BoxFit.cover,
              ),
            ),
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [Colors.transparent, Colors.black.withValues(alpha: 0.8)],
                ),
              ),
            ),
            Positioned(
              top: 16,
              right: 16,
              child: Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 6,
                ),
                decoration: BoxDecoration(
                  color: PColors.accent,
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: PShadows.glow(PColors.accent),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Icon(LucideIcons.star, size: 14, color: Colors.white),
                    const SizedBox(width: 4),
                    Text(
                      'ÖNE ÇIKAN',
                      style: GoogleFonts.inter(
                        fontSize: 10,
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: Container(
                padding: const EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      workshop.title,
                      style: GoogleFonts.poppins(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Row(
                      children: [
                        Icon(
                          LucideIcons.calendar,
                          size: 16,
                          color: Colors.white.withValues(alpha: 0.9),
                        ),
                        const SizedBox(width: 6),
                        Text(
                          workshop.formattedDateTime,
                          style: GoogleFonts.inter(
                            fontSize: 14,
                            color: Colors.white.withValues(alpha: 0.9),
                          ),
                        ),
                        const Spacer(),
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 12,
                            vertical: 6,
                          ),
                          decoration: BoxDecoration(
                            color: workshop.isAvailable
                                ? PColors.success
                                : PColors.warning,
                            borderRadius: BorderRadius.circular(15),
                          ),
                          child: Text(
                            '${workshop.currentParticipants}/${workshop.maxParticipants}',
                            style: GoogleFonts.inter(
                              fontSize: 12,
                              color: Colors.white,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCategoriesSection() {
    final categories = [
      {
        'name': 'Veri Analizi',
        'icon': LucideIcons.chartBar,
        'color': PColors.info,
      },
      {
        'name': 'Yapay Zeka',
        'icon': LucideIcons.brain,
        'color': PColors.gradientPurple,
      },
      {'name': 'Tasarım', 'icon': LucideIcons.palette, 'color': PColors.accent},
      {'name': 'Yazılım', 'icon': LucideIcons.code, 'color': PColors.success},
      {
        'name': 'Pazarlama',
        'icon': LucideIcons.megaphone,
        'color': PColors.warning,
      },
      {
        'name': 'E-Ticaret',
        'icon': LucideIcons.shoppingCart,
        'color': PColors.primary,
      },
    ];

    return SizedBox(
      height: 80,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: categories.length,
        itemBuilder: (context, index) {
          final category = categories[index];
          return Container(
            width: 80,
            margin: const EdgeInsets.only(right: 12),
            child: GlassMorphicCard(
              padding: const EdgeInsets.all(12),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    category['icon'] as IconData,
                    color: category['color'] as Color,
                    size: 20,
                  ),
                  const SizedBox(height: 6),
                  Text(
                    category['name'] as String,
                    style: GoogleFonts.inter(
                      fontSize: 9,
                      color: PColors.text,
                      fontWeight: FontWeight.w500,
                    ),
                    textAlign: TextAlign.center,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildWorkshopCard(BuildContext context, Workshop workshop) {
    return GlassMorphicCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(16),
                child: SizedBox(
                  width: 80,
                  height: 80,
                  child: ProjectImage(
                    imageUrl: workshop.imageUrl,
                    width: double.infinity,
                    height: 200,
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
                            color: workshop.isAvailable
                                ? PColors.success.withValues(alpha: 0.15)
                                : PColors.warning.withValues(alpha: 0.15),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Text(
                            workshop.isAvailable ? 'AÇIK' : 'DOLU',
                            style: GoogleFonts.inter(
                              fontSize: 10,
                              color: workshop.isAvailable
                                  ? PColors.success
                                  : PColors.warning,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                        const Spacer(),
                        Icon(
                          LucideIcons.clock,
                          size: 14,
                          color: PColors.textDim,
                        ),
                        const SizedBox(width: 4),
                        Text(
                          '${workshop.duration} dk',
                          style: GoogleFonts.inter(
                            fontSize: 12,
                            color: PColors.textDim,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    Text(
                      workshop.title,
                      style: GoogleFonts.poppins(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: PColors.text,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 4),
                    Row(
                      children: [
                        Icon(
                          LucideIcons.user,
                          size: 12,
                          color: PColors.textDim,
                        ),
                        const SizedBox(width: 4),
                        Expanded(
                          child: Text(
                            workshop.instructorName,
                            style: GoogleFonts.inter(
                              fontSize: 12,
                              color: PColors.textDim,
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              Icon(LucideIcons.calendar, size: 16, color: PColors.info),
              const SizedBox(width: 6),
              Text(
                workshop.formattedDateTime,
                style: GoogleFonts.inter(fontSize: 14, color: PColors.text),
              ),
              const Spacer(),
              Icon(LucideIcons.mapPin, size: 16, color: PColors.textDim),
              const SizedBox(width: 4),
              Text(
                workshop.digemCenter,
                style: GoogleFonts.inter(fontSize: 12, color: PColors.textDim),
              ),
            ],
          ),
          const SizedBox(height: 16),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: workshop.isAvailable
                  ? () {
                      showModalBottomSheet(
                        context: context,
                        backgroundColor: Colors.transparent,
                        isScrollControlled: true,
                        builder: (context) =>
                            WorkshopDetailSheet(workshop: workshop),
                      );
                    }
                  : null,
              style: ElevatedButton.styleFrom(
                backgroundColor: workshop.isAvailable
                    ? PColors.accent
                    : PColors.border,
                foregroundColor: workshop.isAvailable
                    ? Colors.white
                    : PColors.textDim,
                padding: const EdgeInsets.symmetric(vertical: 12),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(25),
                ),
                elevation: workshop.isAvailable ? 8 : 0,
                shadowColor: workshop.isAvailable
                    ? PColors.accent.withValues(alpha: 0.3)
                    : null,
              ),
              child: Text(
                workshop.isAvailable ? 'Kayıt Ol' : 'Kontenjan Dolu',
                style: GoogleFonts.inter(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _showCalendarDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => Dialog(
        backgroundColor: Colors.transparent,
        child: GlassMorphicCard(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                'Atölye Takvimi 📅',
                style: GoogleFonts.poppins(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: PColors.text,
                ),
              ),
              const SizedBox(height: 16),
              Text(
                'Bu hafta 3 atölye programlı\nGelecek hafta 5 yeni atölye geliyor!',
                style: GoogleFonts.inter(fontSize: 14, color: PColors.textDim),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () => Navigator.pop(context),
                child: const Text('Tamam'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
