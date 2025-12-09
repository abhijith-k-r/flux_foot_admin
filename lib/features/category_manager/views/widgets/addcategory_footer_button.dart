// ignore_for_file: deprecated_member_use, use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:flux_foot_admin/core/constants/web_colors.dart';
import 'package:flux_foot_admin/features/category_manager/view_model/provider/category_provider.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

// ! Footer Buttons
Container buildAddCategoryFooterButton(BuildContext context) {
  return Container(
    padding: const EdgeInsets.all(24.0),
    decoration: BoxDecoration(
      border: Border(
        top: BorderSide(color: WebColors.textWhiteLite.withOpacity(0.2)),
      ),
    ),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        //!  Cancel Button
        TextButton(
          onPressed: () {
            // Clear form when canceling
            Provider.of<CategoryViewModel>(context, listen: false).clearForm();
            Navigator.pop(context);
          },
          style: TextButton.styleFrom(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
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
        Consumer<CategoryViewModel>(
          builder: (context, viewModel, _) {
            return ElevatedButton(
              onPressed: () async {
                try {
                  await viewModel.addCategories(
                    name: viewModel.nameController.text,
                    description: viewModel.descriptionController.text,
                  );
                  Navigator.pop(context);
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text('Category created successfully!'),
                      backgroundColor: WebColors.activeGreen,
                    ),
                  );
                } catch (e) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(e.toString()),
                      backgroundColor: WebColors.errorRed,
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
              child: Text(
                'Save Category & Define Fields',
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
  );
}
