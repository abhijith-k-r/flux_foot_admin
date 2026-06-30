// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:flux_foot_admin/core/constants/web_colors.dart';
import 'package:flux_foot_admin/core/services/firebase/firebase_auth_service.dart';
import 'package:flux_foot_admin/core/routing/web_router.dart';
import 'package:flux_foot_admin/core/widgets/custom_text.dart';
import 'package:flux_foot_admin/features/auth/view_models/provider/auth_provider.dart';
import 'package:flux_foot_admin/features/auth/views/screens/login_screen.dart';

class DropDownButtonProvider extends ChangeNotifier {
  String? _value;

  String get value => _value!;

  void showLogoutDilog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: customText(
            22,
            'LogOut?',
            webcolors: WebColors.errorRed,
            fontWeight: FontWeight.bold,
          ),
          content: Text('Are you Sure do you wan to log out ?'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: customText(
                10,
                'Back',
                fontWeight: FontWeight.bold,
                webcolors: WebColors.textBlack,
              ),
            ),
            TextButton(
              onPressed: () {
                handleLogOut(context);
              },
              child: customText(
                10,
                'LogOut',
                webcolors: WebColors.errorRed,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        );
      },
    );
  }

  void isSelected(BuildContext context, String value) {
    if (value == 'log_out') {
      showLogoutDilog(context);
    }
    notifyListeners();
  }

  Future<void> handleLogOut(BuildContext context) async {
    final auth = FirebaseAuthService();
    final authAdmin = AuthenticationAdmin();

    authAdmin.setLoggedIn(false);
    //! Sign out from Firebase Authentication
    auth.signOut();
    fadePushAndRemoveUntil(context, LogingScreen());
  }
}
