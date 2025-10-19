import 'package:flutter/material.dart';
import 'package:flux_foot_admin/features/brand_management/model/brand_model.dart';
import 'package:flux_foot_admin/features/brand_management/views/screen/brand_add_form_screen.dart';
import 'package:flux_foot_admin/features/brand_management/views/screen/brand_edit_screen.dart';

//! Function to show the modal dialog for adding a brand
void showAddBrandModal(BuildContext context) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AddBrandScreen();
    },
  );
}

//! Function to show the modal dialog for adding a brand
void showEditBrandModal(BuildContext context, BrandModel brandToEdit) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return BrandEditScreen(brand: brandToEdit);
    },
  );
}
