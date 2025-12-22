// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:flux_foot_admin/features/seller_management/views/widgets/details_showing_helper.dart';

// ! Seller Details as Dialogu (popup)
class UserDetailsWidgets extends StatelessWidget {
  const UserDetailsWidgets({
    super.key,
    required this.size,
    required this.name,
    required this.phone,
    required this.email,
    required this.dob,
  });

  final double size;
  final String name;
  final String phone;
  final String email;
  final dynamic dob;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: size * 0.03),
      child: Container(
        padding: EdgeInsets.all(24),
        decoration: BoxDecoration(
          color: const Color.fromARGB(255, 26, 25, 25),
          borderRadius: BorderRadius.circular(8),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 10,
              offset: Offset(0, 4),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          spacing: size * 0.013,
          children: [
            Row(
              spacing: size * 0.1,
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  spacing: size * 0.013,
                  children: [
                    buildDetaileItem(context, 'User Name', name),
                    buildDetaileItem(context, 'Phone Number', phone),
                  ],
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  spacing: size * 0.013,
                  children: [
                    buildDetaileItem(context, 'Email Address', email),
                    buildDetaileItem(context, 'DOB', dob),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
