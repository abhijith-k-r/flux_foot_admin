import 'package:flutter/material.dart';
import 'package:flux_foot_admin/features/seller_management/views/screens/show_seller_details.dart';

void onShowSellerDetails(
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
  showDialog(
    context: context,
    builder: (context) => ShowSellerDetailsScreen(
      licenseUrl: licenseUrl,
      phone: phone,
      sellerId: sellerId,
      businesstype: businesstype,
      email: email,
      name: name,
      status: status,
      storename: storename,
      warehouse: warehouse,
    ),
  );
}
