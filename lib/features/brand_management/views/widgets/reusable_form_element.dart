// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';

// --- Reusable Form Elements and Widgets (Same as in Category Manager) ---
Widget buildTextField(
  BuildContext context,
  String label,
  String hint, {
  bool isUrl = false,
}) {
  return Padding(
    padding: const EdgeInsets.only(bottom: 16.0),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
        ),
        const SizedBox(height: 6),
        TextFormField(
          keyboardType: isUrl ? TextInputType.url : TextInputType.text,
          decoration: InputDecoration(
            hintText: hint,
            isDense: true,
            contentPadding: const EdgeInsets.symmetric(
              vertical: 12,
              horizontal: 12,
            ),
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(4)),
          ),
        ),
      ],
    ),
  );
}

Widget buildToggle(BuildContext context, String label) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [
      Text(
        label,
        style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
      ),
      Switch(
        value: true, // Placeholder value
        onChanged: (bool value) {},
        activeColor: const Color(0xFF0b73da),
      ),
    ],
  );
}
