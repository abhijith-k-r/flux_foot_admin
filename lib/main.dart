import 'dart:developer';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flux_foot_admin/features/auth/view_models/provider/auth_provider.dart';
import 'package:flux_foot_admin/features/auth/views/screens/splash_screen.dart';
import 'package:flux_foot_admin/features/brand_management/view_model/provider/brand_provider.dart';
import 'package:flux_foot_admin/features/category_manager/view_model/provider/category_provider.dart';
import 'package:flux_foot_admin/features/sidemenu/view_models/provider/drop_down_btn_provider.dart';
import 'package:flux_foot_admin/features/sidemenu/views/screens/sidemenu.dart';
import 'package:flux_foot_admin/features/sidemenu/view_models/provider/sidemenu_provider.dart';
import 'package:flux_foot_admin/firebase_options.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  try {
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
  } catch (e) {
    log(e.toString());
  }

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<AuthenticationAdmin>(
          create: (context) => AuthenticationAdmin(),
        ),
        ChangeNotifierProvider<DropDownButtonProvider>(
          create: (context) => DropDownButtonProvider(),
        ),
        ChangeNotifierProvider<SidemenuProvider>(
          create: (context) => SidemenuProvider(),
        ),
        ChangeNotifierProvider<CategoryViewModel>(
          create: (context) => CategoryViewModel(),
        ),
        ChangeNotifierProvider<BrandProvider>(
          create: (context) => BrandProvider(),
        ),
      ],
      child: Consumer<AuthenticationAdmin>(
        builder: (context, authProvider, child) {
          return MaterialApp(
            title: 'FluxFoot_Admin',
            debugShowCheckedModeBanner: false,
            theme: ThemeData(scaffoldBackgroundColor: Colors.black),
            home: authProvider.isLoggedIn
                ? SideMenuWithAppbar()
                : SplashScreen(),
          );
        },
      ),
    );
  }
}
