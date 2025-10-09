import 'package:flutter/material.dart';
import 'package:flux_foot_admin/core/constants/web_colors.dart';
import 'package:flux_foot_admin/features/auth/views/widgets/logingform_view.dart';
import 'package:google_fonts/google_fonts.dart';

//! Separate Widget for Mobile Layout to avoid rebuild issues
class MobileLoginLayout extends StatelessWidget {
  const MobileLoginLayout({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final viewInsets = MediaQuery.of(context).viewInsets;

    return SafeArea(
      child: Padding(
        padding: EdgeInsets.only(
          left: 20,
          right: 20,
          top: 20,
          bottom: viewInsets.bottom > 0 ? viewInsets.bottom + 20 : 20,
        ),
        child: Column(
          children: [
            //! Logo section - takes minimal space when keyboard is open
            if (viewInsets.bottom == 0) ...[
              SizedBox(height: size.height * 0.05),
              Image.asset(
                'assets/logo/logo.png',
                width: size.width * 0.25,
                height: size.height * 0.12,
                color: WebColors.logocolor,
              ),
              SizedBox(height: 16),
              Text(
                'FLUXFOOT',
                style: GoogleFonts.rozhaOne(
                  fontSize: size.width * 0.08,
                  color: WebColors.textWhite,
                ),
              ),
              SizedBox(height: 40),
            ] else ...[
              SizedBox(height: 20),
              Text(
                'FLUXFOOT',
                style: GoogleFonts.rozhaOne(
                  fontSize: size.width * 0.06,
                  color: WebColors.textWhite,
                ),
              ),
              SizedBox(height: 20),
            ],

            //! Login form - expands to fill available space
            Expanded(child: SingleChildScrollView(child: LoginForm())),
          ],
        ),
      ),
    );
  }
}
