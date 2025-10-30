// ignore_for_file: deprecated_member_use, use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:flux_foot_admin/core/constants/web_colors.dart';
import 'package:flux_foot_admin/core/widgets/custom_back_button.dart';
import 'package:flux_foot_admin/core/widgets/custom_text.dart';
import 'package:flux_foot_admin/features/category_manager/model/category_model.dart';
import 'package:flux_foot_admin/features/category_manager/view_model/provider/category_provider.dart';
import 'package:flux_foot_admin/features/category_manager/views/screen/dynamic_field_row.dart';
import 'package:flux_foot_admin/features/category_manager/views/widgets/form_elements.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

//! --- Form Widget (Add New Category) ---
class AddEditCategoryForm extends StatelessWidget {
  final CategoryModel? categoryToEdit;
  const AddEditCategoryForm({super.key, this.categoryToEdit});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size.width;
    final isEditMode = categoryToEdit != null;

    //! Load category data if editing
    final viewModel = Provider.of<CategoryViewModel>(context, listen: false);

    if (isEditMode && categoryToEdit != null) {
      viewModel.loadCategoryForEdit(categoryToEdit!);
    }

    return Dialog(
      child: Container(
        width: size * 0.7,
        constraints: BoxConstraints(
          maxHeight: MediaQuery.of(context).size.height * 0.9,
        ),
        decoration: BoxDecoration(
          color: WebColors.bgDarkGrey,
          borderRadius: BorderRadius.circular(15),
        ),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(24.0),

              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  customText(
                    18,
                    isEditMode ? 'Edit Category' : 'Create New Category',
                    fontWeight: FontWeight.bold,
                    webcolors: WebColors.textWhite,
                  ),
                  customBackButton(context),
                ],
              ),
            ),
            // Scrollable Body
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(horizontal: 24.0),
                child: Consumer<CategoryViewModel>(
                  builder: (context, viewModel, _) {
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Standard Fields
                        buildTextField(
                          context,
                          'Category Name',
                          'e.g., Men\'s Football Jerseys',
                          viewModel.nameController,
                        ),
                        buildTextArea(
                          context,
                          'Description',
                          'Enter a detailed description for this category...',
                          viewModel.descriptionController,
                        ),

                        const SizedBox(height: 24),

                        // Dynamic Schema Section
                        Container(
                          padding: const EdgeInsets.all(16),
                          decoration: BoxDecoration(
                            color: WebColors.bgDarkGrey.withOpacity(0.5),
                            borderRadius: BorderRadius.circular(8),
                            border: Border.all(
                              color: WebColors.textWhiteLite.withOpacity(0.2),
                            ),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        'Seller Product Fields (Dynamic Schema)',
                                        style: GoogleFonts.openSans(
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold,
                                          color: WebColors.textWhite,
                                        ),
                                      ),
                                      const SizedBox(height: 4),
                                      Text(
                                        'Define custom fields sellers will fill for this category',
                                        style: GoogleFonts.openSans(
                                          fontSize: 12,
                                          color: WebColors.textWhiteLite,
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),

                              const SizedBox(height: 16),

                              // Dynamic Fields List
                              if (viewModel.dynamicFields.isEmpty)
                                Center(
                                  child: Padding(
                                    padding: const EdgeInsets.all(16.0),
                                    child: Text(
                                      'No fields added yet. Click "Add Field" to start.',
                                      style: GoogleFonts.openSans(
                                        color: WebColors.textWhiteLite,
                                        fontSize: 14,
                                      ),
                                    ),
                                  ),
                                ),

                              ...viewModel.dynamicFields.map((field) {
                                return DynamicFieldRow(
                                  field: field,
                                  onRemove: () =>
                                      viewModel.removeDynamicField(field.id),
                                  onLabelChanged: (label) => viewModel
                                      .updateFieldLabel(field.id, label),
                                  onTypeChanged: (type) =>
                                      viewModel.updateFieldType(field.id, type),
                                  onRequiredChanged: (isRequired) =>
                                      viewModel.updateFieldRequired(
                                        field.id,
                                        isRequired,
                                      ),
                                  onOptionsChanged: (options) => viewModel
                                      .updateFieldOptions(field.id, options),
                                );
                              }),

                              const SizedBox(height: 12),

                              // Add Field Button
                              TextButton.icon(
                                onPressed: viewModel.addDynamicField,
                                icon: Icon(
                                  Icons.add,
                                  color: WebColors.buttonBlue,
                                  size: 20,
                                ),
                                label: Text(
                                  'Add Another Field',
                                  style: GoogleFonts.openSans(
                                    color: WebColors.buttonBlue,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                style: TextButton.styleFrom(
                                  backgroundColor: WebColors.buttonBlue
                                      .withOpacity(0.1),
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 16,
                                    vertical: 12,
                                  ),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),

                        const SizedBox(height: 24),
                      ],
                    );
                  },
                ),
              ),
            ),

            // Footer Buttons
            Container(
              padding: const EdgeInsets.all(24.0),
              decoration: BoxDecoration(
                border: Border(
                  top: BorderSide(
                    color: WebColors.textWhiteLite.withOpacity(0.2),
                  ),
                ),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  // Cancel Button
                  TextButton(
                    onPressed: () {
                      // Clear form when canceling
                      Provider.of<CategoryViewModel>(
                        context,
                        listen: false,
                      ).clearForm();
                      Navigator.pop(context);
                    },
                    style: TextButton.styleFrom(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 24,
                        vertical: 12,
                      ),
                      backgroundColor: WebColors.textWhiteLite.withOpacity(0.1),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    child: Text(
                      'Cancel',
                      style: GoogleFonts.openSans(
                        color: WebColors.textWhite,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  // Save/Update Button
                  Consumer<CategoryViewModel>(
                    builder: (context, viewModel, _) {
                      return ElevatedButton(
                        onPressed: viewModel.isLoading
                            ? null // Disable when loading
                            : () async {
                                // Validate first
                                final validationError = viewModel
                                    .validateFields();

                                if (validationError != null) {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                      content: Text(validationError),
                                      backgroundColor: Colors.red,
                                    ),
                                  );
                                  return;
                                }

                                bool success;

                                // Check if we're editing or adding
                                if (isEditMode && categoryToEdit != null) {
                                  // UPDATE MODE
                                  success = await viewModel
                                      .updateExistingCategory(
                                        id: categoryToEdit!.id,
                                        name: viewModel.nameController.text,
                                        description: viewModel
                                            .descriptionController
                                            .text,
                                      );
                                } else {
                                  // ADD MODE
                                  success = await viewModel.addCategories(
                                    name: viewModel.nameController.text,
                                    description:
                                        viewModel.descriptionController.text,
                                  );
                                }

                                // Show result
                                if (success && context.mounted) {
                                  Navigator.pop(context);
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                      content: Text(
                                        isEditMode
                                            ? 'Category updated successfully!'
                                            : 'Category created successfully!',
                                      ),
                                      backgroundColor: Colors.green,
                                    ),
                                  );
                                } else if (context.mounted) {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                      content: Text(
                                        isEditMode
                                            ? 'Failed to update category'
                                            : 'Failed to create category',
                                      ),
                                      backgroundColor: Colors.red,
                                    ),
                                  );
                                }
                              },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: WebColors.buttonBlue,
                          padding: const EdgeInsets.symmetric(
                            horizontal: 24,
                            vertical: 12,
                          ),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                        child: viewModel.isLoading
                            ? const SizedBox(
                                height: 20,
                                width: 20,
                                child: CircularProgressIndicator(
                                  color: Colors.white,
                                  strokeWidth: 2,
                                ),
                              )
                            : Text(
                                isEditMode
                                    ? 'Update Category'
                                    : 'Save Category & Define Fields',
                                style: GoogleFonts.openSans(
                                  color: WebColors.textWhite,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                      );
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
