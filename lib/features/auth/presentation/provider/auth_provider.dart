// ignore_for_file: use_build_context_synchronously

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flux_foot_admin/features/auth/presentation/screens/dashboard.dart';
import 'package:flux_foot_admin/features/auth/presentation/widgets/lgoin_form.dart';

class AuthenticationAdmin extends ChangeNotifier {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _auth = FirebaseAuth.instance;

  bool _isPasswordVisible = false;
  bool _isLoading = false;

  GlobalKey get formkey => _formKey;
  TextEditingController get emailController => _emailController;
  TextEditingController get passwordController => _passwordController;
  FirebaseAuth get auth => _auth;

  bool get isPasswordVisible => _isPasswordVisible;
  bool get isLoading => _isLoading;

  void togglePasswordVisible() {
    _isPasswordVisible = !_isPasswordVisible;
    notifyListeners();
  }

  void setLoading(bool loading) {
    _isLoading = loading;
    notifyListeners();
  }

  Future<void> login(BuildContext ctx) async {
    if (_formKey.currentState!.validate()) {
      setLoading(true);

      try {
        // Fetch predefined credentials from Firestore
        DocumentSnapshot adminDoc = await FirebaseFirestore.instance
            .collection('admin_credentials')
            .doc('default_admin')
            .get();

        if (adminDoc.exists) {
          String storedEmail = adminDoc['email'];
          String storedPassword = adminDoc['password'];

          //  Compare input with stored values
          if (_emailController.text.trim() == storedEmail &&
              _passwordController.text.trim() == storedPassword) {
            fadePUshReplaceMent(ctx, Dashboard());
            showOverlaySnackbar(ctx, 'SucessFully Login 💫', Colors.green);
          } else {
            // Show error if no match
            showOverlaySnackbar(
              ctx,
              '🙆‍♀️ Invalid email or password.',
              Colors.red,
            );
          }
        }
      } catch (e) {
        // String errorMessage = 'An error occurred. Please try again.';
        // if (e is FirebaseAuthException) {
        //   switch (e.code) {
        //     case 'configuration-not-found':
        //       errorMessage =
        //           'Firebase configuration is missing. Please check setup.';
        //       break;
        //     case 'user-not-found':
        //       errorMessage = 'No user found with this email.';
        //       break;
        //     case 'wrong-password':
        //       errorMessage = 'Incorrect password.';
        //       break;
        //     default:
        //       errorMessage = e.message ?? errorMessage;
        //   }
        // }
        // ScaffoldMessenger.of(
        //   ctx,
        // ).showSnackBar(SnackBar(content: Text(errorMessage)));
      } finally {
        setLoading(false);
      }
    }
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }
}
