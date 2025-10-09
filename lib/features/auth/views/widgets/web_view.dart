import 'package:flutter/material.dart';
import 'package:flux_foot_admin/core/constants/web_colors.dart';
import 'package:flux_foot_admin/features/auth/views/widgets/logingform_view.dart';
import 'package:google_fonts/google_fonts.dart';

//! Separate Widget for Web Layout
class WebLoginLayout extends StatelessWidget {
  const WebLoginLayout({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Row(
      children: [
        Expanded(
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(
                  'assets/logo/logo.png',
                  width: size.width * 0.1,
                  height: size.height * 0.1,
                  color: WebColors.logocolor,
                ),
                Text(
                  'FLUXFOOT',
                  style: GoogleFonts.rozhaOne(
                    fontSize: size.width * 0.02,
                    color: WebColors.textWhite,
                  ),
                ),
              ],
            ),
          ),
        ),
        Expanded(child: Center(child: LoginForm())),
      ],
    );
  }
}
