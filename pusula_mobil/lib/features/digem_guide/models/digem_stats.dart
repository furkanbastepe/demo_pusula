// ═══════════════════════════════════════════════════════════════════════════════════
// 📊 DIGEM STATS MODEL
// ═══════════════════════════════════════════════════════════════════════════════════

class DigemStats {
  final int registeredYouth;
  final int activeWorkshops;
  final int activeProjects;
  final int totalApplications;
  final int completedProjects;
  final int activePartners;
  final int thisMonthGraduates;

  const DigemStats({
    required this.registeredYouth,
    required this.activeWorkshops,
    required this.activeProjects,
    required this.totalApplications,
    required this.completedProjects,
    required this.activePartners,
    this.thisMonthGraduates = 0,
  });

  factory DigemStats.fromJson(Map<String, dynamic> json) {
    return DigemStats(
      registeredYouth: json['registeredYouth'] as int? ?? 0,
      activeWorkshops: json['activeWorkshops'] as int? ?? 0,
      activeProjects: json['activeProjects'] as int? ?? 0,
      totalApplications: json['totalApplications'] as int? ?? 0,
      completedProjects: json['completedProjects'] as int? ?? 0,
      activePartners: json['activePartners'] as int? ?? 0,
      thisMonthGraduates: json['thisMonthGraduates'] as int? ?? 0,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'registeredYouth': registeredYouth,
      'activeWorkshops': activeWorkshops,
      'activeProjects': activeProjects,
      'totalApplications': totalApplications,
      'completedProjects': completedProjects,
      'activePartners': activePartners,
      'thisMonthGraduates': thisMonthGraduates,
    };
  }

  DigemStats copyWith({
    int? registeredYouth,
    int? activeWorkshops,
    int? activeProjects,
    int? totalApplications,
    int? completedProjects,
    int? activePartners,
    int? thisMonthGraduates,
  }) {
    return DigemStats(
      registeredYouth: registeredYouth ?? this.registeredYouth,
      activeWorkshops: activeWorkshops ?? this.activeWorkshops,
      activeProjects: activeProjects ?? this.activeProjects,
      totalApplications: totalApplications ?? this.totalApplications,
      completedProjects: completedProjects ?? this.completedProjects,
      activePartners: activePartners ?? this.activePartners,
      thisMonthGraduates: thisMonthGraduates ?? this.thisMonthGraduates,
    );
  }

  static const DigemStats empty = DigemStats(
    registeredYouth: 0,
    activeWorkshops: 0,
    activeProjects: 0,
    totalApplications: 0,
    completedProjects: 0,
    activePartners: 0,
    thisMonthGraduates: 0,
  );
}
