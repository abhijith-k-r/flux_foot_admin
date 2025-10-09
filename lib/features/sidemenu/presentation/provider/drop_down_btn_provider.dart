// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:flux_foot_admin/core/firebase/auth/firebase_auth_service.dart';
import 'package:flux_foot_admin/core/routing/web_router.dart';
import 'package:flux_foot_admin/features/auth/view_models/provider/auth_provider.dart';
import 'package:flux_foot_admin/features/auth/views/screens/login_screen.dart';

class DropDownButtonProvider extends ChangeNotifier {
  String? _value;

  String get value => _value!;

  void isSelected(BuildContext context, String value) {
    if (value == 'log_out') {
      _handleLogOut(context);
    }
    notifyListeners();
  }

  Future<void> _handleLogOut(BuildContext context) async {
    final auth = FirebaseAuthService();
    final authAdmin = AuthenticationAdmin();

    authAdmin.setLoggedIn(false);
    //! Sign out from Firebase Authentication
    auth.signOut();
    fadePushAndRemoveUntil(context, LogingScreen());
  }
}

