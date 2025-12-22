import 'package:flutter/material.dart';
import 'package:flux_foot_admin/core/constants/web_colors.dart';

// ! Status Card
Widget buildStatCard({
  required IconData icon,
  required Color iconColor,
  required Color backgroundColor,
  required String title,
  required String value,
  required Color valueColor,
  bool hasAlert = false,
}) {
  return Container(
    decoration: BoxDecoration(
      color: WebColors.bgDarkBlue1,
      borderRadius: BorderRadius.circular(16),
      border: Border.all(color: WebColors.borderSideOrangeAcnt),
      boxShadow: [
        BoxShadow(
          color: WebColors.shadowBlack,
          blurRadius: 20,
          offset: const Offset(0, 4),
        ),
      ],
    ),
    child: Stack(
      children: [
        if (hasAlert)
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: Container(
              height: 4,
              decoration: BoxDecoration(
                color: const Color(0xFFEF4444),
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(16),
                  topRight: Radius.circular(16),
                ),
              ),
            ),
          ),
        Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: backgroundColor,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Icon(icon, color: iconColor, size: 28),
                  ),
                 Icon(Icons.more_horiz, color: WebColors.iconGreyShade),
                ],
              ),
              const SizedBox(height: 16),
              Text(
                title.toUpperCase(),
                style: const TextStyle(
                  color: Color(0xFF64748B),
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                  letterSpacing: 1.2,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                value,
                style: TextStyle(
                  color: valueColor,
                  fontSize: 36,
                  fontWeight: FontWeight.w800,
                  height: 1.2,
                ),
              ),
            ],
          ),
        ),
      ],
    ),
  );
}
