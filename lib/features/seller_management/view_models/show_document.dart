//! Function to launch the URL (License Document)
// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:flux_foot_admin/core/constants/web_colors.dart';
import 'package:flux_foot_admin/core/widgets/show_snackbar.dart';
import 'package:url_launcher/url_launcher.dart';

void launchLicenseUrl(String licenseUrl,BuildContext context) async {
  if (licenseUrl.isNotEmpty) {
    final Uri url = Uri.parse(licenseUrl);
    if (await canLaunchUrl(url)) {
      await launchUrl(url);
    } else {
      showOverlaySnackbar(
        context,
        'Could not open document link.',
        WebColors.errorRed,
      );
    }
  }
}
