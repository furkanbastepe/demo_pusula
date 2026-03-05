import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../core/core.dart';
import '../models/models.dart';

// ═══════════════════════════════════════════════════════════════════════════════════
// 📖 LESSON CONTENT WIDGET
// ═══════════════════════════════════════════════════════════════════════════════════

class LessonContentWidget extends StatelessWidget {
  final ContentData content;

  const LessonContentWidget({super.key, required this.content});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: PColors.surfaceHi.withValues(alpha: 0.3),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: PColors.border),
      ),
      child: MarkdownBody(
        data: content.markdown,
        styleSheet: MarkdownStyleSheet(
          h1: GoogleFonts.poppins(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: PColors.text,
          ),
          h2: GoogleFonts.poppins(
            fontSize: 20,
            fontWeight: FontWeight.w600,
            color: PColors.text,
          ),
          h3: GoogleFonts.poppins(
            fontSize: 18,
            fontWeight: FontWeight.w600,
            color: PColors.text,
          ),
          p: GoogleFonts.inter(
            fontSize: 15,
            color: PColors.text,
            height: 1.6,
          ),
          code: GoogleFonts.jetBrainsMono(
            fontSize: 14,
            backgroundColor: PColors.surface,
            color: PColors.accent,
          ),
          codeblockDecoration: BoxDecoration(
            color: const Color(0xFF23241F),
            borderRadius: BorderRadius.circular(8),
          ),
          listBullet: GoogleFonts.inter(
            fontSize: 15,
            color: PColors.primary,
          ),
          tableBody: GoogleFonts.inter(
            fontSize: 14,
            color: PColors.text,
          ),
          tableHead: GoogleFonts.inter(
            fontSize: 14,
            fontWeight: FontWeight.w600,
            color: PColors.text,
          ),
        ),
      ),
    );
  }
}
