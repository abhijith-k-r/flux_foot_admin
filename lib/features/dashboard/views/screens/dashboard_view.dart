// ignore_for_file: avoid_types_as_parameter_names, deprecated_member_use

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flux_foot_admin/core/constants/web_colors.dart';
import 'package:flux_foot_admin/features/dashboard/views/widgets/carousel_card.dart';
import 'package:flux_foot_admin/features/dashboard/views/widgets/dashboard_adminstatus_card.dart';
import 'package:flux_foot_admin/features/dashboard/views/widgets/dashboard_returnproduct_dialog.dart';

class DashboardContent extends StatelessWidget {
  const DashboardContent({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(40),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Dynamic Stats Grid
          StreamBuilder<QuerySnapshot>(
            stream: FirebaseFirestore.instance.collection('orders').snapshots(),
            builder: (context, ordersSnap) {
              final orders = ordersSnap.data?.docs ?? [];
              return StreamBuilder<QuerySnapshot>(
                stream: FirebaseFirestore.instance
                    .collection('users')
                    .snapshots(),
                builder: (context, usersSnap) {
                  return StreamBuilder<QuerySnapshot>(
                    stream: FirebaseFirestore.instance
                        .collection('sellers')
                        .snapshots(),
                    builder: (context, sellersSnap) {
                      return StreamBuilder<QuerySnapshot>(
                        stream: FirebaseFirestore.instance
                            .collection('products')
                            .snapshots(),
                        builder: (context, productsSnap) {
                          return StreamBuilder<DocumentSnapshot>(
                            stream: FirebaseFirestore.instance
                                .collection('admin')
                                .doc('master_wallet')
                                .snapshots(),
                            builder: (context, walletSnap) {
                              final walletData =
                                  walletSnap.data?.data()
                                      as Map<String, dynamic>? ??
                                  {};
                              final double heldRevenue =
                                  (walletData['totalRevenueHeld'] ?? 0.0)
                                      .toDouble();
                              final double earnedCommission =
                                  (walletData['totalCommissionEarned'] ?? 0.0)
                                      .toDouble();
                              (walletData['totalGrossRevenue'] ?? 0.0)
                                  .toDouble();

                              return LayoutBuilder(
                                builder: (context, constraints) {
                                  final double width = constraints.maxWidth;
                                  final int crossAxisCount = width > 1200
                                      ? 5
                                      : (width > 800 ? 3 : 1);

                                  return GridView.count(
                                    shrinkWrap: true,
                                    physics:
                                        const NeverScrollableScrollPhysics(),
                                    crossAxisCount: crossAxisCount,
                                    crossAxisSpacing: 24,
                                    mainAxisSpacing: 24,
                                    childAspectRatio: width > 1200 ? 2.5 : 3.0,
                                    children: [
                                      buildAdminStatCard(
                                        'Total Users',
                                        '${usersSnap.data?.size ?? 0}',
                                        Icons.people,
                                        Colors.blue,
                                      ),
                                      buildAdminStatCard(
                                        'Total Sellers',
                                        '${sellersSnap.data?.size ?? 0}',
                                        Icons.storefront,
                                        Colors.orange,
                                      ),
                                      buildAdminStatCard(
                                        'Total Products',
                                        '${productsSnap.data?.size ?? 0}',
                                        Icons.production_quantity_limits,
                                        WebColors.activeGreeLite,
                                      ),
                                      buildAdminStatCard(
                                        'Returned Products',
                                        '${orders.where((doc) => ['Return Requested', 'Return Approved', 'Item Returned', 'Refund Processed'].contains((doc.data() as Map<String, dynamic>)['status'])).length}',
                                        Icons.assignment_return,
                                        Colors.teal,
                                        onTap: () =>
                                            showAllReturnedProductsDialog(
                                              context,
                                              orders,
                                            ),
                                      ),
                                      buildAdminStatCard(
                                        'Held Revenue',
                                        '₹${heldRevenue.toStringAsFixed(0)}',
                                        Icons.account_balance,
                                        Colors.deepPurple,
                                      ),
                                      buildAdminStatCard(
                                        'Commission',
                                        '₹${earnedCommission.toStringAsFixed(0)}',
                                        Icons.monetization_on,
                                        Colors.indigo,
                                      ),
                                    ],
                                  );
                                },
                              );
                            },
                          );
                        },
                      );
                    },
                  );
                },
              );
            },
          ),

          const SizedBox(height: 32),
          buildHeroCarousel(),
          const SizedBox(height: 32),
        ],
      ),
    );
  }
}
