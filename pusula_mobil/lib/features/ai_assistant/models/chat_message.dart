import 'package:freezed_annotation/freezed_annotation.dart';

part 'chat_message.freezed.dart';
part 'chat_message.g.dart';

// ═══════════════════════════════════════════════════════════════════════════════════
// 💬 CHAT MESSAGE MODEL
// ═══════════════════════════════════════════════════════════════════════════════════

@freezed
class ChatMessage with _$ChatMessage {
  const factory ChatMessage({
    required String id,
    required String content,
    required MessageRole role,
    required DateTime timestamp,
    @Default(false) bool isLoading,
  }) = _ChatMessage;

  factory ChatMessage.fromJson(Map<String, dynamic> json) =>
      _$ChatMessageFromJson(json);
}

enum MessageRole {
  user,
  assistant,
  system,
}
