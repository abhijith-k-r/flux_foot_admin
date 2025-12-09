import 'package:flutter/material.dart';
import 'package:flux_foot_admin/features/category_manager/model/category_model.dart';
import 'package:flux_foot_admin/features/category_manager/view_model/provider/category_provider.dart';
import 'package:flux_foot_admin/features/category_manager/views/screen/add_category_form_screen.dart';
import 'package:flux_foot_admin/features/category_manager/views/screen/edit_categoryform_screen.dart';
import 'package:provider/provider.dart';

// ! Add Screen Helper Function
void showAddCategoryModal(BuildContext context) {
  showDialog(context: context, builder: (context) => AddCategoryForm());
}

// ! Edit Screen Helper Function
void showEditCategoryModal(BuildContext context, CategoryModel categoryToEdit) {

  final viewModel = Provider.of<CategoryViewModel>(context, listen: false);

  viewModel.loadCategoryForEdit(categoryToEdit);
  showDialog(
    context: context,
    builder: (context) => EditCategoryScreen(category: categoryToEdit),
  );
}
