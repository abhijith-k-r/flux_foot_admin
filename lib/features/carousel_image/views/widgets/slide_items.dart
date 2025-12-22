// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:flux_foot_admin/features/carousel_image/view_model/carousel_provider.dart';

// ! Preview Image Showing directionally
Widget buildSlideItem(
  BuildContext context,
  CarouselProvider provider,
  int index,
) {
  final isDark = Theme.of(context).brightness == Brightness.dark;
  final slide = provider.slides[index];

  return Material(
    color: isDark ? const Color(0xFF0f172a) : const Color(0xFFf6f6f8),
    borderRadius: BorderRadius.circular(8),
    elevation: 0,
    child: Container(
      width: provider.scrollDirection == 'vertical' ? double.infinity : 280,
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        border: Border.all(
          color: isDark ? const Color(0xFF334155) : const Color(0xFFe7ebf3),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Stack(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(6),
                child: AspectRatio(
                  aspectRatio: 16 / 11,
                  child: Image.network(
                    slide.imageUrl,
                    fit: BoxFit.cover,
                    errorBuilder: (_, __, ___) => Container(
                      color: Colors.grey[300],
                      child: const Icon(Icons.broken_image, size: 40),
                    ),
                    loadingBuilder: (context, child, loadingProgress) {
                      if (loadingProgress == null) return child;
                      return Container(
                        color: Colors.grey[300],
                        child: Center(
                          child: CircularProgressIndicator(
                            value: loadingProgress.expectedTotalBytes != null
                                ? loadingProgress.cumulativeBytesLoaded /
                                      loadingProgress.expectedTotalBytes!
                                : null,
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ),
              Positioned(
                top: 8,
                right: 8,
                child: Material(
                  color: isDark
                      ? Colors.black.withOpacity(0.5)
                      : Colors.white.withOpacity(0.9),
                  shape: const CircleBorder(),
                  child: InkWell(
                    onTap: () => provider.removeSlideLocally(slide.id),
                    customBorder: const CircleBorder(),
                    child: Container(
                      padding: const EdgeInsets.all(6),
                      child: const Icon(
                        Icons.delete_outline,
                        size: 18,
                        color: Colors.red,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Text(
            'OVERLAY TEXT',
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w600,
              color: Colors.grey[600],
            ),
          ),
          const SizedBox(height: 4),
          // We use a Key to ensure the TextField doesn't lose focus or gets messed up when list changes
          TextFormField(
            key: ValueKey(slide.id),
            initialValue: slide.text,
            onChanged: (value) =>
                provider.updateSlideTextLocally(slide.id, value),
            decoration: InputDecoration(
              prefixIcon: const Icon(Icons.text_fields, size: 16),
              hintText: 'Enter text...',
              contentPadding: const EdgeInsets.symmetric(
                horizontal: 12,
                vertical: 8,
              ),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(4),
                borderSide: BorderSide(color: Colors.grey[300]!),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(4),
                borderSide: const BorderSide(color: Color(0xFF135bec)),
              ),
            ),
            style: const TextStyle(fontSize: 14),
          ),
        ],
      ),
    ),
  );
}
