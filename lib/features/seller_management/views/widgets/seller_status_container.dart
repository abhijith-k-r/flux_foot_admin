import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flux_foot_admin/core/constants/web_colors.dart';
import 'package:flux_foot_admin/features/seller_management/models/seller_status_model.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';

// ! Seller Status as Custom Container
class CustomSellerStatus extends StatelessWidget {
  const CustomSellerStatus({
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

// ! Sellers Staus Counts
// Function to fetch the seller counts from Firestore
Future<SellerCounts> fetchSellerCounts() async {
  final snapshot = await FirebaseFirestore.instance.collection('sellers').get();

  // Get all documents
  final allSellers = snapshot.docs;
  final total = allSellers.length;

  // Initialize counts
  int active = 0;
  int blocked = 0;
  int pending = 0;

  // Iterate and count based on status
  for (var doc in allSellers) {
    // Safely get the status, defaulting to 'unknown'
    final status = (doc.data()['status'] as String? ?? 'unknown').toLowerCase();

    if (status == 'active' || status == 'approved') {
      active++;
    } else if (status == 'blocked' || status == 'rejected') {
      blocked++;
    } else if (status == 'pending' || status == 'waiting') {
      pending++;
    }
  }

  return SellerCounts(
    total: total,
    active: active,
    blocked: blocked,
    pending: pending,
  );
}
