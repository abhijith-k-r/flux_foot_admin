import 'package:flutter/material.dart';
import 'package:flux_foot_admin/core/constants/web_colors.dart';
import 'package:flux_foot_admin/core/services/firebase/firebase_category_service.dart';
import 'package:flux_foot_admin/core/widgets/custom_text.dart';
import 'package:flux_foot_admin/features/category_manager/model/category_model.dart';
import 'package:flux_foot_admin/features/category_manager/view_model/provider/category_provider.dart';
import 'package:flux_foot_admin/features/category_manager/views/widgets/dropdown_menu_items.dart';
import 'package:intl/intl.dart';

// ! Categories Details or Contents From Firebase
Container categoryContents(
  double size,
  CategoryModel category,
  FirebaseCategoryService categoryService,
  CategoryViewModel categoryViewModel,
) {
  return Container(
    width: double.infinity,
    height: 40,
    decoration: BoxDecoration(
      color: WebColors.bgDarkBlue1,
      borderRadius: BorderRadius.circular(8),
    ),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        SizedBox(
          width: size * 0.15,
          child: Center(child: customText(15, category.name)),
        ),
        SizedBox(
          width: size * 0.15,
          child: Center(child: customText(15, category.description.toString())),
        ),

        SizedBox(
          width: size * 0.15,
          child: Center(
            child: customText(
              15,
              category.status == 'active' ? 'Active' : 'Blocked',
              webcolors: category.status == 'active'
                  ? WebColors.activeGreen
                  : WebColors.errorRed,
            ),
          ),
        ),

        SizedBox(
          width: size * 0.15,
          child: Center(
            child: Center(
              child: customText(
                15,
                "${DateFormat.yMMMEd().format(category.createdAt)} ${DateFormat.j().format(category.createdAt)}",
              ),
            ),
          ),
        ),

        // ! Show Menu
        SizedBox(
          width: size * 0.15,
          child: CircleAvatar(
            backgroundColor: WebColors.buttonBlue,
            // ! Drop Down Item Showing
            child: buildDropDownActionItems(
              category,
              categoryService,
              categoryViewModel,
            ),
          ),
        ),
      ],
    ),
  );
}
