// Main Widget
import 'package:flutter/material.dart';
import 'package:flux_foot_admin/features/carousel_image/view_model/carousel_provider.dart';
import 'package:flux_foot_admin/features/carousel_image/views/screen/carousel_content.dart';
import 'package:provider/provider.dart';

// Main Widget
class CarouselManagementPage extends StatelessWidget {
  const CarouselManagementPage({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => CarouselProvider(),
      child: const CarouselManagementContent(),
    );
  }
}
