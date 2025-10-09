// ignore_for_file: deprecated_member_use, use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:flux_foot_admin/core/constants/web_colors.dart';
import 'package:flux_foot_admin/core/widgets/show_snackbar.dart';
import 'package:flux_foot_admin/features/sellermanagement/views/widgets/seller_table.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:url_launcher/url_launcher.dart';

showSellerDetails(
  BuildContext context,
  dynamic status,
  String sellerId,
  dynamic name,
  dynamic email,
  String phone,
  dynamic storename,
  dynamic businesstype,
  dynamic warehouse,
  String licenseUrl,
) {
  // Function to launch the URL (License Document)
  void launchLicenseUrl() async {
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

  showDialog(
    context: context,
    builder: (BuildContext context) {
      final size = MediaQuery.of(context).size.width;
      return Dialog(
        child: Container(
          width: size * 0.7,
          height: size * 0.7,
          decoration: BoxDecoration(
            color: const Color.fromARGB(255, 46, 46, 46),
            borderRadius: BorderRadius.circular(15),
          ),
          child: Column(
            children: [
              AppBar(
                automaticallyImplyLeading: false,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadiusGeometry.only(
                    topLeft: Radius.circular(15),
                    topRight: Radius.circular(15),
                  ),
                ),
                actions: [customBackButton(context)],
                backgroundColor: const Color.fromARGB(255, 46, 46, 46),
              ),
              Padding(
                padding: EdgeInsets.only(
                  left: size * 0.06,
                  top: size * 0.05,
                  right: size * 0.06,
                ),
                child: Column(
                  spacing: 30,
                  children: [
                    // ! Title With Approval Button
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Seller Details',
                          style: GoogleFonts.openSans(
                            color: WebColors.textWhite,
                            fontSize: size * 0.015,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        ActionButtons(status: status, sellerId: sellerId),
                      ],
                    ),
                    // ! Seller Image With other Details
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        CircleAvatar(
                          radius: size * 0.06,
                          child: Icon(Icons.person, size: size * 0.06),
                        ),
                        Padding(
                          padding: EdgeInsets.only(left: size * 0.03),
                          child: Container(
                            padding: EdgeInsets.all(24),
                            decoration: BoxDecoration(
                              color: const Color.fromARGB(255, 26, 25, 25),
                              borderRadius: BorderRadius.circular(8),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withOpacity(0.1),
                                  blurRadius: 10,
                                  offset: Offset(0, 4),
                                ),
                              ],
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              spacing: size * 0.013,
                              children: [
                                Row(
                                  spacing: size * 0.1,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      spacing: size * 0.013,
                                      children: [
                                        buildDetaileItem(
                                          context,
                                          'Seller Name',
                                          name,
                                        ),
                                        buildDetaileItem(
                                          context,
                                          'Store Name',
                                          storename,
                                        ),
                                        buildDetaileItem(
                                          context,
                                          'Phone Number',
                                          phone,
                                        ),
                                      ],
                                    ),
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      spacing: size * 0.013,
                                      children: [
                                        buildDetaileItem(
                                          context,
                                          'Email Address',
                                          email,
                                        ),
                                        buildDetaileItem(
                                          context,
                                          'Business Type',
                                          businesstype,
                                        ),
                                      ],
                                    ),
                                  ],
                                ),

                                buildDetaileItem(
                                  context,
                                  'Warehous Address/ Shipping Orighin',
                                  warehouse,
                                ),
                                // ! NEW: Business License Document Link
                                SizedBox(height: size * 0.013),
                                buildLicenseDocumentItem(
                                  context,
                                  'Business License Document',
                                  licenseUrl,
                                  launchLicenseUrl,
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      );
    },
  );
}

Widget buildDetaileItem(BuildContext context, String label, String value) {
  final size = MediaQuery.of(context).size.width;
  return Column(
    spacing: 4,
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(
        label,
        style: GoogleFonts.openSans(
          fontSize: size * 0.01,
          fontWeight: FontWeight.w500,
          color: Colors.white70,
        ),
        overflow: TextOverflow.ellipsis,
      ),
      Text(
        value,
        style: GoogleFonts.openSans(
          fontSize: size * 0.011,
          fontWeight: FontWeight.bold,
          color:WebColors. textWhite,
        ),
        overflow: TextOverflow.ellipsis,
      ),
    ],
  );
}

// ! NEW Helper Widget for the Document Link
Widget buildLicenseDocumentItem(
  BuildContext context,
  String label,
  String url,
  VoidCallback onPressed,
) {
  final size = MediaQuery.of(context).size.width;
  final bool isAvailable = url.isNotEmpty && url != 'N/A';

  return Column(
    // spacing: 4,
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(
        label,
        style: GoogleFonts.openSans(
          fontSize: size * 0.01,
          fontWeight: FontWeight.w500,
          color: Colors.white70,
        ),
      ),
      SizedBox(height: 4),
      if (isAvailable)
        TextButton.icon(
          onPressed: onPressed,
          icon: Icon(
            Icons.description,
            size: size * 0.015,
            color: Colors.blueAccent,
          ),
          label: Text(
            'View Document',
            style: GoogleFonts.openSans(
              fontSize: size * 0.011,
              fontWeight: FontWeight.bold,
              color: Colors.blueAccent,
              decoration: TextDecoration.underline,
            ),
          ),
        )
      else
        Text(
          'Document Not Available',
          style: GoogleFonts.openSans(
            fontSize: size * 0.011,
            fontWeight: FontWeight.bold,
            color: WebColors.errorRed,
          ),
        ),
    ],
  );
}

// ! Custom Back Button

Padding customBackButton(BuildContext context) {
  return Padding(
    padding: const EdgeInsets.all(10),
    child: Container(
      width: 40,
      height: 40,
      decoration: BoxDecoration(
        color: Colors.grey,
        borderRadius: BorderRadius.circular(15),
      ),
      child: IconButton(
        onPressed: () {
          Navigator.pop(context);
        },
        icon: Icon(Icons.close, color: WebColors.iconeWhite),
        tooltip: 'Back',
      ),
    ),
  );
}
