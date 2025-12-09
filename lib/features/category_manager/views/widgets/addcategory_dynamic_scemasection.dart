// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:flux_foot_admin/core/constants/web_colors.dart';
import 'package:flux_foot_admin/features/category_manager/view_model/provider/category_provider.dart';
import 'package:flux_foot_admin/features/category_manager/views/screen/dynamic_field_row.dart';
import 'package:google_fonts/google_fonts.dart';

// ! Dynamic Schema Section
buildDynamicSchemaSection(CategoryViewModel viewModel) {
  return Container(
    padding: const EdgeInsets.all(16),
    decoration: BoxDecoration(
      color: WebColors.bgDarkGrey.withOpacity(0.5),
      borderRadius: BorderRadius.circular(8),
      border: Border.all(color: WebColors.textWhiteLite.withOpacity(0.2)),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Seller Product Fields (Dynamic Schema)',
                  style: GoogleFonts.openSans(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: WebColors.textWhite,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  'Define custom fields sellers will fill for this category',
                  style: GoogleFonts.openSans(
                    fontSize: 12,
                    color: WebColors.textWhiteLite,
                  ),
                ),
              ],
            ),
          ],
        ),

        const SizedBox(height: 16),

        // ! Dynamic Fields List
        if (viewModel.dynamicFields.isEmpty)
          Center(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text(
                'No fields added yet. Click "Add Field" to start.',
                style: GoogleFonts.openSans(
                  color: WebColors.textWhiteLite,
                  fontSize: 14,
                ),
              ),
            ),
          ),

        ...viewModel.dynamicFields.map((field) {
          return DynamicFieldRow(
            field: field,
            onRemove: () => viewModel.removeDynamicField(field.id),
            onLabelChanged: (label) =>
                viewModel.updateFieldLabel(field.id, label),
            onTypeChanged: (type) => viewModel.updateFieldType(field.id, type),
            onRequiredChanged: (isRequired) =>
                viewModel.updateFieldRequired(field.id, isRequired),
            onOptionsChanged: (options) =>
                viewModel.updateFieldOptions(field.id, options),
          );
        }),

        const SizedBox(height: 12),

        // ! Add Field Button
        TextButton.icon(
          onPressed: viewModel.addDynamicField,
          icon: Icon(Icons.add, color: WebColors.buttonBlue, size: 20),
          label: Text(
            'Add Another Field',
            style: GoogleFonts.openSans(
              color: WebColors.buttonBlue,
              fontWeight: FontWeight.bold,
            ),
          ),
          style: TextButton.styleFrom(
            backgroundColor: WebColors.buttonBlue.withOpacity(0.1),
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
          ),
        ),
      ],
    ),
  );
}
