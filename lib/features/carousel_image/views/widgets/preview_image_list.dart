import 'package:flutter/material.dart';
import 'package:flux_foot_admin/features/carousel_image/view_model/carousel_provider.dart';
import 'package:flux_foot_admin/features/carousel_image/views/widgets/slide_items.dart';
import 'package:provider/provider.dart';

// ! Uploaded Image Preview List
Widget buildPreviewList(BuildContext context) {
  final isDark = Theme.of(context).brightness == Brightness.dark;
  final size = MediaQuery.of(context).size.width;
  return Material(
    color: isDark ? const Color(0xFF1e293b) : Colors.white,
    borderRadius: BorderRadius.circular(12),
    elevation: 1,
    child: Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: isDark ? const Color(0xFF334155) : const Color(0xFFe7ebf3),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SingleChildScrollView(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Consumer<CarouselProvider>(
                  builder: (context, provider, _) => Text(
                    'Active Slides (${provider.slides.length})',
                    style: TextStyle(
                      fontSize: size > 1200 ? size * 0.015 : size * 0.04,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: size * 0.009,
                    vertical: 4,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.green[100],
                    borderRadius: BorderRadius.circular(4),
                  ),
                  child: const Text(
                    'Live Preview ',
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                      color: Color(0xFF15803d),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),
          Consumer<CarouselProvider>(
            builder: (context, provider, _) {
              if (provider.slides.isEmpty) {
                return Container(
                  height: 220,
                  decoration: BoxDecoration(
                    color: isDark
                        ? const Color(0xFF0f172a)
                        : const Color(0xFFf6f6f8),
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(
                      color: isDark
                          ? const Color(0xFF334155)
                          : const Color(0xFFe7ebf3),
                    ),
                  ),
                  child: Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.image_not_supported_outlined,
                          size: 48,
                          color: Colors.grey[400],
                        ),
                        const SizedBox(height: 12),
                        Text(
                          'No carousel slides yet',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                            color: Colors.grey[600],
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          'Upload images to get started',
                          style: TextStyle(
                            fontSize: 14,
                            color: Colors.grey[500],
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              }

              return SizedBox(
                height: 310,
                child: ListView.separated(
                  scrollDirection: provider.scrollDirection == 'vertical'
                      ? Axis.vertical
                      : Axis.horizontal,
                  itemCount: provider.slides.length,
                  separatorBuilder: (_, __) => const SizedBox(width: 16),
                  itemBuilder: (context, index) {
                    return buildSlideItem(context, provider, index);
                  },
                ),
              );
            },
          ),
        ],
      ),
    ),
  );
}
