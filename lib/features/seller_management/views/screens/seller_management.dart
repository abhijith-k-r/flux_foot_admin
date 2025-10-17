import 'package:flutter/material.dart';
import 'package:flux_foot_admin/core/constants/web_colors.dart';
import 'package:flux_foot_admin/features/seller_management/models/seller_status_model.dart';
import 'package:flux_foot_admin/features/seller_management/views/widgets/seller_status_container.dart';
import 'package:flux_foot_admin/features/seller_management/views/widgets/seller_table.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

class SellerManagement extends StatelessWidget {
  const SellerManagement({super.key});

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
              FutureBuilder<SellerCounts>(
                future: fetchSellerCounts(),
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
                      snapshot.data ??
                      SellerCounts(total: 0, active: 0, blocked: 0, pending: 0);

                  return Row(
                    spacing: 10,
                    children: [
                      Expanded(
                        flex: 2,
                        child: CustomSellerStatus(
                          size: size,
                          lottie: 'assets/lotties/Ecommerce.json',
                          satsTitle: 'Total Seller',
                          countSellr: counts.total.toString(),
                          boxColor: WebColors.totalSellerLite,
                          iconColor: WebColors.totalSeller,
                        ),
                      ),
                      Expanded(
                        flex: 2,
                        child: CustomSellerStatus(
                          size: size,
                          lottie: 'assets/lotties/Alert on.json',
                          satsTitle: 'Active Sellers',
                          countSellr: counts.active.toString(),
                          boxColor: WebColors.activeGreeLite,
                          iconColor: WebColors.activeGreen,
                        ),
                      ),
                      Expanded(
                        flex: 2,
                        child: CustomSellerStatus(
                          size: size,
                          lottie: 'assets/lotties/Process - Pending.json',
                          satsTitle: 'Pending Sellers',
                          countSellr: counts.pending.toString(),
                          boxColor: WebColors.pendinglite,
                          iconColor: WebColors.pending,
                        ),
                      ),
                      Expanded(
                        flex: 2,
                        child: CustomSellerStatus(
                          size: size,
                          lottie: 'assets/lotties/Error animation.json',
                          satsTitle: 'Block Sellers',
                          countSellr: counts.blocked.toString(),
                          boxColor: WebColors.errorRedlit,
                          iconColor: WebColors.errorRed,
                        ),
                      ),
                    ],
                  );
                },
              ),
              const SizedBox(height: 30),
              // ! Seller Table For Approval
              const SellerTable(),
            ],
          ),
        ),
      ),
    );
  }
}
