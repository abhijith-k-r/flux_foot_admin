// ! Categories Details or Contents From Firebase
import 'package:flutter/material.dart';
import 'package:flux_foot_admin/core/constants/web_colors.dart';
import 'package:flux_foot_admin/core/services/firebase/firebase_brand_service.dart';
import 'package:flux_foot_admin/core/widgets/custom_text.dart';
import 'package:flux_foot_admin/features/brand_management/model/brand_model.dart';
import 'package:flux_foot_admin/features/brand_management/view_model/provider/brand_provider.dart';
import 'package:flux_foot_admin/features/brand_management/views/widgets/drop_down_menu_items.dart';

Container brandContents(
  double size,
  BrandModel brand,
  FirebaseBrandService brandService,
  BrandProvider brandProvider,
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
          child: Center(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              spacing: size * 0.01,
              children: [
                Container(
                  width: size * 0.02,
                  height: size * 0.02,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5),
                    border: BoxBorder.all(
                      color: WebColors.borderSideOrangeAcnt,
                    ),
                  ),
                  child: brand.logoUrl == null
                      ? Icon(Icons.upload_file)
                      : ClipRRect(
                          borderRadius: BorderRadius.circular(10),
                          child: Image.network(
                            brand.logoUrl!,
                            fit: BoxFit.cover,
                          ),
                        ),
                ),
                customText(15, brand.name),
              ],
            ),
          ),
        ),

        SizedBox(
          width: size * 0.15,
          child: Center(
            child: customText(
              15,
              brand.status == 'active' ? 'Active' : 'InActive',
              webcolors: brand.status == 'active'
                  ? WebColors.activeGreen
                  : WebColors.errorRed,
            ),
          ),
        ),

        SizedBox(
          width: size * 0.15,
          child: Center(
            child: Center(child: customText(15, brand.createdAt.toString())),
          ),
        ),

        // ! Show Menu
        SizedBox(
          width: size * 0.15,
          child: CircleAvatar(
            backgroundColor: WebColors.buttonBlue,
            // ! Drop Down Item Showing
            child: buildDropDownActionItems(brand, brandService, brandProvider),
          ),
        ),
      ],
    ),
  );
}
