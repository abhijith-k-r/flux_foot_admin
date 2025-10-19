// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:flux_foot_admin/core/constants/web_colors.dart';
import 'package:flux_foot_admin/core/services/firebase/firebase_brand_service.dart';
import 'package:flux_foot_admin/core/widgets/custom_text.dart';
import 'package:flux_foot_admin/features/brand_management/view_model/provider/brand_provider.dart';
import 'package:flux_foot_admin/features/brand_management/views/widgets/brand_contents.dart';
import 'package:flux_foot_admin/features/brand_management/views/widgets/brand_title_widget.dart';
import 'package:flux_foot_admin/features/brand_management/views/widgets/search_formfield_widget.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:provider/provider.dart';

//! --- Table Widget (Existing Brands) ---
class BrandListTable extends StatelessWidget {
  const BrandListTable({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size.width;
    final brandProvider = Provider.of<BrandProvider>(context);
    final brandService = FirebaseBrandService();
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
                  'Existing Brands',
                  fontWeight: FontWeight.bold,
                ),
                // ! Search Form Field
                customSearchForm(size, brandProvider),
              ],
            ),
            const Divider(height: 32),
            // ! BRAND TITLE
            buildTitleContents(size),
            SizedBox(height: 10),
            Expanded(
              child: Consumer<BrandProvider>(
                builder: (context, categoryViewModel, child) {
                  if (categoryViewModel.isLoading &&
                      categoryViewModel.brands.isEmpty) {
                    return Center(
                      child: LoadingAnimationWidget.fourRotatingDots(
                        color: WebColors.logocolor,
                        size: size * 0.10,
                      ),
                    );
                  }
                  final categories = categoryViewModel.brands;
                  if (categories.isEmpty) {
                    return Center(
                      child: customText(16, 'No Brands added yet.'),
                    );
                  }
                  return ListView.separated(
                    itemCount: categories.length,
                    separatorBuilder: (context, index) => const Divider(),
                    itemBuilder: (context, index) {
                      final category = categories[index];
                      // ! Brand Detaisl (Contents / from Firebase) CONTAINER
                      return brandContents(
                        size,
                        category,
                        brandService,
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
