import 'package:flutter/material.dart';
import 'package:flux_foot_admin/features/category_manager/model/category_model.dart';
import 'package:flux_foot_admin/features/category_manager/views/screen/add_form_screen.dart';
import 'package:flux_foot_admin/features/category_manager/views/screen/edit_categoryfor_screen.dart';

// ! Editing Screen Helper Function
void showEditCategoryModal(BuildContext context, CategoryModel categoryToEdit) {
  showDialog(
    context: context,
    builder: (context) => EditCategoryScreen(category: categoryToEdit),
  );
}


//! Function to show the modal dialog for adding a brand
void showAddCategory(BuildContext context) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return const AddCategoryForm();
    },
  );
}
