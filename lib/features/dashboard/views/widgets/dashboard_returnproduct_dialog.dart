import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

void showAllReturnedProductsDialog(
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
                                order['returnReason'] ?? 'No reason provided.',
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
