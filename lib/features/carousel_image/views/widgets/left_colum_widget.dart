import 'package:flutter/material.dart';
import 'package:flux_foot_admin/features/carousel_image/views/widgets/image_upload_card.dart';
import 'package:flux_foot_admin/features/carousel_image/views/widgets/preview_image_list.dart';

Widget buildLeftColumn(BuildContext context) {
  return Column(
    children: [
      buildUploadCard(context),
      const SizedBox(height: 24),
      buildPreviewList(context),
    ],
  );
}
