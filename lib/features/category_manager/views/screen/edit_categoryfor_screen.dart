import 'package:flutter/material.dart';
import 'package:flux_foot_admin/core/constants/web_colors.dart';
import 'package:flux_foot_admin/core/widgets/custom_back_button.dart';
import 'package:flux_foot_admin/core/widgets/custom_text.dart';
import 'package:flux_foot_admin/features/category_manager/model/category_model.dart';
import 'package:flux_foot_admin/features/category_manager/view_model/provider/category_provider.dart';
import 'package:flux_foot_admin/features/category_manager/views/widgets/form_elements.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class EditCategoryScreen extends StatelessWidget {
  final CategoryModel category;
  const EditCategoryScreen({super.key, required this.category});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size.width;

    final categoryviewModel = Provider.of<CategoryViewModel>(
      context,
      listen: false,
    );
    final nameController = TextEditingController(text: category.name);
    final descController = TextEditingController(text: category.description);
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
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  customText(
                    18,
                    'Edit New Category',
                    fontWeight: FontWeight.bold,
                    webcolors: WebColors.textWhite,
                  ),
                  customBackButton(context),
                ],
              ),
              const SizedBox(height: 20),
              // ! Name Field
              buildTextField(context, 'Name', 'e.g., Balls', nameController),
              // ! Description Field
              buildTextArea(
                context,
                'Description (Optional)',
                'e.g., Footballs for all ages and skill levels',
                descController,
              ),
              // buildToggle(context, 'Is Active'),
              const SizedBox(height: 16),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    categoryviewModel.updateExistingCategory(
                      id: category.id,
                      name: nameController.text,
                      description: descController.text,
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
