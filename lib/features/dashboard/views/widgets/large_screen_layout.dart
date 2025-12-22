// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:flux_foot_admin/core/constants/web_colors.dart';
import 'package:flux_foot_admin/features/carousel_image/views/widgets/onshow_carousel_helper.dart';

// ! Large Screen Layout
Widget buildLargeScreenLayout(BuildContext context, Map<String, String> item) {
  return Row(
    children: [
      // Icon
      Container(
        width: 80,
        height: 80,
        decoration: BoxDecoration(
          color: WebColors.bgWhite.withOpacity(0.1),
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: WebColors.borderSideGrey.withOpacity(0.2)),
        ),
        child: Icon(Icons.perm_media, color: WebColors.iconeWhite, size: 40),
      ),
      const SizedBox(width: 32),

      // Text Content
      Expanded(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              item['title']!,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 28,
                fontWeight: FontWeight.bold,
                height: 1.2,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              item['description']!,
              style: const TextStyle(
                color: Color(0xFFBFDBFE),
                fontSize: 16,
                fontWeight: FontWeight.w500,
                height: 1.5,
              ),
            ),
          ],
        ),
      ),

      const SizedBox(width: 24),

      // ! Button
      ElevatedButton(
        onPressed: () {
          if (item['buttonText'] == 'Manage Display') {
            onShowCarouselHelper(context);
          }
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: WebColors.textWhite,
          foregroundColor: WebColors.buttonBlue,
          elevation: 8,
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(24),
          ),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              item['buttonText']!,
              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
            ),
            const SizedBox(width: 8),
            const Icon(Icons.arrow_forward, size: 18),
          ],
        ),
      ),
    ],
  );
}
