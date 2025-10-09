import 'package:flutter/material.dart';
import 'package:flux_foot_admin/core/constants/web_colors.dart';
import 'package:flux_foot_admin/features/auth/views/widgets/mobile_view.dart';
import 'package:flux_foot_admin/features/auth/views/widgets/web_view.dart';

class LogingScreen extends StatelessWidget {
  const LogingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: WebColors.bgDarkBlue1,
      resizeToAvoidBottomInset: true,
      body: LayoutBuilder(
        builder: (context, constraints) {
          bool isMobile = constraints.maxWidth < 768;
          return Container(
            // ! Mobile View & Web View
            child: isMobile ? MobileLoginLayout() : WebLoginLayout(),
          );
        },
      ),
    );
  }
}






