import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/models.dart';

// ═══════════════════════════════════════════════════════════════════════════════════
// 🎯 TEAM SERVICE - Problem-Based Learning
// ═══════════════════════════════════════════════════════════════════════════════════

class TeamService {
  // Singleton pattern
  static final TeamService _instance = TeamService._internal();
  factory TeamService() => _instance;
  TeamService._internal();

  // ═══════════════════════════════════════════════════════════════════════════════════
  // TEAM MANAGEMENT
  // ═══════════════════════════════════════════════════════════════════════════════════

  /// Get team by ID
  Future<WorkshopTeam?> getTeam(String teamId) async {
    // In production, this would query from backend
    // For now, we'll search through workshops
    final prefs = await SharedPreferences.getInstance();
    final keys = prefs.getKeys().where((k) => k.startsWith('workshop_'));

    for (final key in keys) {
      try {
        final jsonString = prefs.getString(key);
        if (jsonString != null) {
          final json = jsonDecode(jsonString) as Map<String, dynamic>;
          final workshop = SolutionWorkshop.fromJson(json);
          
          final team = workshop.teams.firstWhere(
            (t) => t.id == teamId,
            orElse: () => throw Exception('Team not found'),
          );
          
          return team;
        }
      } catch (e) {
        continue;
      }
    }

    return null;
  }

  /// Update team progress
  Future<void> updateTeamProgress(String teamId, TeamProgress progress) async {
    // This would update the team's progress in the workshop
    // Implementation would involve loading workshop, updating team, and saving
    final prefs = await SharedPreferences.getInstance();
    final key = 'team_progress_$teamId';
    final json = jsonEncode(progress.toJson());
    await prefs.setString(key, json);
  }

  /// Add deliverable to team
  Future<void> addDeliverable(String teamId, TeamDeliverable deliverable) async {
    // Store deliverable
    final prefs = await SharedPreferences.getInstance();
    final key = 'team_deliverables_$teamId';
    final existing = prefs.getStringList(key) ?? [];
    existing.add(jsonEncode(deliverable.toJson()));
    await prefs.setStringList(key, existing);
  }

  // ═══════════════════════════════════════════════════════════════════════════════════
  // COMMUNICATION
  // ═══════════════════════════════════════════════════════════════════════════════════

  /// Send message to team
  Future<void> sendTeamMessage(
    String teamId,
    String senderId,
    String message,
  ) async {
    final messageId = 'msg_${DateTime.now().millisecondsSinceEpoch}';
    final teamMessage = TeamMessage(
      id: messageId,
      teamId: teamId,
      senderId: senderId,
      senderName: 'User', // In production, would fetch from user service
      message: message,
      sentAt: DateTime.now(),
    );

    final prefs = await SharedPreferences.getInstance();
    final key = 'team_messages_$teamId';
    final existing = prefs.getStringList(key) ?? [];
    existing.add(jsonEncode(teamMessage.toJson()));
    await prefs.setStringList(key, existing);
  }

  /// Get team messages
  Future<List<TeamMessage>> getTeamMessages(String teamId) async {
    final prefs = await SharedPreferences.getInstance();
    final key = 'team_messages_$teamId';
    final messagesJson = prefs.getStringList(key) ?? [];

    return messagesJson.map((jsonString) {
      final json = jsonDecode(jsonString) as Map<String, dynamic>;
      return TeamMessage.fromJson(json);
    }).toList();
  }

  /// Send message to organization
  Future<void> sendOrganizationMessage(
    String workshopId,
    String message,
  ) async {
    final messageId = 'org_msg_${DateTime.now().millisecondsSinceEpoch}';
    final orgMessage = {
      'id': messageId,
      'workshopId': workshopId,
      'message': message,
      'sentAt': DateTime.now().toIso8601String(),
      'isFromTeam': true,
    };

    final prefs = await SharedPreferences.getInstance();
    final key = 'org_messages_$workshopId';
    final existing = prefs.getStringList(key) ?? [];
    existing.add(jsonEncode(orgMessage));
    await prefs.setStringList(key, existing);
  }

  /// Get organization messages
  Future<List<Map<String, dynamic>>> getOrganizationMessages(
    String workshopId,
  ) async {
    final prefs = await SharedPreferences.getInstance();
    final key = 'org_messages_$workshopId';
    final messagesJson = prefs.getStringList(key) ?? [];

    return messagesJson.map((jsonString) {
      return jsonDecode(jsonString) as Map<String, dynamic>;
    }).toList();
  }
}
