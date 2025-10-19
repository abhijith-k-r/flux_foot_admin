import 'package:flutter/material.dart';
import 'package:flux_foot_admin/core/constants/web_colors.dart';
import 'package:flux_foot_admin/core/widgets/custom_text.dart';
import 'package:flux_foot_admin/features/brand_management/view_model/provider/brand_provider.dart';
import 'package:provider/provider.dart';

// ! Brand LOGO Adding Widget
Widget buildAddBrandLogo(double size) {
  return Consumer<BrandProvider>(
    builder: (context, brandProvider, child) {
      return Stack(
        alignment: AlignmentGeometry.topRight,
        children: [
          GestureDetector(
            onTap: () => brandProvider.pickAndUploadLogo(),
            child: Container(
              width: size * 0.1,
              height: size * 0.1,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                border: BoxBorder.all(color: WebColors.borderSideGrey),
              ),
              child: brandProvider.selectedLogoUrl != null
                  ? ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: Image.network(
                        brandProvider.selectedLogoUrl!,
                        fit: BoxFit.cover,
                      ),
                    )
                  : Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.upload_file),
                        customText(
                          15,
                          brandProvider.selectedLogoUrl != null
                              ? ' Logo Selected'
                              : 'Upload Logo',
                        ),
                      ],
                    ),
            ),
          ),
          IconButton(
            onPressed: () => brandProvider.clearSelectedLogoUrl(),
            icon: CircleAvatar(
              radius: 10,
              backgroundColor: WebColors.iconGreyShade,
              child: Icon(Icons.close, color: WebColors.iconeWhite, size: 15),
            ),
          ),
        ],
      );
    },
  );
}

// ! Brand LOGO Edit Widget
Widget buildEditBrandLogo(double size) {
  return Consumer<BrandProvider>(
    builder: (context, brandProvider, child) {
      return Stack(
        alignment: AlignmentGeometry.topRight,
        children: [
          GestureDetector(
            onTap: () => brandProvider.pickAndUploadLogo(),
            child: Container(
              width: size * 0.1,
              height: size * 0.1,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                border: BoxBorder.all(color: WebColors.borderSideGrey),
              ),
              child: brandProvider.selectedLogoUrl != null
                  ? ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: Image.network(
                        brandProvider.selectedLogoUrl!,
                        fit: BoxFit.cover,
                      ),
                    )
                  : Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.upload_file),
                        customText(
                          15,
                          brandProvider.selectedLogoUrl != null
                              ? ' Logo Selected'
                              : 'Upload Logo',
                        ),
                      ],
                    ),
            ),
          ),
          IconButton(
            onPressed: () => brandProvider.clearSelectedLogoUrl(),
            icon: CircleAvatar(
              radius: 10,
              backgroundColor: WebColors.iconGreyShade,
              child: Icon(Icons.close, color: WebColors.iconeWhite, size: 15),
            ),
          ),
        ],
      );
    },
  );
}
