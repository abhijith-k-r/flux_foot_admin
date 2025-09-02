import 'package:flutter/material.dart';
import 'package:flux_foot_admin/features/auth/presentation/screens/loging_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: LogingScreen(),);
  }
}
