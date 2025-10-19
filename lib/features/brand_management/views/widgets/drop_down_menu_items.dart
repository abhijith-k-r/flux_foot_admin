import 'package:flutter/material.dart';
import 'package:flux_foot_admin/core/constants/web_colors.dart';
import 'package:flux_foot_admin/core/services/firebase/firebase_brand_service.dart';
import 'package:flux_foot_admin/core/widgets/custom_text.dart';
import 'package:flux_foot_admin/features/brand_management/model/brand_model.dart';
import 'package:flux_foot_admin/features/brand_management/view_model/provider/brand_provider.dart';
import 'package:flux_foot_admin/features/brand_management/views/widgets/add_edit_helper_functions.dart';

// ! DROP DOWN WIDGET FOR EDIT|| BLOCK || DELETE
Widget buildDropDownActionItems(
  BrandModel brand,
  FirebaseBrandService brandService,
  BrandProvider brandProvider,
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
            showEditBrandModal(context, brand);
          },
          child: customText(15, 'Edit', webcolors: WebColors.buttonBlue),
        ),
      ),

      // !For BLOCK AND UNBLOCK
      brand.status == 'active'
          ? PopupMenuItem<String>(
              value: 'block',
              child: TextButton(
                onPressed: () {
                  // Close the menu
                  Navigator.pop(context);
                  // !Execute the 'Block' functionality
                  brandService.updateBrandStatus(context, brand, 'Block');
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
                  brandService.updateBrandStatus(context, brand, 'UnBlock');
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
            brandProvider.deleteBrand(brand);
            Navigator.pop(context);
          },
          child: customText(15, 'Delete', webcolors: WebColors.errorRed),
        ),
      ),
    ],
    onSelected: (String result) {},
  );
}
