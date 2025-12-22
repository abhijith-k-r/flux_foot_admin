// ignore_for_file: deprecated_member_use

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flux_foot_admin/core/constants/web_colors.dart';
import 'package:flux_foot_admin/features/carousel_image/view_model/carousel_provider.dart';
import 'package:provider/provider.dart';

// ! Image Upload Card
Widget buildUploadCard(BuildContext context) {
  final isDark = Theme.of(context).brightness == Brightness.dark;

  return Material(
    // color: WebColors.bgDarkBlue1,
    borderRadius: BorderRadius.circular(12),
    elevation: 1,
    child: Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        // border: Border.all(
        //   color: isDark ? const Color(0xFF334155) : const Color(0xFFe7ebf3),
        // ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Image Uploader',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 16),
          Consumer<CarouselProvider>(
            builder: (context, provider, _) => Material(
              color: Colors.transparent,
              child: InkWell(
                onTap: provider.isUploading
                    ? null
                    : () async {
                        FilePickerResult? result = await FilePicker.platform
                            .pickFiles(
                              type: FileType.image,
                              allowMultiple: false,
                            );
                        if (result != null && result.files.isNotEmpty) {
                          await provider.uploadImage(result.files.first);
                        }
                      },
                borderRadius: BorderRadius.circular(12),
                child: Container(
                  height: 256,
                  decoration: BoxDecoration(
                    color: WebColors.defaultGrey.withOpacity(0.3),
                    border: Border.all(
                      color: WebColors.borderSideGrey,
                      width: 2,
                    ),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: provider.isUploading
                      ? const Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              CircularProgressIndicator(
                                valueColor: AlwaysStoppedAnimation<Color>(
                                  Color(0xFF135bec),
                                ),
                              ),
                              SizedBox(height: 16),
                              Text('Uploading to Cloudinary...'),
                            ],
                          ),
                        )
                      : Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                              width: 64,
                              height: 64,
                              decoration: BoxDecoration(
                                color: isDark
                                    ? const Color(0xFF1e293b)
                                    : Colors.white,
                                shape: BoxShape.circle,
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.black.withOpacity(0.1),
                                    blurRadius: 8,
                                    offset: const Offset(0, 2),
                                  ),
                                ],
                              ),
                              child: const Icon(
                                Icons.cloud_upload_outlined,
                                size: 32,
                                color: Color(0xFF135bec),
                              ),
                            ),
                            const SizedBox(height: 16),
                            const Text(
                              'Click to Upload Images',
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              'JPG, PNG (16:9 Ratio recommended)',
                              style: TextStyle(
                                fontSize: 14,
                                color: Colors.grey[600],
                              ),
                            ),
                            const SizedBox(height: 8),
                            Text(
                              'Images will be uploaded to Cloudinary',
                              style: TextStyle(
                                fontSize: 12,
                                color: Colors.grey[500],
                              ),
                            ),
                          ],
                        ),
                ),
              ),
            ),
          ),
        ],
      ),
    ),
  );
}
