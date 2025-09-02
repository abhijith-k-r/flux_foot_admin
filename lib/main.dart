import 'package:flutter/material.dart';
import 'package:fluxfoot_admin/features/auth/presentation/screens/loging_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'FluxFoot_Admin',
      debugShowCheckedModeBanner: false,

      theme: ThemeData(scaffoldBackgroundColor: Color(0xFF1E2A44)),

      home: LogingScreen(),
    );
  }
}
