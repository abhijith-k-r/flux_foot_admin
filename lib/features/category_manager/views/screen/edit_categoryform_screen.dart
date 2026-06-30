// ignore_for_file: deprecated_member_use, use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:flux_foot_admin/core/constants/web_colors.dart';
import 'package:flux_foot_admin/core/widgets/custom_back_button.dart';
import 'package:flux_foot_admin/core/widgets/custom_text.dart';
import 'package:flux_foot_admin/core/widgets/show_snackbar.dart';
import 'package:flux_foot_admin/features/category_manager/model/category_model.dart';
import 'package:flux_foot_admin/features/category_manager/view_model/provider/category_provider.dart';
import 'package:flux_foot_admin/features/category_manager/views/widgets/eidtcategory_scrollable_body.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class EditCategoryScreen extends StatelessWidget {
  final CategoryModel category;
  const EditCategoryScreen({super.key, required this.category});

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
            //! Scrollable Body
            ScrollableBody(),

            //! Footer Buttons
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
                    child: customText(
                      15,
                      'Cancel',
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(width: 12),
                  Consumer<CategoryViewModel>(
                    builder: (context, viewModel, _) {
                      return ElevatedButton(
                        onPressed: () async {
                          try {
                            await viewModel.updateExistingCategory(
                              id: category.id,
                              name: viewModel.nameController.text,
                              description: viewModel.descriptionController.text,
                            );
                            Navigator.pop(context);
                            showOverlaySnackbar(
                              context,
                              'Category Updated successfully!',
                              WebColors.successGreen,
                            );
                          } catch (e) {
                            showOverlaySnackbar(
                              context,
                              e.toString(),
                              WebColors.errorRed,
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
                        child: Text(
                          'Save Category Changes',
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
