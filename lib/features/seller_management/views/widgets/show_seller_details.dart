// ignore_for_file: deprecated_member_use
import 'package:flutter/material.dart';
import 'package:flux_foot_admin/features/seller_management/view_models/show_document.dart';
import 'package:flux_foot_admin/features/seller_management/views/widgets/details_showing_helper.dart';

// ! Seller Details as Dialogu (popup)
class SellerDetails extends StatelessWidget {
  const SellerDetails({
    super.key,
    required this.size,
    required this.name,
    required this.storename,
    required this.phone,
    required this.email,
    required this.businesstype,
    required this.warehouse,
    required this.licenseUrl,
  });

  final double size;
  final String name;
  final String storename;
  final String phone;
  final String email;
  final String businesstype;
  final String warehouse;
  final String licenseUrl;

  @override
  Widget build(BuildContext context) {
    return Padding(
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
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  spacing: size * 0.013,
                  children: [
                    buildDetaileItem(context, 'Seller Name', name),
                    buildDetaileItem(context, 'Store Name', storename),
                    buildDetaileItem(context, 'Phone Number', phone),
                  ],
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  spacing: size * 0.013,
                  children: [
                    buildDetaileItem(context, 'Email Address', email),
                    buildDetaileItem(context, 'Business Type', businesstype),
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
              () => launchLicenseUrl(licenseUrl, context),
            ),
          ],
        ),
      ),
    );
  }
}
