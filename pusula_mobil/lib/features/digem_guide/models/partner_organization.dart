// ═══════════════════════════════════════════════════════════════════════════════════
// 🏢 PARTNER ORGANIZATION MODEL
// ═══════════════════════════════════════════════════════════════════════════════════

enum PartnerType {
  kobi,
  belediye,
  ngo,
  corporate,
}

class PartnerOrganization {
  final String id;
  final String name;
  final String contactEmail;
  final String contactPhone;
  final String address;
  final PartnerType type;
  final int activeProjects;
  final int completedProjects;
  final DateTime joinedAt;
  final bool isActive;

  const PartnerOrganization({
    required this.id,
    required this.name,
    required this.contactEmail,
    required this.contactPhone,
    required this.address,
    required this.type,
    required this.activeProjects,
    required this.completedProjects,
    required this.joinedAt,
    this.isActive = true,
  });

  factory PartnerOrganization.fromJson(Map<String, dynamic> json) {
    return PartnerOrganization(
      id: json['id'] as String,
      name: json['name'] as String,
      contactEmail: json['contactEmail'] as String,
      contactPhone: json['contactPhone'] as String,
      address: json['address'] as String,
      type: PartnerType.values.firstWhere(
        (e) => e.name == json['type'],
        orElse: () => PartnerType.kobi,
      ),
      activeProjects: json['activeProjects'] as int? ?? 0,
      completedProjects: json['completedProjects'] as int? ?? 0,
      joinedAt: json['joinedAt'] != null
          ? DateTime.parse(json['joinedAt'] as String)
          : DateTime.now(),
      isActive: json['isActive'] as bool? ?? true,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'contactEmail': contactEmail,
      'contactPhone': contactPhone,
      'address': address,
      'type': type.name,
      'activeProjects': activeProjects,
      'completedProjects': completedProjects,
      'joinedAt': joinedAt.toIso8601String(),
      'isActive': isActive,
    };
  }

  PartnerOrganization copyWith({
    String? id,
    String? name,
    String? contactEmail,
    String? contactPhone,
    String? address,
    PartnerType? type,
    int? activeProjects,
    int? completedProjects,
    DateTime? joinedAt,
    bool? isActive,
  }) {
    return PartnerOrganization(
      id: id ?? this.id,
      name: name ?? this.name,
      contactEmail: contactEmail ?? this.contactEmail,
      contactPhone: contactPhone ?? this.contactPhone,
      address: address ?? this.address,
      type: type ?? this.type,
      activeProjects: activeProjects ?? this.activeProjects,
      completedProjects: completedProjects ?? this.completedProjects,
      joinedAt: joinedAt ?? this.joinedAt,
      isActive: isActive ?? this.isActive,
    );
  }

  String get typeLabel {
    switch (type) {
      case PartnerType.kobi:
        return 'KOBİ';
      case PartnerType.belediye:
        return 'Belediye';
      case PartnerType.ngo:
        return 'STK';
      case PartnerType.corporate:
        return 'Kurumsal';
    }
  }

  int get totalProjects => activeProjects + completedProjects;
}
