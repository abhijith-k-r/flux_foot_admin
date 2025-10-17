import 'package:flutter/material.dart';
import 'package:flux_foot_admin/core/constants/web_colors.dart';
import 'package:flux_foot_admin/core/widgets/custom_back_button.dart';
import 'package:flux_foot_admin/features/seller_management/views/widgets/seller_table.dart';
import 'package:flux_foot_admin/features/seller_management/views/widgets/show_seller_details.dart';
import 'package:google_fonts/google_fonts.dart';

class ShowSellerDetailsScreen extends StatelessWidget {
  final dynamic status;
  final String sellerId;
  final dynamic name;
  final dynamic email;
  final String phone;
  final dynamic storename;
  final dynamic businesstype;
  final dynamic warehouse;
  final String licenseUrl;

  const ShowSellerDetailsScreen({
    super.key,
    this.status,
    required this.sellerId,
    this.name,
    this.email,
    required this.phone,
    this.storename,
    this.businesstype,
    this.warehouse,
    required this.licenseUrl,
  });

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size.width;
    return Scaffold(
      body: Dialog(
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
                // ! BACK BUTTON
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
                        // ! ACTION  Button/ APPROVAL
                        ActionButtons(status: status, sellerId: sellerId),
                      ],
                    ),
                    // ! Seller Image With other Details
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        // ! Seller Profile Image
                        CircleAvatar(
                          radius: size * 0.06,
                          child: Icon(Icons.person, size: size * 0.06),
                        ),
                        // ! seller More Details
                        SellerDetails(
                          size: size,
                          name: name,
                          storename: storename,
                          phone: phone,
                          email: email,
                          businesstype: businesstype,
                          warehouse: warehouse,
                          licenseUrl: licenseUrl,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
