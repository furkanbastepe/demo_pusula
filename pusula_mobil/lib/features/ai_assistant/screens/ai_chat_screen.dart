import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import '../../../core/core.dart';
import '../models/chat_message.dart';
import '../providers/ai_assistant_provider.dart';

// ═══════════════════════════════════════════════════════════════════════════════════
// 🤖 AI CHAT SCREEN
// ═══════════════════════════════════════════════════════════════════════════════════

class AIChatScreen extends HookConsumerWidget {
  final String? lessonContext;
  final String? simulationId;
  final String? taskId;
  final String? projectName;
  final String? taskName;

  const AIChatScreen({
    super.key,
    this.lessonContext,
    this.simulationId,
    this.taskId,
    this.projectName,
    this.taskName,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final messages = ref.watch(chatMessagesProvider);
    final textController = useTextEditingController();
    final scrollController = useScrollController();

    // Auto-scroll to bottom when new message arrives
    useEffect(() {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (scrollController.hasClients) {
          scrollController.animateTo(
            scrollController.position.maxScrollExtent,
            duration: const Duration(milliseconds: 300),
            curve: Curves.easeOut,
          );
        }
      });
      return null;
    }, [messages.length]);

    return Scaffold(
      backgroundColor: Colors.transparent,
      body: SafeArea(
        child: Column(
          children: [
                // App Bar
                Container(
                  padding: const EdgeInsets.all(16),
                  child: Row(
                    children: [
                      IconButton(
                        icon: const Icon(LucideIcons.arrowLeft,
                            color: PColors.text),
                        onPressed: () => Navigator.pop(context),
                      ),
                      const SizedBox(width: 8),
                      Container(
                        padding: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          color: PColors.primary.withValues(alpha: 0.15),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: const Icon(
                          LucideIcons.bot,
                          color: PColors.primary,
                          size: 24,
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'PUSULA AI',
                              style: GoogleFonts.poppins(
                                fontSize: 18,
                                fontWeight: FontWeight.w600,
                                color: PColors.text,
                              ),
                            ),
                            Text(
                              projectName != null && taskName != null
                                  ? 'Proje: $projectName - $taskName'
                                  : 'Öğrenme Asistanın',
                              style: GoogleFonts.inter(
                                fontSize: 12,
                                color: PColors.textDim,
                              ),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ],
                        ),
                      ),
                      IconButton(
                        icon: const Icon(LucideIcons.refreshCw,
                            color: PColors.textDim),
                        onPressed: () {
                          ref.read(chatMessagesProvider.notifier).clearChat();
                        },
                      ),
                    ],
                  ),
                ),

                // Messages List
                Expanded(
                  child: messages.isEmpty
                      ? _buildEmptyState(ref, textController)
                      : ListView.builder(
                          controller: scrollController,
                          padding: const EdgeInsets.all(16),
                          itemCount: messages.length,
                          itemBuilder: (context, index) {
                            final message = messages[index];
                            return _MessageBubble(message: message)
                                .animate(delay: (index * 50).ms)
                                .fadeIn()
                                .slideY(begin: 0.2);
                          },
                        ),
                ),

                // Input Field
                Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: PColors.surface.withValues(alpha: 0.95),
                    border: const Border(
                      top: BorderSide(color: PColors.border, width: 1),
                    ),
                  ),
                  child: Row(
                    children: [
                      Expanded(
                        child: TextField(
                          controller: textController,
                          style: GoogleFonts.inter(
                            fontSize: 14,
                            color: PColors.text,
                          ),
                          decoration: InputDecoration(
                            hintText: 'Bir soru sor...',
                            hintStyle: GoogleFonts.inter(
                              fontSize: 14,
                              color: PColors.textDim,
                            ),
                            filled: true,
                            fillColor: PColors.surfaceHi,
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(25),
                              borderSide: BorderSide.none,
                            ),
                            contentPadding: const EdgeInsets.symmetric(
                              horizontal: 20,
                              vertical: 12,
                            ),
                          ),
                          keyboardType: TextInputType.text,
                          textCapitalization: TextCapitalization.sentences,
                          enableIMEPersonalizedLearning: true,
                          autocorrect: true,
                          enableSuggestions: true,
                          maxLines: null,
                          textInputAction: TextInputAction.send,
                          onSubmitted: (value) {
                            if (value.trim().isNotEmpty) {
                              ref
                                  .read(chatMessagesProvider.notifier)
                                  .sendMessage(
                                    value.trim(),
                                    lessonContext: lessonContext,
                                  );
                              textController.clear();
                            }
                          },
                        ),
                      ),
                      const SizedBox(width: 8),
                      Container(
                        decoration: BoxDecoration(
                          color: PColors.primary,
                          borderRadius: BorderRadius.circular(25),
                        ),
                        child: IconButton(
                          icon: const Icon(
                            LucideIcons.send,
                            color: Colors.white,
                            size: 20,
                          ),
                          onPressed: () {
                            final text = textController.text.trim();
                            if (text.isNotEmpty) {
                              ref
                                  .read(chatMessagesProvider.notifier)
                                  .sendMessage(
                                    text,
                                    lessonContext: lessonContext,
                                  );
                              textController.clear();
                            }
                          },
                        ),
                      ),
                    ],
                  ),
                ),
          ],
        ),
      ),
    );
  }

  Widget _buildEmptyState(WidgetRef ref, TextEditingController textController) {
    // Generate suggested questions based on context
    final List<String> suggestedQuestions = taskId != null
        ? [
            'Bu taskı nasıl başlamalıyım?',
            'Hangi araçları kullanmalıyım?',
            'Örnek bir çıktı gösterir misin?',
            'Sık yapılan hatalar neler?',
          ]
        : [
            'Bu konuyu nasıl öğrenebilirim?',
            'Örneklerle açıklar mısın?',
            'Pratik yapmak için ne yapmalıyım?',
            'İlgili kaynaklar önerir misin?',
          ];

    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const SizedBox(height: 40),
          const Icon(
            LucideIcons.bot,
            size: 64,
            color: PColors.primary,
          ),
          const SizedBox(height: 16),
          Text(
            'Merhaba! 👋',
            style: GoogleFonts.poppins(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: PColors.text,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            taskId != null
                ? 'Bu görevde sana nasıl yardımcı olabilirim?'
                : 'Sana nasıl yardımcı olabilirim?',
            style: GoogleFonts.inter(
              fontSize: 14,
              color: PColors.textDim,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 32),
          // Suggested Questions
          Text(
            'Önerilen Sorular',
            style: GoogleFonts.poppins(
              fontSize: 16,
              fontWeight: FontWeight.w600,
              color: PColors.text,
            ),
          ),
          const SizedBox(height: 16),
          ...suggestedQuestions.map((question) {
            return Padding(
              padding: const EdgeInsets.only(bottom: 12),
              child: InkWell(
                onTap: () {
                  ref.read(chatMessagesProvider.notifier).sendMessage(
                        question,
                        lessonContext: lessonContext,
                      );
                },
                borderRadius: BorderRadius.circular(12),
                child: Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: PColors.surface.withValues(alpha: 0.8),
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(
                      color: PColors.border.withValues(alpha: 0.3),
                      width: 1,
                    ),
                  ),
                  child: Row(
                    children: [
                      const Icon(
                        LucideIcons.messageCircle,
                        size: 18,
                        color: PColors.primary,
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Text(
                          question,
                          style: GoogleFonts.inter(
                            fontSize: 14,
                            color: PColors.text,
                          ),
                        ),
                      ),
                      const Icon(
                        LucideIcons.arrowRight,
                        size: 16,
                        color: PColors.textDim,
                      ),
                    ],
                  ),
                ),
              ).animate().fadeIn(delay: (suggestedQuestions.indexOf(question) * 100).ms),
            );
          }),
        ],
      ),
    );
  }
}

class _MessageBubble extends StatelessWidget {
  final ChatMessage message;

  const _MessageBubble({required this.message});

  @override
  Widget build(BuildContext context) {
    final isUser = message.role == MessageRole.user;

    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: Row(
        mainAxisAlignment:
            isUser ? MainAxisAlignment.end : MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (!isUser) ...[
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: PColors.primary.withValues(alpha: 0.15),
                borderRadius: BorderRadius.circular(12),
              ),
              child: const Icon(
                LucideIcons.bot,
                color: PColors.primary,
                size: 20,
              ),
            ),
            const SizedBox(width: 8),
          ],
          Flexible(
            child: Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: isUser
                    ? PColors.primary
                    : PColors.surface.withValues(alpha: 0.8),
                borderRadius: BorderRadius.circular(20),
                border: Border.all(
                  color: isUser
                      ? PColors.primary
                      : PColors.border.withValues(alpha: 0.3),
                  width: 1,
                ),
              ),
              child: message.isLoading
                  ? Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        SizedBox(
                          width: 16,
                          height: 16,
                          child: CircularProgressIndicator(
                            strokeWidth: 2,
                            valueColor: AlwaysStoppedAnimation<Color>(
                              PColors.primary,
                            ),
                          ),
                        ),
                        const SizedBox(width: 12),
                        Text(
                          'Düşünüyorum...',
                          style: GoogleFonts.inter(
                            fontSize: 14,
                            color: PColors.textDim,
                          ),
                        ),
                      ],
                    )
                  : Text(
                      message.content,
                      style: GoogleFonts.inter(
                        fontSize: 14,
                        color: isUser ? Colors.white : PColors.text,
                        height: 1.5,
                      ),
                    ),
            ),
          ),
          if (isUser) ...[
            const SizedBox(width: 8),
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: PColors.primary.withValues(alpha: 0.15),
                borderRadius: BorderRadius.circular(12),
              ),
              child: const Icon(
                LucideIcons.user,
                color: PColors.primary,
                size: 20,
              ),
            ),
          ],
        ],
      ),
    );
  }
}
