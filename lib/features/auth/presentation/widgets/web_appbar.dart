// ! Custom Web App Bar
// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:flux_foot_admin/core/constants/app_colors.dart';
import 'package:google_fonts/google_fonts.dart';

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
      decoration: const BoxDecoration(
        color: Color(0xFF1E2A44),
        boxShadow: [
          BoxShadow(color: Colors.black26, offset: Offset(0, 2), blurRadius: 4),
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
                color: textWhite,
                letterSpacing: 1.2,
              ),
            ),
            SizedBox(width: size * 0.1),   //! between the text and title space
            //! Page Title
            Text(
              title,
              style: GoogleFonts.openSans(
                fontSize: size > 1200 ? 20 : 18,
                fontWeight: FontWeight.w700,
                color: textWhite,
              ),
            ),

            Spacer(),

            //! Admin Button
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              decoration: BoxDecoration(
                color: const Color(0xFF4C6EF5),
                borderRadius: BorderRadius.circular(6),
                boxShadow: [
                  BoxShadow(
                    color: const Color(0xFF4C6EF5).withOpacity(0.3),
                    offset: const Offset(0, 2),
                    blurRadius: 4,
                  ),
                ],
              ),
              child: InkWell(
                onTap: onAdminTap,
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Icon(
                      Icons.admin_panel_settings,
                      color: Colors.white,
                      size: 16,
                    ),
                    const SizedBox(width: 8),
                    Text(
                      'ADMIN',
                      style: GoogleFonts.openSans(
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                        letterSpacing: 0.5,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
