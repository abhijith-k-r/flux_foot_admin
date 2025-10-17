import 'package:flutter/material.dart';
import 'package:flux_foot_admin/features/brand_management/views/widgets/brand_form_model.dart';
import 'package:flux_foot_admin/features/brand_management/views/widgets/brand_list_table.dart';

class BrandManagementScreen extends StatelessWidget {
  const BrandManagementScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => _showAddBrandModal(context),
        backgroundColor: const Color(0xFF0b73da),
        label: const Text(
          'Add New Brand',
          style: TextStyle(color: Colors.white),
        ),
        icon: const Icon(Icons.add, color: Colors.white),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(32.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header Section
            const Text(
              'Manage Brands',
              style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),

            // Search and Table
            const BrandListTable(),
          ],
        ),
      ),
    );
  }

  // Function to show the modal dialog for adding/editing a brand
  void _showAddBrandModal(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return const BrandFormModal();
      },
    );
  }
}