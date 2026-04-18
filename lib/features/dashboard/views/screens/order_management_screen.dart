// Location: flux_foot_admin/lib/features/dashboard/order_management_screen.dart

// ignore_for_file: use_build_context_synchronously

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class AdminOrderManagement extends StatelessWidget {
  const AdminOrderManagement({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Overall Order Management")),
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance.collection('orders').snapshots(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return const Center(child: CircularProgressIndicator());
          }

          final orders = snapshot.data!.docs;

          return ListView.builder(
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
                              color: Colors.deepPurple,
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
                                : Container(width: 70, height: 70, color: Colors.grey.shade200, child: const Icon(Icons.image)),
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
