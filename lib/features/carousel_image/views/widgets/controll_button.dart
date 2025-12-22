import 'package:flutter/material.dart';

Widget buildControlButton(
  BuildContext context,
  IconData icon,
  VoidCallback onTap,
) {
  final isDark = Theme.of(context).brightness == Brightness.dark;
  return Material(
    color: isDark ? const Color(0xFF0f172a) : Colors.white,
    borderRadius: BorderRadius.circular(8),
    child: InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(8),
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 12),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          border: Border.all(
            color: isDark ? const Color(0xFF475569) : const Color(0xFFe7ebf3),
          ),
        ),
        child: Icon(icon, size: 20),
      ),
    ),
  );
}
