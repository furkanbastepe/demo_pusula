import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';

import '../../../core/theme/colors.dart';
import '../../../widgets/common/glass_morphic_card.dart';
import '../models/models.dart';

/// AI Validation Dialog
///
/// Shows a conversational interface for validating user's work.
/// Asks validation questions and evaluates answers.
class AIValidationDialog extends StatefulWidget {
  final List<ValidationQuestion> questions;
  final Function(bool passed) onComplete;

  const AIValidationDialog({
    super.key,
    required this.questions,
    required this.onComplete,
  });

  @override
  State<AIValidationDialog> createState() => _AIValidationDialogState();
}

class _AIValidationDialogState extends State<AIValidationDialog> {
  int currentQuestionIndex = 0;
  final List<String> userAnswers = [];
  final TextEditingController _controller = TextEditingController();
  bool isThinking = false;
  String? feedback;
  bool? isCorrect;

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _submitAnswer() {
    if (_controller.text.trim().isEmpty) return;

    setState(() {
      isThinking = true;
      feedback = null;
      isCorrect = null;
    });

    final answer = _controller.text.trim();
    userAnswers.add(answer);

    // Simulate AI evaluation (simple keyword matching)
    Future.delayed(const Duration(seconds: 1), () {
      final question = widget.questions[currentQuestionIndex];
      final keywords = question.expectedKeywords.toLowerCase().split(',');
      final answerLower = answer.toLowerCase();

      final correct = keywords.any((keyword) => answerLower.contains(keyword.trim()));

      setState(() {
        isThinking = false;
        isCorrect = correct;
        feedback = correct
            ? 'Harika! Doğru cevap! 🎉'
            : question.hint;
      });

      if (correct) {
        // Move to next question after delay
        Future.delayed(const Duration(seconds: 2), () {
          if (currentQuestionIndex < widget.questions.length - 1) {
            setState(() {
              currentQuestionIndex++;
              _controller.clear();
              feedback = null;
              isCorrect = null;
            });
          } else {
            // All questions answered correctly
            widget.onComplete(true);
            Navigator.of(context).pop();
          }
        });
      }
    });
  }

  void _retry() {
    setState(() {
      _controller.clear();
      feedback = null;
      isCorrect = null;
    });
  }

  @override
  Widget build(BuildContext context) {
    final question = widget.questions[currentQuestionIndex];

    return Dialog(
      backgroundColor: Colors.transparent,
      child: Container(
        constraints: const BoxConstraints(maxWidth: 500, maxHeight: 600),
        child: GlassMorphicCard(
          child: Padding(
            padding: const EdgeInsets.all(24),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Header
                Row(
                  children: [
                    Container(
                      width: 48,
                      height: 48,
                      decoration: BoxDecoration(
                        color: PColors.primary.withValues(alpha: 0.15),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Icon(
                        LucideIcons.sparkles,
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
                            'Çalışmanı Doğrulayalım',
                            style: GoogleFonts.poppins(
                              color: PColors.text,
                              fontSize: 18,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          Text(
                            'Soru ${currentQuestionIndex + 1}/${widget.questions.length}',
                            style: GoogleFonts.inter(
                              color: PColors.textDim,
                              fontSize: 12,
                            ),
                          ),
                        ],
                      ),
                    ),
                    IconButton(
                      icon: Icon(LucideIcons.x, color: PColors.textDim),
                      onPressed: () => Navigator.of(context).pop(),
                    ),
                  ],
                ).animate().fadeIn().slideY(begin: -0.2),

                const SizedBox(height: 24),

                // Progress
                ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: LinearProgressIndicator(
                    value: (currentQuestionIndex + 1) / widget.questions.length,
                    backgroundColor: PColors.surface,
                    valueColor: AlwaysStoppedAnimation(PColors.primary),
                    minHeight: 6,
                  ),
                ).animate(delay: 100.ms).fadeIn().scaleX(),

                const SizedBox(height: 24),

                // Question
                Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: PColors.surface.withValues(alpha: 0.5),
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(
                      color: PColors.border.withValues(alpha: 0.3),
                    ),
                  ),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Icon(
                        LucideIcons.messageCircle,
                        color: PColors.primary,
                        size: 20,
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Text(
                          question.question,
                          style: GoogleFonts.inter(
                            color: PColors.text,
                            fontSize: 15,
                            height: 1.5,
                          ),
                        ),
                      ),
                    ],
                  ),
                ).animate(delay: 200.ms).fadeIn().slideY(begin: 0.2),

                const SizedBox(height: 16),

                // Answer Input
                TextField(
                  controller: _controller,
                  enabled: !isThinking && isCorrect != true,
                  maxLines: 3,
                  style: GoogleFonts.inter(
                    color: PColors.text,
                    fontSize: 14,
                  ),
                  decoration: InputDecoration(
                    hintText: 'Cevabını buraya yaz...',
                    hintStyle: GoogleFonts.inter(
                      color: PColors.textDim,
                      fontSize: 14,
                    ),
                    filled: true,
                    fillColor: PColors.surface.withValues(alpha: 0.5),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: BorderSide(
                        color: PColors.border.withValues(alpha: 0.3),
                      ),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: BorderSide(
                        color: PColors.border.withValues(alpha: 0.3),
                      ),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: BorderSide(
                        color: PColors.primary,
                        width: 2,
                      ),
                    ),
                  ),
                  onSubmitted: (_) => _submitAnswer(),
                ).animate(delay: 300.ms).fadeIn().slideY(begin: 0.2),

                const SizedBox(height: 16),

                // Feedback
                if (isThinking)
                  Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: PColors.info.withValues(alpha: 0.1),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Row(
                      children: [
                        SizedBox(
                          width: 16,
                          height: 16,
                          child: CircularProgressIndicator(
                            strokeWidth: 2,
                            valueColor: AlwaysStoppedAnimation(PColors.info),
                          ),
                        ),
                        const SizedBox(width: 12),
                        Text(
                          'AI düşünüyor...',
                          style: GoogleFonts.inter(
                            color: PColors.info,
                            fontSize: 13,
                          ),
                        ),
                      ],
                    ),
                  ).animate().fadeIn()
                else if (feedback != null)
                  Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: (isCorrect == true ? PColors.success : PColors.warning)
                          .withValues(alpha: 0.1),
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(
                        color: (isCorrect == true ? PColors.success : PColors.warning)
                            .withValues(alpha: 0.3),
                      ),
                    ),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Icon(
                          isCorrect == true ? LucideIcons.check : LucideIcons.info,
                          color: isCorrect == true ? PColors.success : PColors.warning,
                          size: 20,
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: Text(
                            feedback!,
                            style: GoogleFonts.inter(
                              color: isCorrect == true ? PColors.success : PColors.warning,
                              fontSize: 13,
                              height: 1.5,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ).animate().fadeIn().scale(),

                const Spacer(),

                // Actions
                Row(
                  children: [
                    if (isCorrect == false) ...[
                      Expanded(
                        child: OutlinedButton(
                          onPressed: _retry,
                          style: OutlinedButton.styleFrom(
                            foregroundColor: PColors.textDim,
                            side: BorderSide(
                              color: PColors.border.withValues(alpha: 0.3),
                            ),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                          ),
                          child: Text(
                            'Tekrar Dene',
                            style: GoogleFonts.inter(fontSize: 14),
                          ),
                        ),
                      ),
                      const SizedBox(width: 12),
                    ],
                    Expanded(
                      child: ElevatedButton(
                        onPressed: isThinking || isCorrect == true
                            ? null
                            : _submitAnswer,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: PColors.primary,
                          foregroundColor: PColors.background,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          disabledBackgroundColor: PColors.surface,
                        ),
                        child: Text(
                          'Gönder',
                          style: GoogleFonts.inter(
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ),
                  ],
                ).animate(delay: 400.ms).fadeIn().slideY(begin: 0.2),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
