import 'package:flutter/material.dart';
import 'package:flux_foot_admin/features/user_management/views/screens/user_details.dart';

// ! Showing Useer Details Helper Function
void onShowUserDetails(
  BuildContext context,
  dynamic status,
  String sellerId,
  dynamic name,
  dynamic email,
  String phone,
  String dob,
  String imageUrl,
) {
  showDialog(
    context: context,
    builder: (context) => ShowUserDetailsScreen(
      phone: phone,
      sellerId: sellerId,
      email: email,
      name: name,
      status: status,
      dob: dob,
      imageUrl: imageUrl,
    ),
  );
}
