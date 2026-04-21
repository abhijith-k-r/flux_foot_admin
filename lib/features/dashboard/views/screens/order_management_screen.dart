// Location: flux_foot_admin/lib/features/dashboard/order_management_screen.dart

// ignore_for_file: use_build_context_synchronously

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flux_foot_admin/core/constants/web_colors.dart';

class AdminOrderManagement extends StatelessWidget {
  const AdminOrderManagement({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance.collection('orders').snapshots(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return const Center(child: CircularProgressIndicator());
          }

          final orders = snapshot.data!.docs;

          return Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                  
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                      decoration: BoxDecoration(
                        color: WebColors.bgWhite, 
                        borderRadius: BorderRadius.circular(20)
                      ),
                      child: Text(
                        "Total Orders: ${orders.length}", 
                        style: const TextStyle(fontWeight: FontWeight.bold, color: Colors.deepPurple)
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: ListView.builder(
                  itemCount: orders.length,
            itemBuilder: (context, index) {
              final order = orders[index].data() as Map<String, dynamic>;
              final orderId = orders[index].id;

              final shippingInfo = order['shippingAddress'] as Map<String, dynamic>? ?? {};
              final customerName = shippingInfo['name'] ?? shippingInfo['fullName'] ?? shippingInfo['firstName'] ?? 'Customer';
              final city = shippingInfo['city'] ?? 'Unknown City';
              final qty = order['quantity'] ?? 1;
              final amount = order['totalAmount'] ?? 0.0;
              final paymentType = order['paymentType'] ?? 'Unknown';

              return Card(
                // color: WebColors.bgDarkBlue1,
                margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                elevation: 2,
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Top specific bar
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "ID: ${orderId.substring(0, 8).toUpperCase()}", 
                            style: TextStyle(fontWeight: FontWeight.bold, color: Colors.grey.shade700)
                          ),
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                            decoration: BoxDecoration(
                              color: WebColors.buttonBlue,
                              borderRadius: BorderRadius.circular(8)
                            ),
                            child: Text(
                              order['status'] ?? 'Pending', 
                              style: const TextStyle(color: Colors.white, fontWeight: FontWeight.w600, fontSize: 12)
                            ),
                          ),
                        ],
                      ),
                      const Divider(height: 24),
                      // Product Info section
                      Row(
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(8),
                            child: order['productImage'] != null && order['productImage'].toString().isNotEmpty
                                ? Image.network(order['productImage'], width: 70, height: 70, fit: BoxFit.cover)
                                : Container(width: 70, height: 70, 
                                color: Colors.grey.shade200, 
                                child: const Icon(Icons.image)),
                          ),
                          const SizedBox(width: 16),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  order['productName'] ?? 'Unknown Product', 
                                  style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                ),
                                FutureBuilder<DocumentSnapshot>(
                                  future: FirebaseFirestore.instance.collection('sellers').doc(order['sellerId']).get(),
                                  builder: (context, sellerSnap) {
                                    String storeName = "Fetching...";
                                    if (sellerSnap.hasData && sellerSnap.data!.exists) {
                                      final Map<String, dynamic>? sData = sellerSnap.data!.data() as Map<String, dynamic>?;
                                      if (sData != null) {
                                        storeName = sData['storeName'] ?? sData['name'] ?? 'Unknown Store';
                                      }
                                    }
                                    return Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          "Seller: $storeName",
                                          style: const TextStyle(
                                            fontSize: 12,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.deepPurple,
                                          ),
                                        ),
                                        Text(
                                          "Seller ID: ${order['sellerId']}",
                                          style: TextStyle(
                                            fontSize: 10,
                                            color: Colors.grey.shade500,
                                          ),
                                        ),
                                      ],
                                    );
                                  },
                                ),
                                const SizedBox(height: 6),
                                Text(
                                  "Qty: $qty  •  Total: ₹$amount",
                                  style: const TextStyle(color: Colors.black87, fontWeight: FontWeight.w500)
                                ),
                                const SizedBox(height: 4),
                                Text(
                                  "Payment: $paymentType",
                                  style: TextStyle(color: Colors.green.shade700, fontWeight: FontWeight.w600, fontSize: 12)
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 16),
                      // Customer info bubble
                      Container(
                        padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          color: Colors.grey.shade50,
                          borderRadius: BorderRadius.circular(8),
                          border: Border.all(color: Colors.grey.shade200)
                        ),
                        child: Row(
                          children: [
                            const Icon(Icons.person, color: Colors.deepPurple, size: 20),
                            const SizedBox(width: 12),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(customerName, style: const TextStyle(fontWeight: FontWeight.w600)),
                                  Text("Location: $city", style: TextStyle(color: Colors.grey.shade600, fontSize: 13)),
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                      const SizedBox(height: 16),
                      // --- NEW: THE ADMIN PAYOUT GATEWAY ---
                      if (order['status'] == 'Delivered' && order['paymentReleased'] != true)
                        Padding(
                          padding: const EdgeInsets.only(bottom: 8.0),
                          child: SizedBox(
                            width: double.infinity,
                            child: ElevatedButton.icon(
                              onPressed: () async {
                                final double total = (order['totalAmount'] is String) 
                                    ? double.tryParse(order['totalAmount']) ?? 0.0 
                                    : (order['totalAmount'] ?? 0.0).toDouble();
                                
                                double sEarning = (order['sellerEarning'] ?? 0.0).toDouble();
                                double aCommission = (order['adminCommission'] ?? 0.0).toDouble();
                                
                                if (sEarning == 0 && total > 0) {
                                  aCommission = total * 0.10;
                                  sEarning = total - aCommission;
                                }

                                // 1. Update Seller Wallet
                                await FirebaseFirestore.instance.collection('sellers').doc(order['sellerId']).set({
                                  'walletBalance': FieldValue.increment(sEarning),
                                }, SetOptions(merge: true));

                                // 2. Update Admin Master Wallet
                                await FirebaseFirestore.instance.collection('admin').doc('master_wallet').set({
                                  'totalRevenueHeld': FieldValue.increment(-total),
                                  'totalCommissionEarned': FieldValue.increment(aCommission),
                                  // NOTE: We don't touch totalGrossRevenue here as it was already recorded at checkout
                                }, SetOptions(merge: true));

                                // 3. Mark payment as released
                                await FirebaseFirestore.instance.collection('orders').doc(orderId).update({
                                  'paymentReleased': true,
                                  'paymentReleasedAt': FieldValue.serverTimestamp(),
                                  'sellerEarning': sEarning,
                                  'adminCommission': aCommission,
                                });

                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(content: Text("Payment successfully released to Seller!")),
                                );
                              },
                              icon: const Icon(Icons.payments, color: Colors.white),
                              label: const Text("Release Payment to Seller"),
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.blueAccent,
                                padding: const EdgeInsets.symmetric(vertical: 12),
                                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8))
                              ),
                            ),
                          ),
                        ),

                      if (order['paymentReleased'] == true)
                        const Padding(
                          padding: EdgeInsets.symmetric(vertical: 8.0),
                          child: Center(
                            child: Text(
                              "✅ Payment Released to Seller",
                              style: TextStyle(color: Colors.green, fontWeight: FontWeight.bold),
                            ),
                          ),
                        ),

                      const SizedBox(height: 16),
                      // --- NEW: THE ADMIN REFUND GATEWAY ---
                      if (order['status'] == 'Item Returned')
                        Padding(
                          padding: const EdgeInsets.only(bottom: 8.0),
                          child: SizedBox(
                            width: double.infinity,
                            child: ElevatedButton.icon(
                              onPressed: () async {
                                // 1. Real World logic triggers Stripe Refund Protocol here
                                
                                // 2. Reverse Financial Wallet Flow
                                final double totalAmount = (order['totalAmount'] ?? 0.0).toDouble();
                                final double sellerEarning = (order['sellerEarning'] ?? 0.0).toDouble();
                                final double adminCommission = (order['adminCommission'] ?? 0.0).toDouble();
                                
                                if (order['sellerId'] != null) {
                                  try {
                                    final sellerDoc = await FirebaseFirestore.instance.collection('sellers').doc(order['sellerId']).get();
                                    double currentBalance = (sellerDoc.data()?['walletBalance'] ?? 0.0).toDouble();
                                    
                                    // Calculate how much safe deduction we can make
                                    // We should not deduct more than what the seller currently has 
                                    double deduction = sellerEarning;
                                    if (currentBalance < sellerEarning) {
                                      deduction = currentBalance; // Cap at current balance to avoid negative
                                    }

                                    await FirebaseFirestore.instance.collection('sellers').doc(order['sellerId']).update({
                                      'walletBalance': FieldValue.increment(-deduction)
                                    });
                                  } catch (_) {} // Handle if doc not strictly initialized
                                }
                                
                                try {
                                  // Admin keeps the commission! Only refund the seller's portion.
                                  // totalRevenueHeld is reduced by the refund amount (total - commission)
                                  final double refundAmount = totalAmount - adminCommission;
                                  
                                  await FirebaseFirestore.instance.collection('admin').doc('master_wallet').update({
                                    'totalRevenueHeld': FieldValue.increment(-refundAmount),
                                    // totalCommissionEarned remains UNCHANGED because Admin keeps the fee.
                                  });
                                } catch (_) {}

                                // 3. Update Status
                                await FirebaseFirestore.instance
                                    .collection('orders')
                                    .doc(orderId)
                                    .update({
                                      'status': 'Refund Processed',
                                      'lastUpdated':
                                          FieldValue.serverTimestamp(),
                                    });
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                    content: Text(
                                      "Money successfully refunded to Customer!",
                                    ),
                                  ),
                                );
                              },
                              icon: const Icon(
                                Icons.attach_money,
                                color: Colors.white,
                              ),
                              label: const Text(
                                "Process Refund (Send Money Back)",
                              ),
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.green,
                                padding: const EdgeInsets.symmetric(
                                  vertical: 12,
                                ),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8),
                                ),
                              ),
                            ),
                          ),
                        ),
                      const SizedBox(height: 16),
                      // Action Button
                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton.icon(
                          onPressed: () => _showAdminStatusDialog(context, orderId, order['status']),
                          icon: const Icon(Icons.edit, color: Colors.white, size: 18),
                          label: const Text("Edit Order Status", style: TextStyle(color: Colors.white)),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.deepPurple,
                            padding: const EdgeInsets.symmetric(vertical: 12),
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8))
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
              ),
            ],
          );
        },
      ),
    );
  }

  // Same logic as seller but with Admin Label
  void _showAdminStatusDialog(
    BuildContext context,
    String orderId,
    String currentStatus,
  ) {
    String selectedStatus = currentStatus;
    final List<String> statuses = ['Placed', 'Processing', 'Shipped', 'Delivered', 'Cancelled'];

    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(borderRadius: BorderRadius.vertical(top: Radius.circular(25))),
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setModalState) {
            return Padding(
              padding: const EdgeInsets.all(24.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text("Admin Force Update Status", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.deepPurple)),
                  const SizedBox(height: 20),
                  Wrap(
                    spacing: 10,
                    children: statuses.map((status) {
                      bool isSelected = selectedStatus == status;
                      return ChoiceChip(
                        label: Text(status),
                        selected: isSelected,
                        selectedColor: Colors.deepPurple,
                        labelStyle: TextStyle(color: isSelected ? Colors.white : Colors.black),
                        onSelected: (selected) {
                          if (selected) {
                            setModalState(() => selectedStatus = status);
                          }
                        },
                      );
                    }).toList(),
                  ),
                  const SizedBox(height: 30),
                  SizedBox(
                    width: double.infinity,
                    height: 50,
                    child: ElevatedButton(
                      onPressed: () async {
                        await FirebaseFirestore.instance.collection('orders').doc(orderId).update({
                          'status': selectedStatus,
                          'lastUpdated': FieldValue.serverTimestamp(),
                        });
                        Navigator.pop(context);
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text("Order status forcefully updated by Admin!")),
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.deepPurple,
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                      ),
                      child: const Text("Confirm Admin Update", style: TextStyle(color: Colors.white)),
                    ),
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }
}
