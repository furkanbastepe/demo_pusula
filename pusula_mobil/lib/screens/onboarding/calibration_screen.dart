import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:go_router/go_router.dart';
import '../../core/core.dart';
import '../../widgets/common/aurora_background.dart';
import '../../widgets/calibration/calibration_glass_card.dart';

// ═══════════════════════════════════════════════════════════════════════════════════
// 🧭 CALIBRATION SCREEN - Uses shared constants and theme
// ═══════════════════════════════════════════════════════════════════════════════════

// ✅ STATE MANAGEMENT
class CalibrationState {
  final int currentPage;
  final String? selectedDigemKey;
  final String? selectedSkillPath;
  final bool isCompleted;

  CalibrationState({
    this.currentPage = 0,
    this.selectedDigemKey,
    this.selectedSkillPath,
    this.isCompleted = false,
  });

  CalibrationState copyWith({
    int? currentPage,
    String? selectedDigemKey,
    String? selectedSkillPath,
    bool? isCompleted,
  }) {
    return CalibrationState(
      currentPage: currentPage ?? this.currentPage,
      selectedDigemKey: selectedDigemKey ?? this.selectedDigemKey,
      selectedSkillPath: selectedSkillPath ?? this.selectedSkillPath,
      isCompleted: isCompleted ?? this.isCompleted,
    );
  }
}

class CalibrationNotifier extends StateNotifier<CalibrationState> {
  CalibrationNotifier() : super(CalibrationState());

  void setCurrentPage(int page) {
    state = state.copyWith(currentPage: page);
  }

  void selectDigem(String key) {
    state = state.copyWith(selectedDigemKey: key);
  }

  void selectSkillPath(String path) {
    state = state.copyWith(selectedSkillPath: path);
  }

  void completeCalibration() {
    state = state.copyWith(isCompleted: true);
  }
}

// ✅ PROVIDER
final calibrationProvider =
    StateNotifierProvider.autoDispose<CalibrationNotifier, CalibrationState>(
      (ref) => CalibrationNotifier(),
    );

// ✅ MAIN CALIBRATION SCREEN
class CalibrationScreen extends HookConsumerWidget {
  const CalibrationScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final calibrationState = ref.watch(calibrationProvider);
    final pageController = usePageController();

    // ✅ PUSULA GEÇİŞ EFEKTİ KONTROLÜ
    ref.listen(calibrationProvider.select((s) => s.isCompleted), (
      _,
      isCompleted,
    ) {
      if (isCompleted) {
        Timer(const Duration(seconds: 1), () {
          context.go('/home');
        });
      }
    });

    // ✅ ATLA BUTONU FONKSİYONU
    void skipCalibration() {
      HapticFeedback.lightImpact();
      context.go('/home');
    }

    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Stack(
        children: [
          // ✅ AURORA GLASS BACKGROUND
          const AuroraBackground(),

          SafeArea(
            child: Column(
              children: [
                // ✅ ÜST BAR - DEMO VE ATLA BUTONU
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16.0,
                    vertical: 8.0,
                  ),
                  child: Row(
                    children: [
                      // DEMO BADGE
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 12,
                          vertical: 6,
                        ),
                        decoration: BoxDecoration(
                          color: PColors.warning.withValues(alpha: 0.15),
                          borderRadius: BorderRadius.circular(16),
                          border: Border.all(
                            color: PColors.warning.withValues(alpha: 0.3),
                          ),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            const Icon(
                              LucideIcons.flaskConical,
                              size: 14,
                              color: PColors.warning,
                            ),
                            const SizedBox(width: 6),
                            Text(
                              'DEMO',
                              style: GoogleFonts.inter(
                                fontSize: 11,
                                fontWeight: FontWeight.bold,
                                color: PColors.warning,
                              ),
                            ),
                          ],
                        ),
                      ),

                      const Spacer(),

                      // ATLA BUTONU
                      TextButton(
                        onPressed: skipCalibration,
                        style: TextButton.styleFrom(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 16,
                            vertical: 8,
                          ),
                          backgroundColor: PColors.surface.withValues(
                            alpha: 0.8,
                          ),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(
                              'Atla',
                              style: GoogleFonts.inter(
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
                                color: PColors.textDim,
                              ),
                            ),
                            const SizedBox(width: 4),
                            const Icon(
                              LucideIcons.skipForward,
                              size: 16,
                              color: PColors.textDim,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),

                // PROGRESS INDICATOR
                CalibrationProgress(currentPage: calibrationState.currentPage),

                // PAGE CONTENT
                Expanded(
                  child: PageView(
                    controller: pageController,
                    physics: const NeverScrollableScrollPhysics(),
                    onPageChanged: (page) {
                      ref
                          .read(calibrationProvider.notifier)
                          .setCurrentPage(page);
                    },
                    children: [
                      // ✅ STEP 1: UYGULAMA TANITIMI
                      AppIntroStep(
                        onNext: () => pageController.nextPage(
                          duration: 400.ms,
                          curve: Curves.easeInOutCubic,
                        ),
                      ),

                      // ✅ STEP 2: USTA-ÇIRAK SİSTEMİ
                      MasterApprenticeStep(
                        onNext: () => pageController.nextPage(
                          duration: 400.ms,
                          curve: Curves.easeInOutCubic,
                        ),
                      ),

                      // ✅ STEP 3: ŞEHİR SEÇİMİ
                      DigemSelectionStep(
                        onSelected: (key) {
                          ref
                              .read(calibrationProvider.notifier)
                              .selectDigem(key);
                          pageController.nextPage(
                            duration: 400.ms,
                            curve: Curves.easeInOutCubic,
                          );
                        },
                      ),

                      // ✅ STEP 4: SKILL PATH SEÇİMİ
                      SkillPathSelectionStep(
                        onSelected: (path) {
                          ref
                              .read(calibrationProvider.notifier)
                              .selectSkillPath(path);
                          pageController.nextPage(
                            duration: 400.ms,
                            curve: Curves.easeInOutCubic,
                          );
                        },
                      ),

                      // ✅ STEP 5: KALİBRASYON TAMAMLANDI
                      CalibrationCompleteStep(
                        selectedCity: calibrationState.selectedDigemKey != null
                            ? PusulaCore.digemCities[calibrationState.selectedDigemKey!] ??
                                  ''
                            : '',
                        onComplete: () {
                          ref
                              .read(calibrationProvider.notifier)
                              .completeCalibration();
                        },
                      ),
                    ],
                  ),
                ),

                // NAVIGATION BUTTON - Sadece ilk iki adımda
                if (calibrationState.currentPage <= 1)
                  CalibrationNavigationButton(
                    text: calibrationState.currentPage == 0
                        ? 'Başla'
                        : 'Devam Et',
                    isActive: true,
                    onPressed: () {
                      pageController.nextPage(
                        duration: 400.ms,
                        curve: Curves.easeInOutCubic,
                      );
                    },
                  ),

                // DEMO UYARI METNİ
                Padding(
                  padding: const EdgeInsets.only(
                    bottom: 16.0,
                    left: 16.0,
                    right: 16.0,
                  ),
                  child: Text(
                    'Kalibrasyon İşlemi Demo Aşamasındadır.',
                    style: GoogleFonts.inter(
                      fontSize: 11,
                      color: PColors.textDim.withValues(alpha: 0.7),
                      fontStyle: FontStyle.italic,
                    ),
                    textAlign: TextAlign.center,
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

// ═══════════════════════════════════════════════════════════════════════════════════
// 📊 PROGRESS BAR
// ═══════════════════════════════════════════════════════════════════════════════════
class CalibrationProgress extends StatelessWidget {
  final int currentPage;

  const CalibrationProgress({super.key, required this.currentPage});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 20.0),
      child: Row(
        children: List.generate(5, (index) {
          return Expanded(
            child: AnimatedContainer(
              duration: 300.ms,
              margin: const EdgeInsets.symmetric(horizontal: 4),
              height: 5,
              decoration: BoxDecoration(
                gradient: index <= currentPage
                    ? const LinearGradient(
                        colors: [
                          PColors.gradientStart,
                          PColors.gradientEnd,
                        ],
                      )
                    : null,
                color: index <= currentPage ? null : PColors.border,
                borderRadius: BorderRadius.circular(2.5),
              ),
            ),
          );
        }),
      ),
    );
  }
}

// ═══════════════════════════════════════════════════════════════════════════════════
// 🎯 STEP 1: APP INTRO
// ═══════════════════════════════════════════════════════════════════════════════════
class AppIntroStep extends StatelessWidget {
  final VoidCallback onNext;

  const AppIntroStep({super.key, required this.onNext});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(24),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              gradient: RadialGradient(
                colors: [
                  PColors.primary.withValues(alpha: 0.1),
                  Colors.transparent,
                ],
              ),
              shape: BoxShape.circle,
            ),
            child: const Icon(
              LucideIcons.zap,
              size: 80,
              color: PColors.primary,
            ),
          ).animate().scale(duration: 800.ms, curve: Curves.elasticOut),

          const SizedBox(height: 24),

          Text(
            'Mikro Projelerle\nDeneyim Kazan',
            style: GoogleFonts.poppins(
              fontSize: 28,
              fontWeight: FontWeight.bold,
              color: PColors.text,
              height: 1.2,
            ),
            textAlign: TextAlign.center,
          ).animate().fadeIn(delay: 300.ms).slideY(begin: 0.3),

          const SizedBox(height: 12),

          Text(
            'Mikro projelerle hem deneyim kazan, hem CV\'ni güçlendir, hem de gelecek kariyerine adım at.',
            style: GoogleFonts.inter(
              fontSize: 15,
              color: PColors.textDim,
              height: 1.4,
            ),
            textAlign: TextAlign.center,
          ).animate().fadeIn(delay: 600.ms).slideY(begin: 0.3),

          const SizedBox(height: 32),

          CalibrationGlassMorphicCard(
            child: Column(
              children: [
                _buildFeatureRow(
                  LucideIcons.briefcase,
                  'Gerçek İş Deneyimi',
                  'Staj değil, gerçek projeler',
                  PColors.primary,
                ),

                const SizedBox(height: 16),

                _buildFeatureRow(
                  LucideIcons.trophy,
                  'Sertifika & Referans',
                  'Her projede kazandığın belgeler',
                  PColors.accent,
                ),

                const SizedBox(height: 16),

                _buildFeatureRow(
                  LucideIcons.users,
                  'Mentor Desteği',
                  'Alanında uzman mentorlar',
                  PColors.info,
                ),
              ],
            ),
          ).animate().fadeIn(delay: 900.ms).slideY(begin: 0.3),
        ],
      ),
    );
  }

  Widget _buildFeatureRow(
    IconData icon,
    String title,
    String subtitle,
    Color color,
  ) {
    return Row(
      children: [
        Container(
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: color.withValues(alpha: 0.1),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Icon(icon, color: color, size: 20),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: GoogleFonts.poppins(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  color: PColors.text,
                ),
              ),
              Text(
                subtitle,
                style: GoogleFonts.inter(
                  fontSize: 11,
                  color: PColors.textDim,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

// ═══════════════════════════════════════════════════════════════════════════════════
// 🎯 STEP 2: MASTER-APPRENTICE SYSTEM
// ═══════════════════════════════════════════════════════════════════════════════════
class MasterApprenticeStep extends StatelessWidget {
  final VoidCallback onNext;

  const MasterApprenticeStep({super.key, required this.onNext});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(24),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(
            LucideIcons.crown,
            size: 64,
            color: PColors.accent,
          ).animate().scale(duration: 800.ms, curve: Curves.elasticOut),

          const SizedBox(height: 24),

          Text(
            'Usta-Çırak Sistemi',
            style: GoogleFonts.poppins(
              fontSize: 26,
              fontWeight: FontWeight.bold,
              color: PColors.text,
            ),
            textAlign: TextAlign.center,
          ).animate().fadeIn(delay: 300.ms),

          const SizedBox(height: 12),

          Text(
            'Çırak seviyesinden başlayarak Usta seviyesine kadar ilerleyeceksin. Her seviye yeni fırsatlar ve sorumluluklar getirecek.',
            style: GoogleFonts.inter(
              fontSize: 15,
              color: PColors.textDim,
              height: 1.4,
            ),
            textAlign: TextAlign.center,
          ).animate().fadeIn(delay: 600.ms),

          const SizedBox(height: 32),

          Column(
            children: [
              _buildLevelCard(
                'Çırak',
                'İlk adımlarını atıyorsun',
                '500 XP',
                PColors.success,
                LucideIcons.sprout,
                0,
              ),

              const SizedBox(height: 12),

              _buildLevelCard(
                'Kalfa',
                'Temel becerileri kazandın',
                '500-1500 XP',
                PColors.info,
                LucideIcons.hammer,
                1,
              ),

              const SizedBox(height: 12),

              _buildLevelCard(
                'Usta',
                'Alanında deneyim sahibisin',
                '1500-2500 XP',
                PColors.accent,
                LucideIcons.award,
                2,
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildLevelCard(
    String title,
    String description,
    String xp,
    Color color,
    IconData icon,
    int delay,
  ) {
    return CalibrationGlassMorphicCard(
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: color.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Icon(icon, color: color, size: 20),
          ),

          const SizedBox(width: 12),

          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: GoogleFonts.poppins(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: color,
                  ),
                ),
                Text(
                  description,
                  style: GoogleFonts.inter(
                    fontSize: 13,
                    color: PColors.text,
                  ),
                ),
                Text(
                  xp,
                  style: GoogleFonts.inter(
                    fontSize: 11,
                    color: PColors.textDim,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    ).animate().fadeIn(delay: (900 + delay * 200).ms).slideX(begin: 0.3);
  }
}

// ═══════════════════════════════════════════════════════════════════════════════════
// 🎯 STEP 3: DIGEM SELECTION
// ═══════════════════════════════════════════════════════════════════════════════════
class DigemSelectionStep extends HookWidget {
  final Function(String) onSelected;

  const DigemSelectionStep({super.key, required this.onSelected});

  @override
  Widget build(BuildContext context) {
    final searchTerm = useState('');

    final filteredCities = PusulaCore.digemCities.entries
        .where(
          (entry) => entry.value.toLowerCase().contains(
            searchTerm.value.toLowerCase(),
          ),
        )
        .toList();

    return Padding(
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Icon(
            LucideIcons.building,
            size: 48,
            color: PColors.primary,
          ).animate().fadeIn(),

          const SizedBox(height: 24),

          Text(
            'Merkezini Seç',
            style: GoogleFonts.poppins(
              fontSize: 28,
              fontWeight: FontWeight.bold,
              color: PColors.text,
            ),
          ).animate().fadeIn(delay: 200.ms),

          const SizedBox(height: 12),

          Text(
            'Hangi Dijital Gençlik Merkezi senin üssün olacak?',
            style: GoogleFonts.inter(
              fontSize: 16,
              color: PColors.textDim,
              height: 1.5,
            ),
          ).animate().fadeIn(delay: 400.ms),

          const SizedBox(height: 32),

          TextField(
            onChanged: (value) => searchTerm.value = value,
            style: GoogleFonts.inter(color: PColors.text),
            decoration: InputDecoration(
              hintText: 'Şehir ara... örn: ankara',
              hintStyle: GoogleFonts.inter(color: PColors.textDim),
              prefixIcon: const Icon(
                LucideIcons.search,
                color: PColors.textDim,
              ),
              filled: true,
              fillColor: PColors.surfaceHi,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: const BorderSide(color: PColors.border),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: const BorderSide(color: PColors.border),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: const BorderSide(
                  color: PColors.primary,
                  width: 1.5,
                ),
              ),
            ),
          ).animate().fadeIn(delay: 600.ms),

          const SizedBox(height: 16),

          Expanded(
            child: ListView.builder(
              itemCount: filteredCities.length,
              itemBuilder: (context, index) {
                final entry = filteredCities[index];
                return Card(
                      color: PColors.surface,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                        side: const BorderSide(color: PColors.border),
                      ),
                      margin: const EdgeInsets.only(bottom: 10),
                      child: ListTile(
                        leading: Container(
                          padding: const EdgeInsets.all(8),
                          decoration: BoxDecoration(
                            color: PColors.surfaceHi,
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: const Icon(
                            LucideIcons.building,
                            color: PColors.textDim,
                            size: 20,
                          ),
                        ),
                        title: Text(
                          entry.value,
                          style: GoogleFonts.poppins(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            color: PColors.text,
                          ),
                        ),
                        subtitle: Text(
                          'Dijital Gençlik Merkezi',
                          style: GoogleFonts.inter(
                            fontSize: 12,
                            color: PColors.textDim,
                          ),
                        ),
                        onTap: () {
                          HapticFeedback.lightImpact();
                          onSelected(entry.key);
                        },
                        trailing: const Icon(
                          LucideIcons.chevronRight,
                          color: PColors.textDim,
                          size: 16,
                        ),
                      ),
                    )
                    .animate()
                    .fadeIn(delay: (800 + index * 50).ms)
                    .slideX(begin: 0.3);
              },
            ),
          ),
        ],
      ),
    );
  }
}

// ═══════════════════════════════════════════════════════════════════════════════════
// 🎯 STEP 4: SKILL PATH SELECTION
// ═══════════════════════════════════════════════════════════════════════════════════
class SkillPathSelectionStep extends StatelessWidget {
  final Function(String) onSelected;

  const SkillPathSelectionStep({super.key, required this.onSelected});

  @override
  Widget build(BuildContext context) {
    final pathEntries = PusulaCore.skillPaths.entries.toList();

    return Padding(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Icon(
            LucideIcons.route,
            size: 40,
            color: PColors.primary,
          ).animate().fadeIn(),

          const SizedBox(height: 16),

          Text(
            'Yol Haritanı Belirle',
            style: GoogleFonts.poppins(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: PColors.text,
            ),
          ).animate().fadeIn(delay: 200.ms),

          const SizedBox(height: 8),

          Text(
            'Hangi alanda uzmanlaşmak istiyorsun?',
            style: GoogleFonts.inter(
              fontSize: 14,
              color: PColors.textDim,
              height: 1.4,
            ),
          ).animate().fadeIn(delay: 400.ms),

          const SizedBox(height: 20),

          Expanded(
            child: GridView.builder(
              physics: const NeverScrollableScrollPhysics(),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 10,
                mainAxisSpacing: 10,
                childAspectRatio: 1.15,
              ),
              itemCount: pathEntries.length,
              itemBuilder: (context, index) {
                final entry = pathEntries[index];
                return InkWell(
                  onTap: () {
                    HapticFeedback.lightImpact();
                    onSelected(entry.key);
                  },
                  borderRadius: BorderRadius.circular(14),
                  child: CalibrationGlassMorphicCard(
                    padding: const EdgeInsets.all(12),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          entry.value,
                          size: 30,
                          color: PColors.primary,
                        ),
                        const SizedBox(height: 8),
                        Text(
                          entry.key,
                          textAlign: TextAlign.center,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: GoogleFonts.inter(
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                            color: PColors.text,
                            height: 1.2,
                          ),
                        ),
                      ],
                    ),
                  ),
                )
                    .animate()
                    .fadeIn(delay: Duration(milliseconds: 600 + index * 100))
                    .scale(begin: const Offset(0.8, 0.8));
              },
            ),
          ),
        ],
      ),
    );
  }
}

// ═══════════════════════════════════════════════════════════════════════════════════
// 🎯 STEP 5: CALIBRATION COMPLETE
// ═══════════════════════════════════════════════════════════════════════════════════
class CalibrationCompleteStep extends HookWidget {
  final String selectedCity;
  final VoidCallback onComplete;

  const CalibrationCompleteStep({
    super.key,
    required this.selectedCity,
    required this.onComplete,
  });

  @override
  Widget build(BuildContext context) {
    useEffect(() {
      final timer = Timer(const Duration(milliseconds: 3500), () {
        onComplete();
      });
      return () => timer.cancel();
    }, []);

    return Padding(
      padding: const EdgeInsets.all(24),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(
            LucideIcons.circleCheck,
            size: 80,
            color: PColors.success,
          ).animate().scale(duration: 800.ms, curve: Curves.elasticOut),

          const SizedBox(height: 32),

          Text(
            'Kalibrasyon Tamamlandı!',
            style: GoogleFonts.poppins(
              fontSize: 28,
              fontWeight: FontWeight.bold,
              color: PColors.text,
            ),
            textAlign: TextAlign.center,
          ).animate().fadeIn(delay: 300.ms),

          const SizedBox(height: 16),

          Text(
            selectedCity.isNotEmpty
                ? 'Pusula, $selectedCity şehrindeki fırsatları hazırlıyor...'
                : 'Pusula, senin için fırsatları hazırlıyor...',
            style: GoogleFonts.inter(
              fontSize: 16,
              color: PColors.textDim,
              height: 1.5,
            ),
            textAlign: TextAlign.center,
          ).animate().fadeIn(delay: 600.ms),

          const SizedBox(height: 48),

          const Icon(
                LucideIcons.compass,
                size: 120,
                color: PColors.primary,
              )
              .animate(onPlay: (controller) => controller.repeat())
              .rotate(duration: 4.seconds)
              .then()
              .shimmer(duration: 2.seconds),

          const SizedBox(height: 32),

          Text(
            'Yolculuğun başlıyor...',
            style: GoogleFonts.inter(
              fontSize: 14,
              color: PColors.textDim,
              fontStyle: FontStyle.italic,
            ),
            textAlign: TextAlign.center,
          ).animate().fadeIn(delay: 1000.ms),
        ],
      ),
    );
  }
}

// ═══════════════════════════════════════════════════════════════════════════════════
// 🎨 HELPER WIDGETS
// ═══════════════════════════════════════════════════════════════════════════════════

class CalibrationNavigationButton extends StatelessWidget {
  final String text;
  final bool isActive;
  final VoidCallback? onPressed;

  const CalibrationNavigationButton({
    super.key,
    required this.text,
    required this.isActive,
    this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(24.0),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: isActive
              ? PColors.primary
              : PColors.surfaceHi,
          foregroundColor: isActive
              ? PColors.background
              : PColors.textDim,
          minimumSize: const Size(double.infinity, 56),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(14),
          ),
          elevation: isActive ? 4 : 0,
        ),
        onPressed: isActive ? onPressed : null,
        child: Text(
          text,
          style: GoogleFonts.inter(fontSize: 16, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}
