import 'package:flutter/material.dart';
import 'package:flux_foot_admin/core/constants/web_colors.dart';
import 'package:flux_foot_admin/features/category_manager/view_model/provider/category_provider.dart';
import 'package:google_fonts/google_fonts.dart';

// ! Search Form Field Extracted widget
SizedBox customSearchForm(double size, CategoryViewModel categoryViewModel) {
  return SizedBox(
    width: size * 0.3,
    child: TextField(
      controller: categoryViewModel.searchController,
      style: GoogleFonts.openSans(color: WebColors.textWhite),
      decoration: InputDecoration(
        hintText: 'Search categories...',
        hintStyle: GoogleFonts.openSans(color: WebColors.textWhiteLite),
        prefixIcon: Icon(
          Icons.search,
          size: 20,
          color: WebColors.iconGreyShade,
        ),
        contentPadding: const EdgeInsets.symmetric(
          vertical: 10,
          horizontal: 10,
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),

          borderSide: BorderSide(color: WebColors.borderSideGrey),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(width: 2, color: WebColors.buttonBlue),
          borderRadius: BorderRadius.all(Radius.circular(8)),
        ),
      ),
    ),
  );
}
