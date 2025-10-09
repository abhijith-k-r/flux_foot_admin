// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:flux_foot_admin/core/constants/web_colors.dart';
import 'package:flux_foot_admin/core/routing/web_router.dart';
import 'package:flux_foot_admin/core/widgets/show_snackbar.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flux_foot_admin/core/firebase/auth/firebase_auth_service.dart';
import 'package:flux_foot_admin/features/sidemenu/presentation/screens/sidemenu.dart';

class AuthenticationAdmin extends ChangeNotifier {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  final FirebaseAuthService _firebaseAuthService = FirebaseAuthService();

  bool _isPasswordVisible = false;
  bool _isLoading = false;
  bool _isLoggedIn = false;

  GlobalKey get formkey => _formKey;
  TextEditingController get emailController => _emailController;
  TextEditingController get passwordController => _passwordController;

  bool get isPasswordVisible => _isPasswordVisible;
  bool get isLoading => _isLoading;
  bool get isLoggedIn => _isLoggedIn;

  AuthenticationAdmin() {
    checkLoginStatus();
  }

  void togglePasswordVisible() {
    _isPasswordVisible = !_isPasswordVisible;
    notifyListeners();
  }

  void setLoading(bool loading) {
    _isLoading = loading;
    notifyListeners();
  }

  Future<void> checkLoginStatus() async {
    final prefs = await SharedPreferences.getInstance();
    _isLoggedIn = prefs.getBool('isLoggedIn') ?? false;
    notifyListeners();
  }

  Future<void> setLoggedIn(bool value) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('isLoggedIn', value);
    _isLoggedIn = value;
    notifyListeners();
  }

  Future<void> login(BuildContext ctx) async {
    if (_formKey.currentState!.validate()) {
      setLoading(true);

      try {
        final credentials = await _firebaseAuthService.fetchAdminCredentials();

        if (credentials != null) {
          final storedEmail = credentials['email'];
          final storedPassword = credentials['password'];

          if (_emailController.text.trim() == storedEmail &&
              _passwordController.text.trim() == storedPassword) {
            await setLoggedIn(true);
            fadePUshReplaceMent(ctx, SideMenuWithAppbar());
            showOverlaySnackbar(ctx, 'Successfully Login 💫', WebColors.successGreen);
          } else {
            showOverlaySnackbar(
              ctx,
              '🙆‍♀️ Invalid email or password.',
              WebColors.errorRed,
            );
          }
        }
      } catch (e) {
        showOverlaySnackbar(ctx, 'Error: $e', WebColors.errorRed);
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
