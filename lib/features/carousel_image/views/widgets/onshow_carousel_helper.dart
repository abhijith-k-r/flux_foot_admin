import 'package:flutter/material.dart';
import 'package:flux_foot_admin/features/carousel_image/views/screen/carousel_management_page.dart';

void onShowCarouselHelper(BuildContext context) {
  showDialog(context: context, builder: (context) => CarouselManagementPage());
}
