// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:flux_foot_admin/core/constants/web_colors.dart';
import 'package:flux_foot_admin/features/sidemenu/views/widgets/admin_dropdown_button.dart';
import 'package:google_fonts/google_fonts.dart';

// ! Custom Web App Bar
class CustomWebAppbar extends StatelessWidget {
  final String title;
  final VoidCallback? onAdminTap;

  const CustomWebAppbar({super.key, required this.title, this.onAdminTap});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size.width;

    return Container(
      height: 70,
      width: double.infinity,
      decoration: BoxDecoration(
        color: WebColors.bgDarkBlue2,
        boxShadow: [
          BoxShadow(
            color: WebColors.shadowBlack,
            offset: Offset(0, 2),
            blurRadius: 4,
          ),
        ],
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: size * 0.02),
        child: Row(
          children: [
            //! Logo/Brand
            Text(
              'FLUXFOOT',
              style: GoogleFonts.rozhaOne(
                fontSize: size > 1200 ? 28 : 24,
                color: WebColors.textWhite,
                letterSpacing: 1.2,
              ),
            ),
            SizedBox(width: size * 0.05), //! between the text and title space
            //! Page Title
            Expanded(
              child: Text(
                title,
                style: GoogleFonts.openSans(
                  fontSize: size > 1200 ? 20 : size * 0.035,
                  fontWeight: FontWeight.w700,
                  color: WebColors.textWhite,
                ),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
            ),

            // ! ADMIN BUTTON 2
            AdminDropdown(),
          ],
        ),
      ),
    );
  }
}
