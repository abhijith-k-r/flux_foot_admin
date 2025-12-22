// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:flux_foot_admin/core/widgets/custom_text.dart';
import 'package:flux_foot_admin/features/carousel_image/views/widgets/onshow_carousel_helper.dart';

// ! Small  Screen Layout
Widget buildSmallScreenLayout(BuildContext context, Map<String, String> item) {
  final size = MediaQuery.of(context).size.width;
  return SingleChildScrollView(
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        // Icon
        Container(
          width: size * 0.1,
          height: size * 0.1,
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.1),
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: Colors.white.withOpacity(0.2)),
          ),
          child: Icon(Icons.perm_media, color: Colors.white, size: size * 0.05),
        ),
        const SizedBox(height: 16),

        //!  Text Content
        customText(size * 0.04, item['title']!, fontWeight: FontWeight.bold),

        const SizedBox(height: 8),

        Text(
          item['description']!,
          textAlign: TextAlign.center,
          style: TextStyle(
            color: Color(0xFFBFDBFE),
            fontSize: size * 0.03,
            fontWeight: FontWeight.w500,
          ),
        ),
        const SizedBox(height: 20),

        // ! Button
        ElevatedButton(
          onPressed: () {
            if (item['buttonText'] == 'Manage Display') {
              onShowCarouselHelper(context);
            }
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.white,
            foregroundColor: const Color(0xFF0d59f2),
            elevation: 8,
            padding: EdgeInsets.symmetric(
              horizontal: size * 0.05,
              vertical: size * 0.01,
            ),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(24),
            ),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                item['buttonText']!,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 14,
                ),
              ),
              const SizedBox(width: 8),
              const Icon(Icons.arrow_forward, size: 16),
            ],
          ),
        ),
      ],
    ),
  );
}
