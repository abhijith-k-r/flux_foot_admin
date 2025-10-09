import 'package:flutter/material.dart';
import 'package:flux_foot_admin/core/constants/web_colors.dart';
import 'package:flux_foot_admin/features/sellermanagement/models/seller_status_model.dart';
import 'package:flux_foot_admin/features/sellermanagement/views/widgets/seller_status_container.dart';
import 'package:flux_foot_admin/features/sellermanagement/views/widgets/seller_table.dart';
import 'package:google_fonts/google_fonts.dart';

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
                        child: CircularProgressIndicator(color: WebColors.waitinColor),
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
                          boxColor: Color.fromARGB(255, 99, 63, 201),
                          iconColor: Colors.deepPurpleAccent,
                        ),
                      ),
                      Expanded(
                        flex: 2,
                        child: CustomSellerStatus(
                          size: size,
                          lottie: 'assets/lotties/Alert on.json',
                          satsTitle: 'Active Sellers',
                          countSellr: counts.active.toString(),
                          boxColor: const Color.fromARGB(255, 78, 155, 80),
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
                          boxColor: const Color.fromARGB(255, 177, 153, 82),
                          iconColor: Colors.amberAccent,
                        ),
                      ),
                      Expanded(
                        flex: 2,
                        child: CustomSellerStatus(
                          size: size,
                          lottie: 'assets/lotties/Error animation.json',
                          satsTitle: 'Block Sellers',
                          countSellr: counts.blocked.toString(),
                          boxColor: const Color.fromARGB(255, 190, 80, 72),
                          iconColor: Colors.redAccent,
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
