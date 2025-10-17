import 'package:flutter/material.dart';
import 'package:flux_foot_admin/core/constants/web_colors.dart';
import 'package:google_fonts/google_fonts.dart';

// ! Custome Text
Widget customText(
  double size,
  String text, {
  FontWeight? fontWeight,
  Color? webcolors,
}) {
  return Text(
    text,
    style: GoogleFonts.openSans(
      color: webcolors ?? WebColors.textWhite,
      fontSize: size,
      fontWeight: fontWeight,
    ),
    overflow: TextOverflow.ellipsis,
  );
}
