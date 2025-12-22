// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';

Widget buildDirectionOption(
  BuildContext context,
  String label,
  IconData icon,
  bool isSelected,
  VoidCallback onTap,
) {
  final isDark = Theme.of(context).brightness == Brightness.dark;
  return Material(
    color: isSelected
        ? const Color(0xFF135bec).withOpacity(0.05)
        : (isDark ? const Color(0xFF0f172a) : Colors.white),
    borderRadius: BorderRadius.circular(8),
    child: InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(8),
      child: Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          border: Border.all(
            color: isSelected
                ? const Color(0xFF135bec)
                : (isDark ? const Color(0xFF475569) : const Color(0xFFe7ebf3)),
          ),
        ),
        child: Column(
          children: [
            Icon(
              icon,
              size: 24,
              color: isSelected ? const Color(0xFF135bec) : null,
            ),
            const SizedBox(height: 4),
            Text(
              label,
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w500,
                color: isSelected ? const Color(0xFF135bec) : null,
              ),
            ),
          ],
        ),
      ),
    ),
  );
}
