import 'package:flutter/material.dart';
import 'package:flux_foot_admin/core/constants/web_colors.dart';

// ! Header Informations
Widget buildHeaderInfo() {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(
        'Homepage Carousel Management',
        style: TextStyle(
          fontSize: 32,
          fontWeight: FontWeight.w900,
          letterSpacing: -0.5,
          color: WebColors.textWhite,
        ),
      ),
      const SizedBox(height: 8),
      Text(
        'Upload carousel images to Cloudinary and manage display settings',
        style: TextStyle(fontSize: 16, color: Colors.grey[600]),
      ),
    ],
  );
}
