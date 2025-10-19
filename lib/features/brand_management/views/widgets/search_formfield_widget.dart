// ! Search Form Field Extracted widget
import 'package:flutter/material.dart';
import 'package:flux_foot_admin/core/constants/web_colors.dart';
import 'package:flux_foot_admin/features/brand_management/view_model/provider/brand_provider.dart';
import 'package:google_fonts/google_fonts.dart';

SizedBox customSearchForm(double size, BrandProvider brandProvider) {
  return SizedBox(
    width: size * 0.3,
    child: TextField(
      controller: brandProvider.searchController,
      style: GoogleFonts.openSans(color: WebColors.textWhite),
      decoration: InputDecoration(
        hintText: 'Search Brands...',
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
