import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/chat_message.dart';
import '../services/gemini_service.dart';

// ═══════════════════════════════════════════════════════════════════════════════════
// 🤖 AI ASSISTANT PROVIDER
// ═══════════════════════════════════════════════════════════════════════════════════

// TODO: API key'i environment variable'dan al
const String _geminiApiKey = 'AIzaSyD5QJBALbiQdVGLQxRHDja4-K3Ml6m2EPU';

final geminiServiceProvider = Provider<GeminiService>((ref) {
  return GeminiService(_geminiApiKey);
});

final chatMessagesProvider =
    StateNotifierProvider<ChatMessagesNotifier, List<ChatMessage>>((ref) {
      return ChatMessagesNotifier(ref.read(geminiServiceProvider));
    });

class ChatMessagesNotifier extends StateNotifier<List<ChatMessage>> {
  final GeminiService _geminiService;

  ChatMessagesNotifier(this._geminiService) : super([]) {
    _addWelcomeMessage();
  }

  void _addWelcomeMessage() {
    final welcomeMessage = ChatMessage(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      content:
          'Merhaba! 👋 Ben PUSULA AI asistanınım. Python, SQL öğrenmen veya projeler hakkında sorularına yardımcı olabilirim. Ne öğrenmek istersin?',
      role: MessageRole.assistant,
      timestamp: DateTime.now(),
    );
    state = [welcomeMessage];
  }

  Future<void> sendMessage(String content, {String? lessonContext}) async {
    // Kullanıcı mesajını ekle
    final userMessage = ChatMessage(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      content: content,
      role: MessageRole.user,
      timestamp: DateTime.now(),
    );

    state = [...state, userMessage];

    // Loading mesajı ekle
    final loadingMessage = ChatMessage(
      id: '${DateTime.now().millisecondsSinceEpoch}_loading',
      content: '...',
      role: MessageRole.assistant,
      timestamp: DateTime.now(),
      isLoading: true,
    );

    state = [...state, loadingMessage];

    try {
      // AI'dan cevap al
      final response = await _geminiService.sendMessage(
        content,
        lessonContext: lessonContext,
      );

      // Loading mesajını kaldır ve gerçek cevabı ekle
      state = state.where((msg) => !msg.isLoading).toList();

      final assistantMessage = ChatMessage(
        id: DateTime.now().millisecondsSinceEpoch.toString(),
        content: response,
        role: MessageRole.assistant,
        timestamp: DateTime.now(),
      );

      state = [...state, assistantMessage];
    } catch (e) {
      // Hata durumunda loading'i kaldır
      state = state.where((msg) => !msg.isLoading).toList();

      final errorMessage = ChatMessage(
        id: DateTime.now().millisecondsSinceEpoch.toString(),
        content: 'Üzgünüm, bir hata oluştu. Lütfen tekrar dene.',
        role: MessageRole.assistant,
        timestamp: DateTime.now(),
      );

      state = [...state, errorMessage];
    }
  }

  void clearChat() {
    _geminiService.resetChat();
    state = [];
    _addWelcomeMessage();
  }
}
