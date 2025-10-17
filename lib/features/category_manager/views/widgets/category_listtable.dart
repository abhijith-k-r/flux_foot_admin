// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:flux_foot_admin/core/constants/web_colors.dart';
import 'package:flux_foot_admin/core/services/firebase/firebase_category_service.dart';
import 'package:flux_foot_admin/core/widgets/custom_text.dart';
import 'package:flux_foot_admin/features/category_manager/view_model/provider/category_provider.dart';
import 'package:flux_foot_admin/features/category_manager/views/widgets/category_contents.dart';
import 'package:flux_foot_admin/features/category_manager/views/widgets/category_titles_widget.dart';
import 'package:flux_foot_admin/features/category_manager/views/widgets/search_formfield_widget.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:provider/provider.dart';

//! --- Table Widget (Existing Categories) ---
class CategoryListTable extends StatelessWidget {
  const CategoryListTable({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size.width;
    final categoryViewModel = Provider.of<CategoryViewModel>(context);
    final categoryService = FirebaseCategoryService();
    return Card(
      elevation: 1,
      color: WebColors.bgDarkGrey,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                customText(
                  18,
                  'Existing Categories',
                  fontWeight: FontWeight.bold,
                ),
                // ! Search Form Field
                customSearchForm(size, categoryViewModel),
              ],
            ),
            const Divider(height: 32),
            // ! CATEGORIES TITLE
            buildTitleContents(size),
            SizedBox(height: 10),
            Expanded(
              child: Consumer<CategoryViewModel>(
                builder: (context, categoryViewModel, child) {
                  if (categoryViewModel.isLoading &&
                      categoryViewModel.categories.isEmpty) {
                    return Center(
                      child: LoadingAnimationWidget.fourRotatingDots(
                        color: WebColors.logocolor,
                        size: size * 0.10,
                      ),
                    );
                  }
                  final categories = categoryViewModel.categories;
                  if (categories.isEmpty) {
                    return Center(
                      child: customText(16, 'No categories added yet.'),
                    );
                  }
                  return ListView.separated(
                    itemCount: categories.length,
                    separatorBuilder: (context, index) => const Divider(),
                    itemBuilder: (context, index) {
                      final category = categories[index];
                      // ! Category Detaisl (Contents / from Firebase) CONTAINER
                      return categoryContents(
                        size,
                        category,
                        categoryService,
                        categoryViewModel,
                      );
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
