import 'package:flutter/material.dart';
import 'package:flux_foot_admin/features/brand_management/views/widgets/reusable_form_element.dart';

// !--- Modal Form Widget (Add/Edit Brand) ---
class BrandFormModal extends StatelessWidget {
  const BrandFormModal({super.key});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Add New Brand'),
      content: SingleChildScrollView(
        child: SizedBox(
          width: 400, // Fixed width for the modal
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              buildTextField(context, 'Brand Name', 'Enter brand name'),
              buildTextField(
                context,
                'Logo URL',
                'https://example.com/logo.png',
                isUrl: true,
              ),
              const SizedBox(height: 8),
              buildToggle(context, 'Is Active'),
            ],
          ),
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: const Text('Cancel', style: TextStyle(color: Colors.grey)),
        ),
        ElevatedButton(
          onPressed: () {
            // Add Brand logic
            Navigator.of(context).pop();
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color(0xFF0b73da),
            padding: const EdgeInsets.symmetric(horizontal: 20),
          ),
          child: const Text('Add Brand', style: TextStyle(color: Colors.white)),
        ),
      ],
    );
  }
}
