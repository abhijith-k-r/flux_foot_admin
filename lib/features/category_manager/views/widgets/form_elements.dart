// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:flux_foot_admin/core/constants/web_colors.dart';
import 'package:google_fonts/google_fonts.dart';

// --- Reusable Form Elements and Widgets ---
Widget buildTextField(
  BuildContext context,
  String label,
  String hint,
  TextEditingController controller,
) {
  return Padding(
    padding: const EdgeInsets.only(bottom: 16.0),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: GoogleFonts.openSans(
            fontSize: 14,
            fontWeight: FontWeight.w500,
            color: WebColors.textWhite,
          ),
        ),
        const SizedBox(height: 6),
        TextFormField(
          controller: controller,
          style: TextStyle(color: WebColors.textWhite),
          textInputAction: TextInputAction.next,
          decoration: InputDecoration(
            hintText: hint,
            hintStyle: GoogleFonts.openSans(color: WebColors.textWhiteLite),
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

Widget buildTextArea(
  BuildContext context,
  String label,
  String hint,
  TextEditingController controller,
) {
  return Padding(
    padding: const EdgeInsets.only(bottom: 16.0),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: GoogleFonts.openSans(
            fontSize: 14,
            fontWeight: FontWeight.w500,
            color: WebColors.textWhite,
          ),
        ),
        const SizedBox(height: 6),
        TextFormField(
          controller: controller,
          maxLines: 3,
          style: TextStyle(color: WebColors.textWhite),
          decoration: InputDecoration(
            hintText: hint,
            hintStyle: GoogleFonts.openSans(color: WebColors.textWhiteLite),
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

// Widget buildToggle(BuildContext context, String label) {
//   return Row(
//     mainAxisAlignment: MainAxisAlignment.spaceBetween,
//     children: [
//       Text(
//         label,
//         style: GoogleFonts.openSans(
//           fontSize: 14,
//           fontWeight: FontWeight.w500,
//           color: WebColors.textWhite,
//         ),
//       ),
//       Switch(
//         materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
//         value: false,
//         onChanged: (bool value) {},
//         activeColor: WebColors.activeGreeLite,
//       ),
//     ],
//   );
// }
