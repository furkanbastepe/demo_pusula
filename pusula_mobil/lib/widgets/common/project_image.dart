import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import '../../core/core.dart';

// ═══════════════════════════════════════════════════════════════════════════════════
// 🖼️ PROJECT IMAGE WIDGET - Network & Asset Support
// ═══════════════════════════════════════════════════════════════════════════════════

class ProjectImage extends StatelessWidget {
  final String imageUrl;
  final double? width;
  final double? height;
  final BoxFit fit;

  const ProjectImage({
    super.key,
    required this.imageUrl,
    this.width,
    this.height,
    this.fit = BoxFit.cover,
  });

  @override
  Widget build(BuildContext context) {
    // Eğer yol 'http' ile başlıyorsa, bu bir internet linkidir.
    if (imageUrl.startsWith('http')) {
      return CachedNetworkImage(
        imageUrl: imageUrl,
        width: width,
        height: height,
        fit: fit,
        placeholder: (context, url) => const Center(
          child: CircularProgressIndicator(color: PColors.primary)
        ),
        errorWidget: (context, url, error) => const Center(
          child: Icon(LucideIcons.imageOff, color: PColors.textDim)
        ),
      );
    } 
    // Değilse, bu yerel bir asset dosyasıdır.
    else {
      return Image.asset(
        imageUrl,
        width: width,
        height: height,
        fit: fit,
        errorBuilder: (context, error, stackTrace) => const Center(
          child: Icon(LucideIcons.imageOff, color: PColors.textDim)
        ),
      );
    }
  }
}
