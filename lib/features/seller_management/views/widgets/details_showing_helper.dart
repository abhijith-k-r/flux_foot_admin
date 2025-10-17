import 'package:flutter/material.dart';
import 'package:flux_foot_admin/core/constants/web_colors.dart';
import 'package:google_fonts/google_fonts.dart';


// ! Details Showing Helper Function
Widget buildDetaileItem(BuildContext context, String label, String value) {
  final size = MediaQuery.of(context).size.width;
  return Column(
    spacing: 4,
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(
        label,
        style: GoogleFonts.openSans(
          fontSize: size * 0.01,
          fontWeight: FontWeight.w500,
          color: WebColors.textWhiteLite,
        ),
        overflow: TextOverflow.ellipsis,
      ),
      Text(
        value,
        style: GoogleFonts.openSans(
          fontSize: size * 0.011,
          fontWeight: FontWeight.bold,
          color: WebColors.textWhite,
        ),
        overflow: TextOverflow.ellipsis,
      ),
    ],
  );
}

// ! NEW Helper Widget for the Document Link
Widget buildLicenseDocumentItem(
  BuildContext context,
  String label,
  String url,
  VoidCallback onPressed,
) {
  final size = MediaQuery.of(context).size.width;
  final bool isAvailable = url.isNotEmpty && url != 'N/A';

  return Column(
    // spacing: 4,
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(
        label,
        style: GoogleFonts.openSans(
          fontSize: size * 0.01,
          fontWeight: FontWeight.w500,
          color: Colors.white70,
        ),
      ),
      SizedBox(height: 4),
      if (isAvailable)
        TextButton.icon(
          onPressed: onPressed,
          icon: Icon(
            Icons.description,
            size: size * 0.015,
            color: Colors.blueAccent,
          ),
          label: Text(
            'View Document',
            style: GoogleFonts.openSans(
              fontSize: size * 0.011,
              fontWeight: FontWeight.bold,
              color: Colors.blueAccent,
              decoration: TextDecoration.underline,
            ),
          ),
        )
      else
        Text(
          'Document Not Available',
          style: GoogleFonts.openSans(
            fontSize: size * 0.011,
            fontWeight: FontWeight.bold,
            color: WebColors.errorRed,
          ),
        ),
    ],
  );
}
