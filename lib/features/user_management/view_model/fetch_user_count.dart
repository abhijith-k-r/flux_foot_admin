import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flux_foot_admin/core/constants/web_colors.dart';
import 'package:flux_foot_admin/features/user_management/model/user_counts.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';

// Function to fetch the User counts from Firestore
// ! User Staus Counts
Future<UserCounts> fetchUsersCounts() async {
  final snapshot = await FirebaseFirestore.instance.collection('users').get();

  final allUsers = snapshot.docs;
  final total = allUsers.length;

  int active = 0;

  for (var doc in allUsers) {
    final userData = doc.data();

    final isOnline = userData['isOnline'] as bool? ?? false;

    if (isOnline) {
      active++;
    }

  }

  return UserCounts(total: total, active: active);
}

// ! Seller Status as Custom Container
class CustomUserStatus extends StatelessWidget {
  const CustomUserStatus({
    super.key,
    required this.size,
    required this.boxColor,
    required this.iconColor,
    required this.satsTitle,
    required this.countSellr,
    required this.lottie,
  });

  final double size;
  final String satsTitle;
  final String countSellr;
  final Color boxColor;
  final Color iconColor;
  final String lottie;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size * 0.18,
      height: size * 0.1,
      decoration: BoxDecoration(
        color: WebColors.bgDarkBlue2,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Padding(
        padding: EdgeInsets.only(left: size * 0.01, top: size * 0.01),
        child: Column(
          spacing: 20,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Lottie.asset(
                  lottie,
                  width: size * 0.05,
                  height: size * 0.05,
                  fit: BoxFit.contain,
                ),
                Padding(
                  padding: EdgeInsets.only(right: size * 0.01),
                  child: Container(
                    width: size * 0.02,
                    height: size * 0.02,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                      color: boxColor,
                    ),
                    child: Icon(
                      Icons.person_outline_sharp,
                      size: size * 0.015,
                      color: iconColor,
                    ),
                  ),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Text(
                  satsTitle,
                  style: GoogleFonts.openSans(color: WebColors.textWhite),
                ),
                Text(
                  countSellr,
                  style: GoogleFonts.openSans(
                    fontWeight: FontWeight.bold,
                    fontSize: size * 0.015,
                    color: WebColors.textWhite,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
