import 'package:flutter/material.dart';
import 'package:flux_foot_admin/core/constants/web_colors.dart';
import 'package:flux_foot_admin/features/user_management/model/user_counts.dart';
import 'package:flux_foot_admin/features/user_management/view_model/fetch_user_count.dart';
import 'package:flux_foot_admin/features/user_management/views/widgets/user_table.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

class UserManagement extends StatelessWidget {
  const UserManagement({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size.width;

    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              //!  to display the counts
              FutureBuilder<UserCounts>(
                future: fetchUsersCounts(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return SizedBox(
                      height: 120,
                      child: Center(
                        child: LoadingAnimationWidget.fourRotatingDots(
                          color: WebColors.logocolor,
                          size: size * 0.05,
                        ),
                      ),
                    );
                  }
                  if (snapshot.hasError) {
                    return Text(
                      'Error loading stats: ${snapshot.error}',
                      style: GoogleFonts.openSans(color: WebColors.errorRed),
                    );
                  }
                  final counts =
                      snapshot.data ?? UserCounts(total: 0, active: 0);

                  return Row(
                    spacing: 10,
                    children: [
                      Expanded(
                        flex: 2,
                        child: CustomUserStatus(
                          size: size,
                          lottie: 'assets/lotties/Ecommerce.json',
                          satsTitle: 'Total User',
                          countSellr: counts.total.toString(),
                          boxColor: WebColors.totalSellerLite,
                          iconColor: WebColors.totalSeller,
                        ),
                      ),
                      Expanded(
                        flex: 2,
                        child: CustomUserStatus(
                          size: size,
                          lottie: 'assets/lotties/Alert on.json',
                          satsTitle: 'Active User',
                          countSellr: counts.active.toString(),
                          boxColor: WebColors.activeGreeLite,
                          iconColor: WebColors.activeGreen,
                        ),
                      ),
                    ],
                  );
                },
              ),
              const SizedBox(height: 30),
              // ! Seller Table For Approval
              const UserTable(),
            ],
          ),
        ),
      ),
    );
  }
}
