// ignore_for_file: deprecated_member_use, use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:flux_foot_admin/core/constants/web_colors.dart';
import 'package:flux_foot_admin/core/widgets/custom_back_button.dart';
import 'package:flux_foot_admin/core/widgets/custom_text.dart';
import 'package:flux_foot_admin/features/category_manager/view_model/provider/category_provider.dart';
import 'package:flux_foot_admin/features/category_manager/views/widgets/addcategory_dynamic_scemasection.dart';
import 'package:flux_foot_admin/features/category_manager/views/widgets/addcategory_footer_button.dart';
import 'package:flux_foot_admin/features/category_manager/views/widgets/form_elements.dart';
import 'package:provider/provider.dart';

//! --- Form Widget (Add New Category) ---
class AddCategoryForm extends StatelessWidget {
  const AddCategoryForm({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size.width;

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
                    'Create New Category',
                    fontWeight: FontWeight.bold,
                    webcolors: WebColors.textWhite,
                  ),
                  customBackButton(context),
                ],
              ),
            ),
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(horizontal: 24.0),
                child: Consumer<CategoryViewModel>(
                  builder: (context, viewModel, _) {
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        //  Standard Fields
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

                        // ! Dynamic Schema Section
                        buildDynamicSchemaSection(viewModel),

                        const SizedBox(height: 24),
                      ],     
                    );
                  },
                ),
              ),
            ),

            // ! Footer Buttons
            buildAddCategoryFooterButton(context),
          ],
        ),
      ),
    );
  }


}







