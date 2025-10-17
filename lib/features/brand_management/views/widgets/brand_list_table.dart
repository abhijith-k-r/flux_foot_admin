// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:flux_foot_admin/features/brand_management/views/widgets/logo_row.dart';
import 'package:flux_foot_admin/features/category_manager/views/widgets/status_chip.dart';

//! --- Table Widget (Existing Brands) ---
class BrandListTable extends StatelessWidget {
  const BrandListTable({super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 0,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Search Bar and Header
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Existing Brands',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                SizedBox(
                  width: 250,
                  child: TextField(
                    decoration: InputDecoration(
                      hintText: 'Search brands...',
                      prefixIcon: const Icon(Icons.search, size: 20),
                      contentPadding: const EdgeInsets.symmetric(
                        vertical: 10,
                        horizontal: 10,
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                        borderSide: BorderSide(color: Colors.grey.shade300),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            const Divider(height: 32),

            // Data Table (Placeholder for actual content)
            SizedBox(
              width: double.infinity,
              child: DataTable(
                columnSpacing: 24,
                headingRowColor: MaterialStateProperty.resolveWith(
                  (states) => Colors.grey.shade100,
                ),
                columns: const [
                  DataColumn(
                    label: Text(
                      'Brand',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                  DataColumn(
                    label: Text(
                      'Status',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                  DataColumn(
                    label: Text(
                      'Created At',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                  DataColumn(
                    label: Text(
                      'Actions',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    numeric: true,
                  ),
                ],
                rows: [
                  DataRow(
                    cells: [
                      const DataCell(
                        BrandLogoRow(
                          name: 'Brand Alpha',
                          imageUrl:
                              'https://lh3.googleusercontent.com/aida-public/AB6AXuDZuh1sNpoQI_0spN0Db0ZujOfsg40kflHByfAEK6O0VOGQDnYpnHiCJSn5ZK-WwCctZbB4xCrocrxXZc48jCowpN2bRrhkI3lIXPBIEP8wh6tvNvt4_2uHmW0kco3r3Jzi987qdFGbsqVYPmGelC1VUkCVzCbNg9ZICgnfMCK_BQQIVqrovhiQX-8TivfO8QFopQbvCzMt7vxsm6HgpeFkErVvBKBRfCQTWmrLYCQSEYZhk0IKMS-qwKnxd5TGGBrF7t2CddUEJGsl',
                        ),
                      ),
                      const DataCell(
                        StatusChip(label: 'Active', color: Colors.green),
                      ),
                      const DataCell(Text('2023-10-27 10:00')),
                      DataCell(
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            TextButton.icon(
                              onPressed: () {},
                              icon: const Icon(Icons.edit, size: 16),
                              label: const Text('Edit'),
                            ),
                            TextButton.icon(
                              onPressed: () {},
                              icon: const Icon(
                                Icons.delete,
                                size: 16,
                                color: Colors.red,
                              ),
                              label: const Text(
                                'Delete',
                                style: TextStyle(color: Colors.red),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  // Add more rows here...
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
