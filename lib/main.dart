import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flux_foot_admin/features/auth/presentation/screens/login_screen.dart';
import 'package:flux_foot_admin/firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
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
