// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:flux_foot_admin/core/constants/web_colors.dart';
import 'package:flux_foot_admin/core/routing/web_router.dart';
import 'package:flux_foot_admin/features/auth/views/screens/login_screen.dart';
import 'package:lottie/lottie.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    Future.delayed(Duration(seconds: 7), () {
      if (mounted) fadePUshReplaceMent(context, LogingScreen());
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: ColorFiltered(
          colorFilter: ColorFilter.mode(WebColors.logocolor, BlendMode.srcATop),
          child: Lottie.asset('assets/lotties/Untitled file.json'),
        ),
      ),
    );
  }
}              