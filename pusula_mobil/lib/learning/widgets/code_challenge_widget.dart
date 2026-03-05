import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_highlight/flutter_highlight.dart';
import 'package:flutter_highlight/themes/monokai-sublime.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import '../../../core/core.dart';
import '../models/models.dart';

// ═══════════════════════════════════════════════════════════════════════════════════
// 💻 CODE CHALLENGE WIDGET - V2.1 Quiz-Based
// ═══════════════════════════════════════════════════════════════════════════════════

class CodeChallengeWidget extends StatefulWidget {
  final CodeChallengeData challenge;
  final Function(bool isCorrect, int xpEarned) onAnswered;

  const CodeChallengeWidget({
    super.key,
    required this.challenge,
    required this.onAnswered,
  });

  @override
  State<CodeChallengeWidget> createState() => _CodeChallengeWidgetState();
}

class _CodeChallengeWidgetState extends State<CodeChallengeWidget> {
  int? selectedIndex;
  bool? isCorrect;
  bool showSolution = false;

  void _handleAnswer(int index) {
    if (showSolution) return;

    setState(() {
      selectedIndex = index;
      isCorrect = index == widget.challenge.correctAnswerIndex;
      showSolution = true;
    });

    widget.onAnswered(isCorrect!, isCorrect! ? widget.challenge.xpReward : 0);
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
          // Header
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: PColors.accent.withValues(alpha: 0.15),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: const Icon(
                  LucideIcons.code,
                  color: PColors.accent,
                  size: 20,
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Text(
                  'Kod Challenge',
                  style: GoogleFonts.poppins(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: PColors.text,
                  ),
                ),
              ),
              if (showSolution && isCorrect!)
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  decoration: BoxDecoration(
                    color: PColors.success.withValues(alpha: 0.15),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Text(
                    '+${widget.challenge.xpReward} XP',
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
          // Description
          Text(
            widget.challenge.description,
            style: GoogleFonts.inter(
              fontSize: 15,
              color: PColors.text,
              height: 1.5,
            ),
          ),
          const SizedBox(height: 16),
          // Code example
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: const Color(0xFF23241F),
              borderRadius: BorderRadius.circular(12),
            ),
            child: HighlightView(
              widget.challenge.codeExample,
              language: 'sql',
              theme: monokaiSublimeTheme,
              padding: EdgeInsets.zero,
              textStyle: GoogleFonts.jetBrainsMono(fontSize: 13),
            ),
          ),
          const SizedBox(height: 20),
          // Options
          ...List.generate(widget.challenge.options.length, (index) {
            return _buildOption(index);
          }),
          // Solution
          if (showSolution) ...[
            const SizedBox(height: 20),
            _buildSolution(),
          ],
        ],
      ),
    );
  }

  Widget _buildOption(int index) {
    final isSelected = selectedIndex == index;
    final isCorrectOption = index == widget.challenge.correctAnswerIndex;
    
    Color borderColor = PColors.border;
    Color backgroundColor = Colors.transparent;
    
    if (showSolution) {
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
      label: 'Kod seçeneği ${index + 1}: ${widget.challenge.options[index]}',
      button: true,
      selected: isSelected,
      child: GestureDetector(
        onTap: () => _handleAnswer(index),
        child: Container(
        margin: const EdgeInsets.only(bottom: 12),
        padding: const EdgeInsets.all(12),
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
              child: showSolution && isCorrectOption
                  ? const Icon(Icons.check, size: 16, color: Colors.white)
                  : null,
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Text(
                widget.challenge.options[index],
                style: GoogleFonts.jetBrainsMono(
                  fontSize: 13,
                  color: PColors.text,
                ),
              ),
            ),
          ],
        ),
      ),
      ),
    ).animate(target: showSolution && isSelected && !isCorrect! ? 1 : 0)
        .shake(duration: 500.ms);
  }

  Widget _buildSolution() {
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
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(
                isCorrect! ? LucideIcons.circleCheck : LucideIcons.circleX,
                color: isCorrect! ? PColors.success : PColors.warning,
                size: 20,
              ),
              const SizedBox(width: 12),
              Text(
                isCorrect! ? 'Doğru!' : 'Yanlış',
                style: GoogleFonts.poppins(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  color: isCorrect! ? PColors.success : PColors.warning,
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Text(
            widget.challenge.detailedSolution,
            style: GoogleFonts.inter(
              fontSize: 13,
              color: PColors.text,
              height: 1.5,
            ),
          ),
        ],
      ),
    ).animate().fadeIn().slideY(begin: 0.2);
  }
}
