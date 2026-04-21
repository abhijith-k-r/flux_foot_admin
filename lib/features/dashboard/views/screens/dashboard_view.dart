// ignore_for_file: avoid_types_as_parameter_names, deprecated_member_use

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flux_foot_admin/core/constants/web_colors.dart';
import 'package:flux_foot_admin/features/dashboard/views/widgets/carousel_card.dart';

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
                stream: FirebaseFirestore.instance.collection('users').snapshots(),
                builder: (context, usersSnap) {
                  return StreamBuilder<QuerySnapshot>(
                    stream: FirebaseFirestore.instance.collection('sellers').snapshots(),
                    builder: (context, sellersSnap) {
                      return StreamBuilder<QuerySnapshot>(
                        stream: FirebaseFirestore.instance.collection('products').snapshots(),
                        builder: (context, productsSnap) {
                          return StreamBuilder<DocumentSnapshot>(
                            stream: FirebaseFirestore.instance.collection('admin').doc('master_wallet').snapshots(),
                            builder: (context, walletSnap) {
                              
                              final walletData = walletSnap.data?.data() as Map<String, dynamic>? ?? {};
                              final double heldRevenue = (walletData['totalRevenueHeld'] ?? 0.0).toDouble();
                              final double earnedCommission = (walletData['totalCommissionEarned'] ?? 0.0).toDouble();
                              (walletData['totalGrossRevenue'] ?? 0.0).toDouble();

                              return LayoutBuilder(
                                builder: (context, constraints) {
                                  final double width = constraints.maxWidth;
                                  final int crossAxisCount = width > 1200 ? 5 : (width > 800 ? 3 : 1);
                                  
                                  return GridView.count(
                                    shrinkWrap: true,
                                    physics: const NeverScrollableScrollPhysics(),
                                    crossAxisCount: crossAxisCount,
                                    crossAxisSpacing: 24,
                                    mainAxisSpacing: 24,
                                    childAspectRatio: width > 1200 ? 2.5 : 3.0,
                                    children: [
                                      _buildAdminStatCard('Total Users', '${usersSnap.data?.size ?? 0}', Icons.people, Colors.blue),
                                      _buildAdminStatCard(
                                        'Total Sellers',
                                        '${sellersSnap.data?.size ?? 0}',
                                        Icons.storefront,
                                        Colors.orange,
                                      ),
                                      _buildAdminStatCard(
                                        'Total Products',
                                        '${productsSnap.data?.size ?? 0}',
                                        Icons.production_quantity_limits,
                                        WebColors.activeGreeLite,
                                      ),
                                      _buildAdminStatCard(
                                        'Returned Products', 
                                        '${orders.where((doc) => [
                                          'Return Requested',
                                          'Return Approved',
                                          'Item Returned',
                                          'Refund Processed',
                                        ].contains((doc.data() as Map<String, dynamic>)['status'])).length}', 
                                        Icons.assignment_return, 
                                        Colors.teal,
                                        onTap: () => _showAllReturnedProductsDialog(context, orders),
                                      ),
                                      _buildAdminStatCard('Held Revenue', '₹${heldRevenue.toStringAsFixed(0)}', Icons.account_balance, Colors.deepPurple),
                                      _buildAdminStatCard('Commission', '₹${earnedCommission.toStringAsFixed(0)}', Icons.monetization_on, Colors.indigo),
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

  Widget _buildAdminStatCard(String title, String value, IconData icon, Color color, {VoidCallback? onTap}) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(16),
      child: Container(
        padding: const EdgeInsets.all(24),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(color: color.withOpacity(0.1), blurRadius: 10, offset: const Offset(0, 4)),
          ],
        ),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: color.withOpacity(0.1),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Icon(icon, color: color, size: 28),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(title, style: TextStyle(color: Colors.grey.shade600, fontSize: 13, fontWeight: FontWeight.w500)),
                  const SizedBox(height: 4),
                  Text(value, style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _showAllReturnedProductsDialog(
    BuildContext context,
    List<QueryDocumentSnapshot> allOrders,
  ) {
    final returnedOrders = allOrders.where((doc) {
      final status = (doc.data() as Map<String, dynamic>)['status'];
      return [
        'Return Requested',
        'Return Approved',
        'Item Returned',
        'Refund Processed',
      ].contains(status);
    }).toList();

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text("Global Returned Products"),
        content: SizedBox(
          width: 600,
          child: returnedOrders.isEmpty
              ? const Center(
                  child: Text("No returned products across the platform."),
                )
              : ListView.separated(
                  shrinkWrap: true,
                  itemCount: returnedOrders.length,
                  separatorBuilder: (context, index) => const Divider(),
                  itemBuilder: (context, index) {
                    final order =
                        returnedOrders[index].data() as Map<String, dynamic>;
                    final sellerId = order['sellerId'] ?? '';

                    return Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              ClipRRect(
                                borderRadius: BorderRadius.circular(8),
                                child: order['productImage'] != null
                                    ? Image.network(
                                        order['productImage'],
                                        width: 50,
                                        height: 50,
                                        fit: BoxFit.cover,
                                      )
                                    : Container(
                                        width: 50,
                                        height: 50,
                                        color: Colors.grey.shade200,
                                      ),
                              ),
                              const SizedBox(width: 12),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      order['productName'] ?? 'Product',
                                      style: const TextStyle(
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    FutureBuilder<DocumentSnapshot>(
                                      future: FirebaseFirestore.instance
                                          .collection('sellers')
                                          .doc(sellerId)
                                          .get(),
                                      builder: (context, snap) {
                                        if (snap.connectionState ==
                                            ConnectionState.waiting) {
                                          return const Text(
                                            "Loading seller...",
                                            style: TextStyle(fontSize: 11),
                                          );
                                        }
                                        final sData =
                                            snap.data?.data()
                                                as Map<String, dynamic>?;
                                        final sName =
                                            sData?['storeName'] ??
                                            sData?['name'] ??
                                            'Unknown Seller';
                                        return Text(
                                          "Seller: $sName",
                                          style: const TextStyle(
                                            fontSize: 12,
                                            color: Colors.deepPurple,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        );
                                      },
                                    ),
                                  ],
                                ),
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  Text(
                                    "₹${order['totalAmount']}",
                                    style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: Colors.green,
                                    ),
                                  ),
                                  Text(
                                    order['status'] ?? '',
                                    style: const TextStyle(
                                      fontSize: 10,
                                      color: Colors.orange,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                          const SizedBox(height: 8),
                          Container(
                            width: double.infinity,
                            padding: const EdgeInsets.all(10),
                            decoration: BoxDecoration(
                              color: Colors.grey.shade50,
                              borderRadius: BorderRadius.circular(8),
                              border: Border.all(color: Colors.grey.shade200),
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Issue reported by User:",
                                  style: TextStyle(
                                    fontSize: 11,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.grey.shade700,
                                  ),
                                ),
                                Text(
                                  order['returnReason'] ??
                                      'No reason provided.',
                                  style: const TextStyle(fontSize: 13),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text("Close"),
          ),
        ],
      ),
    );
  }
}
