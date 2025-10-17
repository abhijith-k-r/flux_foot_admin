import 'package:flutter/material.dart';
import 'package:flux_foot_admin/core/constants/web_colors.dart';
import 'package:flux_foot_admin/core/services/firebase/firebase_category_service.dart';
import 'package:flux_foot_admin/core/widgets/custom_text.dart';
import 'package:flux_foot_admin/features/category_manager/model/category_model.dart';
import 'package:flux_foot_admin/features/category_manager/view_model/provider/category_provider.dart';
import 'package:flux_foot_admin/features/category_manager/views/widgets/add_edit_helper.dart';

// ! DROP DOWN WIDGET FOR EDIT|| BLOCK || DELETE
Widget buildDropDownActionItems(
  CategoryModel category,
  FirebaseCategoryService categoryService,
  CategoryViewModel categoryViewModel,
) {
  return PopupMenuButton<String>(
    icon: Icon(Icons.more_vert, color: WebColors.iconeWhite),

    itemBuilder: (context) => <PopupMenuEntry<String>>[
      // ! FOR EDIT
      PopupMenuItem<String>(
        value: 'edit',
        child: TextButton(
          onPressed: () {
            // Close the menu
            Navigator.pop(context);
            //! Execute the 'Edit' functionality
            showEditCategoryModal(context, category);
          },
          child: customText(15, 'Edit', webcolors: WebColors.buttonBlue),
        ),
      ),

      // !For BLOCK AND UNBLOCK
      category.status == 'active'
          ? PopupMenuItem<String>(
              value: 'block',
              child: TextButton(
                onPressed: () {
                  // Close the menu
                  Navigator.pop(context);
                  // !Execute the 'Block' functionality
                  categoryService.updateCategoryStatus(
                    context,
                    category,
                    'Block',
                  );
                },
                child: customText(15, 'Block', webcolors: WebColors.errorRed),
              ),
            )
          : PopupMenuItem<String>(
              value: 'unblock',
              child: TextButton(
                onPressed: () {
                  // Close the menu
                  Navigator.pop(context);
                  //! Execute the 'UnBlock' functionality
                  categoryService.updateCategoryStatus(
                    context,
                    category,
                    'UnBlock',
                  );
                },
                child: customText(
                  15,
                  'UnBlock',
                  webcolors: WebColors.activeGreen,
                ),
              ),
            ),

      // ! For DELETE
      PopupMenuItem<String>(
        child: TextButton(
          onPressed: () {
            categoryViewModel.deleteCategories(category);
            Navigator.pop(context);
          },
          child: customText(15, 'Delete', webcolors: WebColors.errorRed),
        ),
      ),
    ],
    onSelected: (String result) {},
  );
}
