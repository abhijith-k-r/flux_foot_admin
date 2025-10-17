import 'package:flutter/material.dart';
import 'package:flux_foot_admin/core/constants/web_colors.dart';
import 'package:flux_foot_admin/features/category_manager/views/widgets/add_edit_helper.dart';
import 'package:flux_foot_admin/features/category_manager/views/widgets/category_listtable.dart';

class CategoryManagementScreen extends StatelessWidget {
  const CategoryManagementScreen({super.key});

  @override
  Widget build(BuildContext context) {
  

    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        spacing: 10,
        children: [
          ElevatedButton.icon(
            onPressed: () => showAddCategory(context),
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
          Expanded(child: CategoryListTable()),
        ],
      ),
    );
  }
}
