import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import '../../../core/core.dart';
import '../../../widgets/common/common.dart';
import '../../../providers/user_provider.dart';
import '../models/models.dart';
import '../providers/providers.dart';
import '../widgets/problem_card.dart';
import 'problem_detail_screen.dart';

// ═══════════════════════════════════════════════════════════════════════════════════
// 🎯 PROBLEMS LIST SCREEN - Problem-Based Learning
// ═══════════════════════════════════════════════════════════════════════════════════

class ProblemsListScreen extends ConsumerStatefulWidget {
  const ProblemsListScreen({super.key});

  @override
  ConsumerState<ProblemsListScreen> createState() => _ProblemsListScreenState();
}

class _ProblemsListScreenState extends ConsumerState<ProblemsListScreen> {
  String _searchQuery = '';
  ImpactArea? _selectedImpactArea;

  @override
  Widget build(BuildContext context) {
    final problemsAsync = ref.watch(problemsProvider);

    return Scaffold(
      backgroundColor: PColors.background,
      body: CustomScrollView(
        slivers: [
          // AppBar
          SliverAppBar(
            floating: true,
            snap: true,
            backgroundColor: PColors.surface,
            leading: IconButton(
              icon: const Icon(LucideIcons.arrowLeft, color: PColors.text),
              onPressed: () => Navigator.pop(context),
            ),
            title: Text(
              'Problemler',
              style: GoogleFonts.poppins(
                color: PColors.text,
                fontSize: 20,
                fontWeight: FontWeight.w600,
              ),
            ),
            actions: [
              IconButton(
                icon: Icon(LucideIcons.settings, color: PColors.warning),
                onPressed: _showFilterDialog,
              ),
            ],
          ),

          // Search bar
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: _buildSearchBar(),
            ),
          ),

          // Filter chips
          if (_selectedImpactArea != null)
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: _buildActiveFilters(),
              ),
            ),

          // Problems grid
          problemsAsync.when(
            data: (problems) {
              final filteredProblems = _filterProblems(problems);

              if (filteredProblems.isEmpty) {
                return SliverFillRemaining(
                  child: _buildEmptyState(),
                );
              }

              return SliverPadding(
                padding: const EdgeInsets.all(16),
                sliver: SliverGrid(
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    childAspectRatio: 0.62,
                    crossAxisSpacing: 16,
                    mainAxisSpacing: 16,
                  ),
                  delegate: SliverChildBuilderDelegate(
                    (context, index) {
                      final problem = filteredProblems[index];
                      final user = ref.watch(userProvider);
                      final matchScore = user != null
                          ? ref
                              .read(problemServiceProvider)
                              .calculateProblemMatch(user, problem)
                          : 0.0;

                      return ProblemCard(
                        problem: problem,
                        matchScore: matchScore,
                        onTap: () => _showProblemDetail(problem, matchScore),
                      ).animate(delay: (index * 50).ms).fadeIn().scale();
                    },
                    childCount: filteredProblems.length,
                  ),
                ),
              );
            },
            loading: () => SliverFillRemaining(
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const CircularProgressIndicator(color: PColors.warning),
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
            ),
            error: (error, stack) => SliverFillRemaining(
              child: _buildErrorState(error.toString()),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSearchBar() {
    return GlassMorphicCard(
      child: TextField(
        onChanged: (value) {
          setState(() {
            _searchQuery = value;
          });
        },
        style: GoogleFonts.inter(color: PColors.text),
        decoration: InputDecoration(
          hintText: 'Problem ara...',
          hintStyle: GoogleFonts.inter(color: PColors.textDim),
          prefixIcon: const Icon(LucideIcons.search, color: PColors.textDim),
          border: InputBorder.none,
          contentPadding: const EdgeInsets.symmetric(vertical: 12),
        ),
      ),
    );
  }

  Widget _buildActiveFilters() {
    return Wrap(
      spacing: 8,
      children: [
        if (_selectedImpactArea != null)
          Chip(
            label: Text(
              _selectedImpactArea!.displayName,
              style: GoogleFonts.inter(
                fontSize: 12,
                color: Colors.white,
              ),
            ),
            backgroundColor: _selectedImpactArea!.color,
            deleteIcon: const Icon(LucideIcons.x, size: 16, color: Colors.white),
            onDeleted: () {
              setState(() {
                _selectedImpactArea = null;
              });
            },
          ),
      ],
    );
  }

  List<Problem> _filterProblems(List<Problem> problems) {
    var filtered = problems;

    // Search filter
    if (_searchQuery.isNotEmpty) {
      filtered = filtered.where((p) {
        return p.title.toLowerCase().contains(_searchQuery.toLowerCase()) ||
            p.organization.toLowerCase().contains(_searchQuery.toLowerCase()) ||
            p.description.toLowerCase().contains(_searchQuery.toLowerCase());
      }).toList();
    }

    // Impact area filter
    if (_selectedImpactArea != null) {
      filtered = filtered
          .where((p) => p.impactArea == _selectedImpactArea)
          .toList();
    }

    return filtered;
  }

  void _showFilterDialog() {
    showDialog(
      context: context,
      builder: (context) => Dialog(
        backgroundColor: Colors.transparent,
        child: GlassMorphicCard(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Filtrele',
                style: GoogleFonts.poppins(
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                  color: PColors.text,
                ),
              ),
              const SizedBox(height: 16),
              Text(
                'Etki Alanı',
                style: GoogleFonts.inter(
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                  color: PColors.textDim,
                ),
              ),
              const SizedBox(height: 12),
              Wrap(
                spacing: 8,
                runSpacing: 8,
                children: ImpactArea.values.map((area) {
                  final isSelected = _selectedImpactArea == area;
                  return GestureDetector(
                    onTap: () {
                      setState(() {
                        _selectedImpactArea = isSelected ? null : area;
                      });
                      Navigator.pop(context);
                    },
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 8,
                      ),
                      decoration: BoxDecoration(
                        color: isSelected
                            ? area.color
                            : area.color.withValues(alpha: 0.15),
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(
                          color: area.color.withValues(alpha: 0.3),
                        ),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(
                            area.icon,
                            size: 16,
                            color: isSelected ? Colors.white : area.color,
                          ),
                          const SizedBox(width: 6),
                          Text(
                            area.displayName,
                            style: GoogleFonts.inter(
                              fontSize: 12,
                              color: isSelected ? Colors.white : area.color,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                }).toList(),
              ),
              const SizedBox(height: 16),
              SizedBox(
                width: double.infinity,
                child: GlassButton(
                  label: 'Filtreleri Temizle',
                  onPressed: () {
                    setState(() {
                      _selectedImpactArea = null;
                    });
                    Navigator.pop(context);
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildEmptyState() {
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
              LucideIcons.searchX,
              size: 40,
              color: PColors.warning,
            ),
          ),
          const SizedBox(height: 16),
          Text(
            'Problem Bulunamadı',
            style: GoogleFonts.poppins(
              fontSize: 16,
              fontWeight: FontWeight.w600,
              color: PColors.text,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'Arama kriterlerinizi değiştirmeyi deneyin',
            style: GoogleFonts.inter(
              fontSize: 12,
              color: PColors.textDim,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  Widget _buildErrorState(String error) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(
            LucideIcons.triangleAlert,
            size: 64,
            color: PColors.warning,
          ),
          const SizedBox(height: 16),
          Text(
            'Hata Oluştu',
            style: GoogleFonts.poppins(
              fontSize: 18,
              fontWeight: FontWeight.w600,
              color: PColors.text,
            ),
          ),
          const SizedBox(height: 8),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 32),
            child: Text(
              error,
              style: GoogleFonts.inter(
                fontSize: 14,
                color: PColors.textDim,
              ),
              textAlign: TextAlign.center,
            ),
          ),
          const SizedBox(height: 16),
          GlassButton(
            label: 'Tekrar Dene',
            onPressed: () {
              ref.invalidate(problemsProvider);
            },
          ),
        ],
      ),
    );
  }

  void _showProblemDetail(Problem problem, double matchScore) {
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
