import 'package:flutter/material.dart';
import 'package:flux_foot_admin/core/constants/web_colors.dart';
import 'package:flux_foot_admin/core/widgets/show_snackbar.dart';
import 'package:flux_foot_admin/features/carousel_image/view_model/carousel_provider.dart';
import 'package:provider/provider.dart';

// ! Custom Save Button
Widget buildSaveButton(BuildContext context) {
  return Consumer<CarouselProvider>(
    builder: (context, provider, _) => ElevatedButton.icon(
      onPressed: provider.isLoading
          ? null
          : () async {
              await provider.saveAllChanges();
              if (context.mounted) {
                showOverlaySnackbar(
                  context,
                  'Carousel saved successfully!',
                  WebColors.activeGreeLite,
                );
              }
            },
      icon: provider.isLoading
          ? const SizedBox(
              width: 18,
              height: 18,
              child: CircularProgressIndicator(
                strokeWidth: 2,
                color: Colors.white,
              ),
            )
          : const Icon(Icons.save, size: 18),
      label: Text(
        provider.isLoading ? 'Saving...' : 'Save All Changes',
        style: const TextStyle(fontWeight: FontWeight.bold),
      ),
      style: ElevatedButton.styleFrom(
        backgroundColor: WebColors.buttonBlue,
        foregroundColor: WebColors.textWhite,
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        elevation: 2,
      ),
    ),
  );
}
