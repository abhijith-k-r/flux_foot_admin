import 'package:flutter/material.dart';
import 'package:flux_foot_admin/core/constants/web_colors.dart';
import 'package:flux_foot_admin/features/brand_management/view_model/provider/brand_provider.dart';
import 'package:flux_foot_admin/features/brand_management/views/widgets/add_edit_helper_functions.dart';
import 'package:flux_foot_admin/features/brand_management/views/widgets/brand_list_table.dart';
import 'package:provider/provider.dart';

class BrandManagementScreen extends StatelessWidget {
  const BrandManagementScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        spacing: 10,
        children: [
          ElevatedButton.icon(
            onPressed: () {
              final provider = context.read<BrandProvider>();
              provider.clearSelectedLogoUrl();
              showAddBrandModal(context);
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: WebColors.buttonBlue,
              foregroundColor: WebColors.textWhite,
              padding: const EdgeInsets.symmetric(
                horizontal: 16.0,
                vertical: 8.0,
              ),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
            icon: const Icon(Icons.add),
            label: const Text('Add New Brand'),
          ),
          // ! Category Table
          Expanded(child: BrandListTable()),
        ],
      ),
    );
  }
}
