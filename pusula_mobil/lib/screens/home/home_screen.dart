import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import '../../core/core.dart';
import '../../data/data.dart';
import '../../providers/providers.dart';
import '../../services/services.dart';
import '../../widgets/common/common.dart';
import '../projects/task_detail_sheet.dart';
import '../workshops/workshop_detail_sheet.dart';
import '../../features/problem_based_learning/providers/providers.dart';
import '../../features/problem_based_learning/widgets/problem_card.dart';
import '../../features/problem_based_learning/screens/problem_detail_screen.dart';
import 'main_layout.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final user = ref.watch(userProvider) ?? MockData.currentUser;
    final tasks = MockData.tasks;
    final workshops = MockData.workshops;

    return MainLayout(
      child: CustomScrollView(
        slivers: [
          // AppBar with AI Assistant button
          SliverAppBar(
            floating: true,
            snap: true,
            backgroundColor: Colors.transparent,
            elevation: 0,
            title: Text(
              'PUSULA',
              style: GoogleFonts.poppins(
                color: PColors.text,
                fontSize: 24,
                fontWeight: FontWeight.w700,
              ),
            ),
            actions: [
              IconButton(
                icon: const Icon(
                  LucideIcons.bot,
                  color: PColors.primary,
                ),
                onPressed: () => openAIChat(context),
                tooltip: 'AI Asistan',
              ),
              const SizedBox(width: 8),
            ],
          ),
          
          // Content
          SliverPadding(
            padding: const EdgeInsets.all(16),
            sliver: SliverList(
              delegate: SliverChildListDelegate([
                // Welcome Card with time-based greeting
                _buildWelcomeCard(
                  context,
                  user,
                ).animate().fadeIn().slideY(begin: -0.2),

            const SizedBox(height: 24),

            // Duyurular Section
            _buildAnnouncementsSection(
              context,
            ).animate(delay: 100.ms).fadeIn().slideY(begin: 0.2),

            const SizedBox(height: 24),

            // Problemler Section
            _buildProblemsSection(
              context,
              ref,
            ).animate(delay: 150.ms).fadeIn().slideY(begin: 0.2),

            const SizedBox(height: 24),

            // Usta Projeleri Section (renamed from İşler)
            _buildTasksSection(
              context,
              tasks,
              user,
            ).animate(delay: 250.ms).fadeIn().slideY(begin: 0.2),

            const SizedBox(height: 24),

            // Atölyeler Section
            _buildWorkshopsSection(
              context,
              workshops,
            ).animate(delay: 300.ms).fadeIn().slideY(begin: 0.2),

            const SizedBox(height: 24),

            // Gönüllülük Section
            _buildVolunteerSection(
              context,
              tasks,
            ).animate(delay: 400.ms).fadeIn().slideY(begin: 0.2),

            const SizedBox(height: 100),
              ]),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildWelcomeCard(BuildContext context, AppUser user) {
    final greeting = PusulaCore.getTimeBasedGreeting();

    return GlassMorphicCard(
      child: Row(
        children: [
          Container(
            width: 70,
            height: 70,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [user.levelColor, user.levelColor.withValues(alpha: 0.7)],
              ),
              borderRadius: BorderRadius.circular(35),
              boxShadow: PShadows.glow(user.levelColor),
            ),
            child: user.avatar != null
                ? ClipRRect(
                    borderRadius: BorderRadius.circular(35),
                    child: Image.asset(user.avatar!, fit: BoxFit.cover),
                  )
                : _buildAvatarPlaceholder(user),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '$greeting ${user.name.split(' ').first} 👋',
                  style: GoogleFonts.poppins(
                    fontSize: 17,
                    fontWeight: FontWeight.bold,
                    color: PColors.text,
                  ),
                ),
                const SizedBox(height: 6),
                Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 10,
                        vertical: 4,
                      ),
                      decoration: BoxDecoration(
                        color: user.levelColor,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Text(
                        user.levelName,
                        style: GoogleFonts.inter(
                          fontSize: 12,
                          color: PColors.background,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                    const SizedBox(width: 8),
                    Text(
                      '${user.xp} XP',
                      style: GoogleFonts.inter(
                        fontSize: 12,
                        color: PColors.accent,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 2),
                Text(
                  '${PusulaCore.digemCities[user.city]} DİGEM • ${user.skillPath}',
                  style: GoogleFonts.inter(
                    fontSize: 11,
                    color: PColors.textDim,
                  ),
                ),
              ],
            ),
          ),

          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: PColors.primary.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Icon(
              PusulaCore.skillPaths[user.skillPath] ?? LucideIcons.user,
              color: PColors.primary,
              size: 20,
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
        borderRadius: BorderRadius.circular(35),
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

  Widget _buildAnnouncementsSection(BuildContext context) {
    final announcements = [
      {
        'title': 'Yeni AI Atölyesi! 🤖',
        'content': 'ChatGPT ile uygulama geliştirme atölyesi başlıyor',
        'color': PColors.success,
        'icon': LucideIcons.brain,
      },
      {
        'title': 'Startup Zamanı 🚀',
        'content': 'Bu hafta sonu girişimcilik etkinliği',
        'color': PColors.accent,
        'icon': LucideIcons.rocket,
      },
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Duyurular 📢',
          style: GoogleFonts.poppins(
            fontSize: 20,
            fontWeight: FontWeight.w600,
            color: PColors.text,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          'DİGEM\'deki son gelişmeler',
          style: GoogleFonts.inter(fontSize: 14, color: PColors.textDim),
        ),
        const SizedBox(height: 16),

        SizedBox(
          height: 120,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.only(right: 16),
            itemCount: announcements.length,
            itemBuilder: (context, index) {
              final announcement = announcements[index];
              return Container(
                width: 280,
                margin: const EdgeInsets.only(right: 16),
                child: GlassMorphicCard(
                  child: Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          color: (announcement['color'] as Color).withValues(
                            alpha: 0.15,
                          ),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Icon(
                          announcement['icon'] as IconData,
                          color: announcement['color'] as Color,
                          size: 20,
                        ),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              announcement['title'] as String,
                              style: GoogleFonts.poppins(
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
                                color: PColors.text,
                              ),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              announcement['content'] as String,
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
                    ],
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }

  Widget _buildTasksSection(
    BuildContext context,
    List<Task> tasks,
    AppUser user,
  ) {
    final userTasks = tasks.where((task) {
      final matchScore = PusulaMatchingEngine.calculateTaskMatch(user, task);
      return matchScore > 50 && task.type != ProjectType.volunteer;
    }).toList();

    userTasks.sort((a, b) {
      final scoreA = PusulaMatchingEngine.calculateTaskMatch(user, a);
      final scoreB = PusulaMatchingEngine.calculateTaskMatch(user, b);
      return scoreB.compareTo(scoreA);
    });

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Usta Projeleri 🏆',
              style: GoogleFonts.poppins(
                fontSize: 20,
                fontWeight: FontWeight.w600,
                color: PColors.text,
              ),
            ),
            TextButton(
              onPressed: () => context.go('/projects'),
              child: Text(
                'Tümünü Gör',
                style: GoogleFonts.inter(
                  color: PColors.info,
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 4),
        Text(
          'Deneyimli kullanıcıların projeleri',
          style: GoogleFonts.inter(fontSize: 14, color: PColors.textDim),
        ),
        const SizedBox(height: 16),

        SizedBox(
          height: 280,
          child: userTasks.isEmpty
              ? _buildEmptyTasks()
              : ListView.builder(
                  scrollDirection: Axis.horizontal,
                  padding: const EdgeInsets.only(right: 16),
                  itemCount: userTasks.length.clamp(0, 8),
                  itemBuilder: (context, index) {
                    final task = userTasks[index];
                    final matchScore = PusulaMatchingEngine.calculateTaskMatch(
                      user,
                      task,
                    );
                    return Container(
                      width: 240,
                      margin: const EdgeInsets.only(right: 16),
                      child: _buildTaskCard(context, task, matchScore),
                    );
                  },
                ),
        ),
      ],
    );
  }

  Widget _buildWorkshopsSection(
    BuildContext context,
    List<Workshop> workshops,
  ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Atölyeler',
              style: GoogleFonts.poppins(
                fontSize: 20,
                fontWeight: FontWeight.w600,
                color: PColors.text,
              ),
            ),
            TextButton(
              onPressed: () => context.go('/workshops'),
              child: Text(
                'Tümünü Gör',
                style: GoogleFonts.inter(
                  color: PColors.accent,
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 4),
        Text(
          'Projelere yönelik hazırlanan atölyeler',
          style: GoogleFonts.inter(fontSize: 14, color: PColors.textDim),
        ),
        const SizedBox(height: 16),

        SizedBox(
          height: 200,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.only(right: 16),
            itemCount: workshops.length,
            itemBuilder: (context, index) {
              final workshop = workshops[index];
              return Container(
                width: 300,
                margin: const EdgeInsets.only(right: 16),
                child: _buildWorkshopCard(context, workshop),
              );
            },
          ),
        ),
      ],
    );
  }

  Widget _buildVolunteerSection(BuildContext context, List<Task> allTasks) {
    final volunteerTasks = allTasks
        .where((task) => task.type == ProjectType.volunteer)
        .toList();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Gönüllülük Çalışması',
              style: GoogleFonts.poppins(
                fontSize: 20,
                fontWeight: FontWeight.w600,
                color: PColors.text,
              ),
            ),
            TextButton(
              onPressed: () => context.go('/community'),
              child: Text(
                'Tümünü Gör',
                style: GoogleFonts.inter(
                  color: PColors.success,
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 4),
        Text(
          'Topluma katkı sağlayacak anlamlı projeler',
          style: GoogleFonts.inter(fontSize: 14, color: PColors.textDim),
        ),
        const SizedBox(height: 16),

        SizedBox(
          height: 280,
          child: volunteerTasks.isEmpty
              ? _buildEmptyVolunteers()
              : ListView.builder(
                  scrollDirection: Axis.horizontal,
                  padding: const EdgeInsets.only(right: 16),
                  itemCount: volunteerTasks.length,
                  itemBuilder: (context, index) {
                    final task = volunteerTasks[index];
                    return Container(
                      width: 240,
                      margin: const EdgeInsets.only(right: 16),
                      child: _buildTaskCard(context, task, 100.0),
                    );
                  },
                ),
        ),
      ],
    );
  }

  Widget _buildTaskCard(BuildContext context, Task task, double matchScore) {
    return GlassMorphicCard(
      padding: EdgeInsets.zero,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Task Image
          SizedBox(
            height: 120,
            width: double.infinity,
            child: Stack(
              children: [
                ClipRRect(
                  borderRadius: const BorderRadius.vertical(
                    top: Radius.circular(20),
                  ),
                  child: ProjectImage(
                    imageUrl: task.imageUrl,
                    height: 120,
                    width: double.infinity,
                    fit: BoxFit.cover,
                  ),
                ),

                // Badges
                Positioned(
                  top: 8,
                  left: 8,
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 6,
                      vertical: 3,
                    ),
                    decoration: BoxDecoration(
                      color: task.typeColor,
                      borderRadius: BorderRadius.circular(6),
                    ),
                    child: Text(
                      task.typeDescription,
                      style: GoogleFonts.inter(
                        fontSize: 9,
                        color: Colors.white,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
                Positioned(
                  top: 8,
                  right: 8,
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 6,
                      vertical: 3,
                    ),
                    decoration: BoxDecoration(
                      color: PColors.accent,
                      borderRadius: BorderRadius.circular(6),
                    ),
                    child: Text(
                      '+${task.xpReward} XP',
                      style: GoogleFonts.inter(
                        fontSize: 9,
                        color: Colors.white,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
                if (matchScore > 70)
                  Positioned(
                    bottom: 8,
                    left: 8,
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 6,
                        vertical: 3,
                      ),
                      decoration: BoxDecoration(
                        color: PColors.success,
                        borderRadius: BorderRadius.circular(6),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const Icon(
                            LucideIcons.heart,
                            size: 8,
                            color: Colors.white,
                          ),
                          const SizedBox(width: 2),
                          Text(
                            '${matchScore.toInt()}% uyum',
                            style: GoogleFonts.inter(
                              fontSize: 8,
                              color: Colors.white,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
              ],
            ),
          ),

          // Task Content
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    task.title,
                    style: GoogleFonts.poppins(
                      fontSize: 14,
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
                      fontSize: 11,
                      color: PColors.textDim,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      const Icon(
                        LucideIcons.clock,
                        size: 12,
                        color: PColors.info,
                      ),
                      const SizedBox(width: 4),
                      Text(
                        '${task.estimatedHours}sa',
                        style: GoogleFonts.inter(
                          fontSize: 11,
                          color: PColors.info,
                        ),
                      ),
                      const SizedBox(width: 12),
                      const Icon(
                        LucideIcons.calendar,
                        size: 12,
                        color: PColors.accent,
                      ),
                      const SizedBox(width: 4),
                      Text(
                        '${task.remainingDays} gün',
                        style: GoogleFonts.inter(
                          fontSize: 11,
                          color: task.isUrgent
                              ? PColors.warning
                              : PColors.accent,
                        ),
                      ),
                    ],
                  ),
                  const Spacer(),
                  SizedBox(
                    width: double.infinity,
                    child: GlassButton(
                      label: task.isAvailable ? 'İncele' : 'Doldu',
                      onPressed: task.isAvailable
                          ? () {
                              _showTaskDetail(context, task, matchScore);
                            }
                          : null,
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

  Widget _buildWorkshopCard(BuildContext context, Workshop workshop) {
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
                  gradient: LinearGradient(
                    colors: [PColors.accent, PColors.accent.withValues(alpha: 0.7)],
                  ),
                  borderRadius: BorderRadius.circular(25),
                ),
                child: Center(
                  child: Text(
                    workshop.instructorName.split(' ').map((n) => n[0]).join(),
                    style: GoogleFonts.poppins(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: PColors.background,
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      workshop.title,
                      style: GoogleFonts.poppins(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: PColors.text,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    Text(
                      'Eğitmen: ${workshop.instructorName}',
                      style: GoogleFonts.inter(
                        fontSize: 11,
                        color: PColors.textDim,
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: workshop.isAvailable
                      ? PColors.success.withValues(alpha: 0.15)
                      : PColors.warning.withValues(alpha: 0.15),
                  borderRadius: BorderRadius.circular(8),
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
            ],
          ),

          const SizedBox(height: 12),

          Row(
            children: [
              Icon(LucideIcons.calendar, size: 14, color: PColors.info),
              const SizedBox(width: 6),
              Text(
                workshop.formattedDateTime,
                style: GoogleFonts.inter(
                  fontSize: 12,
                  color: PColors.text,
                  fontWeight: FontWeight.w500,
                ),
              ),
              const Spacer(),
              Icon(LucideIcons.users, size: 14, color: PColors.textDim),
              const SizedBox(width: 4),
              Text(
                '${workshop.currentParticipants}/${workshop.maxParticipants}',
                style: GoogleFonts.inter(fontSize: 12, color: PColors.textDim),
              ),
            ],
          ),

          const SizedBox(height: 12),

          GlassButton(
            label: workshop.isAvailable ? 'Kayıt Ol' : 'Kontenjan Dolu',
            onPressed: workshop.isAvailable
                ? () {
                    _showWorkshopDetail(context, workshop);
                  }
                : null,
          ),
        ],
      ),
    );
  }

  Widget _buildEmptyTasks() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: 80,
            height: 80,
            decoration: BoxDecoration(
              color: PColors.primary.withValues(alpha: 0.1),
              shape: BoxShape.circle,
            ),
            child: const Icon(
              LucideIcons.briefcase,
              size: 40,
              color: PColors.primary,
            ),
          ),
          const SizedBox(height: 16),
          Text(
            'Henüz İş Yok',
            style: GoogleFonts.poppins(
              fontSize: 16,
              fontWeight: FontWeight.w600,
              color: PColors.text,
            ),
          ),
          Text(
            'Yakında sana uygun işler eklenecek!',
            style: GoogleFonts.inter(fontSize: 12, color: PColors.textDim),
          ),
        ],
      ),
    );
  }

  Widget _buildEmptyVolunteers() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
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
          Text(
            'Yardıma ihtiyaç duyanlar seni bekliyor!',
            style: GoogleFonts.inter(fontSize: 12, color: PColors.textDim),
          ),
        ],
      ),
    );
  }

  void _showTaskDetail(BuildContext context, Task task, double matchScore) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      builder: (context) => TaskDetailSheet(task: task, matchScore: matchScore),
    );
  }

  void _showWorkshopDetail(BuildContext context, Workshop workshop) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      builder: (context) => WorkshopDetailSheet(workshop: workshop),
    );
  }

  Widget _buildProblemsSection(BuildContext context, WidgetRef ref) {
    final problemsAsync = ref.watch(recommendedProblemsProvider);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Problemler 🎯',
              style: GoogleFonts.poppins(
                fontSize: 20,
                fontWeight: FontWeight.w600,
                color: PColors.text,
              ),
            ),
            TextButton(
              onPressed: () => context.go('/problems'),
              child: Text(
                'Tümünü Gör',
                style: GoogleFonts.inter(
                  color: PColors.warning,
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 4),
        Text(
          'Çözüm bekleyen gerçek sorunlar',
          style: GoogleFonts.inter(fontSize: 14, color: PColors.textDim),
        ),
        const SizedBox(height: 16),

        SizedBox(
          height: 300,
          child: problemsAsync.when(
            data: (problems) {
              if (problems.isEmpty) {
                return _buildEmptyProblems();
              }

              return ListView.builder(
                scrollDirection: Axis.horizontal,
                padding: const EdgeInsets.only(right: 16),
                itemCount: problems.length.clamp(0, 10),
                itemBuilder: (context, index) {
                  final problem = problems[index];
                  final user = ref.watch(userProvider) ?? MockData.currentUser;
                  final matchScore = ref
                      .read(problemServiceProvider)
                      .calculateProblemMatch(user, problem);

                  return Container(
                    width: 240,
                    margin: const EdgeInsets.only(right: 16),
                    child: ProblemCard(
                      problem: problem,
                      matchScore: matchScore,
                      onTap: () {
                        _showProblemDetail(context, problem, matchScore);
                      },
                    ),
                  );
                },
              );
            },
            loading: () => Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CircularProgressIndicator(color: PColors.warning),
                  const SizedBox(height: 16),
                  Text(
                    'Problemler yükleniyor...',
                    style: GoogleFonts.inter(
                      fontSize: 14,
                      color: PColors.textDim,
                    ),
                  ),
                ],
              ),
            ),
            error: (error, stack) => Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    LucideIcons.triangleAlert,
                    size: 48,
                    color: PColors.warning,
                  ),
                  const SizedBox(height: 16),
                  Text(
                    'Problemler yüklenemedi',
                    style: GoogleFonts.poppins(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: PColors.text,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    error.toString(),
                    style: GoogleFonts.inter(
                      fontSize: 12,
                      color: PColors.textDim,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 16),
                  GlassButton(
                    label: 'Tekrar Dene',
                    onPressed: () => ref.refresh(recommendedProblemsProvider),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildEmptyProblems() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: 80,
            height: 80,
            decoration: BoxDecoration(
              color: PColors.warning.withValues(alpha: 0.1),
              shape: BoxShape.circle,
            ),
            child: const Icon(
              LucideIcons.lightbulb,
              size: 40,
              color: PColors.warning,
            ),
          ),
          const SizedBox(height: 16),
          Text(
            'Henüz Problem Yok',
            style: GoogleFonts.poppins(
              fontSize: 16,
              fontWeight: FontWeight.w600,
              color: PColors.text,
            ),
          ),
          Text(
            'Yakında çözülmeyi bekleyen problemler eklenecek!',
            style: GoogleFonts.inter(fontSize: 12, color: PColors.textDim),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  void _showProblemDetail(BuildContext context, problem, double matchScore) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      builder: (context) => ProblemDetailSheet(
        problem: problem,
        matchScore: matchScore,
      ),
    );
  }
}
