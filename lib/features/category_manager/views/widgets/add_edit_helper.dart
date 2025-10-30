import 'package:flutter/material.dart';
import 'package:flux_foot_admin/features/category_manager/model/category_model.dart';
import 'package:flux_foot_admin/features/category_manager/views/screen/add_edit_form_screen.dart';

// ! Editing Screen Helper Function
void showAddEditCategoryModal(
  BuildContext context,
  CategoryModel? categoryToEdit,
) {
  showDialog(
    context: context,
    builder: (context) => AddEditCategoryForm(categoryToEdit: categoryToEdit),
  );
}
