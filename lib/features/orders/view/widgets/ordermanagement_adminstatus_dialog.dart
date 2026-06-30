import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

//!  Same logic as seller but with Admin Label
void showAdminStatusDialog(
  BuildContext context,
  String orderId,
  String currentStatus,
) {
  String selectedStatus = currentStatus;
  final List<String> statuses = [
    'Placed',
    'Processing',
    'Shipped',
    'Delivered',
    'Cancelled',
  ];

  showModalBottomSheet(
    context: context,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(25)),
    ),
    builder: (context) {
      return StatefulBuilder(
        builder: (context, setModalState) {
          return Padding(
            padding: const EdgeInsets.all(24.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  "Admin Force Update Status",
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.deepPurple,
                  ),
                ),
                const SizedBox(height: 20),
                Wrap(
                  spacing: 10,
                  children: statuses.map((status) {
                    bool isSelected = selectedStatus == status;
                    return ChoiceChip(
                      label: Text(status),
                      selected: isSelected,
                      selectedColor: Colors.deepPurple,
                      labelStyle: TextStyle(
                        color: isSelected ? Colors.white : Colors.black,
                      ),
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
                      await FirebaseFirestore.instance
                          .collection('orders')
                          .doc(orderId)
                          .update({
                            'status': selectedStatus,
                            'lastUpdated': FieldValue.serverTimestamp(),
                          });

                      // --- NEW: Trigger In-App Notification (Admin Update) ---
                      try {
                        final orderDoc = await FirebaseFirestore.instance
                            .collection('orders')
                            .doc(orderId)
                            .get();
                        final customerId = orderDoc.data()?['userId'];
                        final productName =
                            orderDoc.data()?['productName'] ?? 'Product';
                        if (customerId != null) {
                          await FirebaseFirestore.instance
                              .collection('users')
                              .doc(customerId)
                              .collection('notifications')
                              .add({
                                'title': "Admin: Order Status Updated",
                                'body':
                                    "Your order for '$productName' (#${orderId.substring(0, 8).toUpperCase()}) has been updated to $selectedStatus by FluxFoot Admin.",
                                'isRead': false,
                                'createdAt': FieldValue.serverTimestamp(),
                              });
                        }
                      } catch (e) {
                        debugPrint("Error: $e");
                      }

                      if (context.mounted) {
                        Navigator.pop(context);
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text(
                              "Order status forcefully updated by Admin!",
                            ),
                          ),
                        );
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.deepPurple,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    child: const Text(
                      "Confirm Admin Update",
                      style: TextStyle(color: Colors.white),
                    ),
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
