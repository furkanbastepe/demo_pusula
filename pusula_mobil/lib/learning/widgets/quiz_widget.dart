import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import '../../../core/core.dart';
import '../models/models.dart';

// ═══════════════════════════════════════════════════════════════════════════════════
// ❓ QUIZ WIDGET
// ═══════════════════════════════════════════════════════════════════════════════════

class QuizWidget extends StatefulWidget {
  final QuizData quiz;
  final Function(bool isCorrect, int xpEarned) onAnswered;

  const QuizWidget({
    super.key,
    required this.quiz,
    required this.onAnswered,
  });

  @override
  State<QuizWidget> createState() => _QuizWidgetState();
}

class _QuizWidgetState extends State<QuizWidget> {
  int? selectedIndex;
  bool? isCorrect;
  bool showExplanation = false;

  void _handleAnswer(int index) {
    if (showExplanation) return; // Already answered

    setState(() {
      selectedIndex = index;
      isCorrect = index == widget.quiz.correctAnswerIndex;
      showExplanation = true;
    });

    // Notify parent
    widget.onAnswered(isCorrect!, isCorrect! ? widget.quiz.xpReward : 0);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: PColors.surfaceHi.withValues(alpha: 0.5),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: PColors.border),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Question header
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: PColors.info.withValues(alpha: 0.15),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Icon(
                  LucideIcons.messageCircle,
                  color: PColors.info,
                  size: 20,
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Text(
                  'Quiz',
                  style: GoogleFonts.poppins(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: PColors.text,
                  ),
                ),
              ),
              if (showExplanation && isCorrect!)
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  decoration: BoxDecoration(
                    color: PColors.success.withValues(alpha: 0.15),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Text(
                    '+${widget.quiz.xpReward} XP',
                    style: GoogleFonts.inter(
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                      color: PColors.success,
                    ),
                  ),
                ),
            ],
          ),
          const SizedBox(height: 16),
          // Question
          Text(
            widget.quiz.question,
            style: GoogleFonts.inter(
              fontSize: 15,
              color: PColors.text,
              height: 1.5,
            ),
          ),
          const SizedBox(height: 20),
          // Options
          ...List.generate(widget.quiz.options.length, (index) {
            return _buildOption(index);
          }),
          // Explanation
          if (showExplanation) ...[
            const SizedBox(height: 20),
            _buildExplanation(),
          ],
        ],
      ),
    );
  }

  Widget _buildOption(int index) {
    final isSelected = selectedIndex == index;
    final isCorrectOption = index == widget.quiz.correctAnswerIndex;
    
    Color borderColor = PColors.border;
    Color backgroundColor = Colors.transparent;
    
    if (showExplanation) {
      if (isCorrectOption) {
        borderColor = PColors.success;
        backgroundColor = PColors.success.withValues(alpha: 0.1);
      } else if (isSelected && !isCorrect!) {
        borderColor = PColors.warning;
        backgroundColor = PColors.warning.withValues(alpha: 0.1);
      }
    } else if (isSelected) {
      borderColor = PColors.primary;
      backgroundColor = PColors.primary.withValues(alpha: 0.1);
    }

    return Semantics(
      label: 'Seçenek ${index + 1}: ${widget.quiz.options[index]}',
      button: true,
      selected: isSelected,
      child: GestureDetector(
        onTap: () => _handleAnswer(index),
        child: Container(
        margin: const EdgeInsets.only(bottom: 12),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: backgroundColor,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: borderColor, width: 2),
        ),
        child: Row(
          children: [
            Container(
              width: 24,
              height: 24,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(color: borderColor, width: 2),
                color: isSelected ? borderColor : Colors.transparent,
              ),
              child: showExplanation && isCorrectOption
                  ? const Icon(Icons.check, size: 16, color: Colors.white)
                  : null,
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Text(
                widget.quiz.options[index],
                style: GoogleFonts.inter(
                  fontSize: 14,
                  color: PColors.text,
                ),
              ),
            ),
          ],
        ),
      ),
      ),
    ).animate(target: showExplanation && isSelected && !isCorrect! ? 1 : 0)
        .shake(duration: 500.ms);
  }

  Widget _buildExplanation() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: isCorrect!
            ? PColors.success.withValues(alpha: 0.1)
            : PColors.warning.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: isCorrect! ? PColors.success : PColors.warning,
        ),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(
            isCorrect! ? LucideIcons.circleCheck : LucideIcons.circleX,
            color: isCorrect! ? PColors.success : PColors.warning,
            size: 20,
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  isCorrect! ? 'Doğru!' : 'Yanlış',
                  style: GoogleFonts.poppins(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: isCorrect! ? PColors.success : PColors.warning,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  widget.quiz.explanation,
                  style: GoogleFonts.inter(
                    fontSize: 13,
                    color: PColors.text,
                    height: 1.4,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    ).animate().fadeIn().slideY(begin: 0.2);
  }
}
