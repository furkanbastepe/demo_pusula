import '../models/partner_organization.dart';

class PartnerService {
  static final List<PartnerOrganization> _partners = [];

  Future<List<PartnerOrganization>> getAllPartners() async {
    await Future.delayed(const Duration(milliseconds: 300));
    return List.from(_partners);
  }

  Future<void> invitePartner(String name, String email, PartnerType type) async {
    await Future.delayed(const Duration(milliseconds: 500));
    // Send invitation email logic here
  }
}
