import 'package:flutter/material.dart';
import 'package:flux_foot_admin/core/constants/web_colors.dart';
import 'package:flux_foot_admin/core/widgets/custom_back_button.dart';
import 'package:flux_foot_admin/core/widgets/custom_text.dart';
import 'package:flux_foot_admin/features/brand_management/model/brand_model.dart';
import 'package:flux_foot_admin/features/brand_management/view_model/provider/brand_provider.dart';
import 'package:flux_foot_admin/features/brand_management/views/widgets/add_edit_brand_logo_widget.dart';
import 'package:flux_foot_admin/features/category_manager/views/widgets/form_elements.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class BrandEditScreen extends StatelessWidget {
  final BrandModel brand;
  const BrandEditScreen({super.key, required this.brand});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size.width;

    final brandProvider = Provider.of<BrandProvider>(context, listen: false);
    final nameController = TextEditingController(text: brand.name);

    Future.microtask(() {
      brandProvider.setInitialLogoUrl(brand.logoUrl);
    });
    return Dialog(
      child: Container(
        width: size * 0.7,
        height: size * 0.7,
        decoration: BoxDecoration(
          color: WebColors.bgDarkGrey,
          borderRadius: BorderRadius.circular(15),
        ),
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            spacing: size * 0.01,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  customText(
                    18,
                    'Edit New Brand',
                    fontWeight: FontWeight.bold,
                    webcolors: WebColors.textWhite,
                  ),
                  customBackButton(context),
                ],
              ),
              // ! Brand Logo
              customText(15, 'Logo'),
              buildEditBrandLogo(size),
              const SizedBox(height: 20),
              // ! Name Field
              buildTextField(context, 'Name', 'e.g., Adidas', nameController),
              const SizedBox(height: 16),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    brandProvider.updateExistingBrand(
                      id: brand.id,
                      name: nameController.text,
                      logUrl: brandProvider.selectedLogoUrl,
                    );
                    Navigator.pop(context);
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: WebColors.buttonBlue,
                    padding: EdgeInsets.only(
                      left: size * 0.01,
                      top: size * 0.01,
                      right: size * 0.01,
                      bottom: size * 0.01,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(4),
                    ),
                  ),
                  child: Text(
                    'Save Changes',
                    style: GoogleFonts.openSans(
                      color: WebColors.textWhite,
                      fontSize: 16,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
