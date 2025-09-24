// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:flux_foot_admin/core/constants/app_colors.dart';
import 'package:flux_foot_admin/features/sellermanagement/presentation/widgets/seller_table.dart';
import 'package:google_fonts/google_fonts.dart';

showSellerDetails(
  BuildContext context,
  dynamic status,
  String sellerId,
  dynamic name,
  dynamic email,
  String phone,
) {
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
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadiusGeometry.only(
                    topLeft: Radius.circular(15),
                    topRight: Radius.circular(15),
                  ),
                ),
                leading: customBackButton(context),
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
                            color: Colors.white,
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
                                          'John Doe',
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
                                          'John Doe',
                                        ),
                                      ],
                                    ),
                                  ],
                                ),

                                buildDetaileItem(
                                  context,
                                  'Warehous Address/ Shipping Orighin',
                                  '123 Kickoff Lane, Touchdown City, FS 54321, USA',
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
          color: textWhite,
        ),
        overflow: TextOverflow.ellipsis,
      ),
    ],
  );
}

// ! Custom Back Button

Padding customBackButton(BuildContext context) {
  return Padding(
    padding: const EdgeInsets.all(10),
    child: GestureDetector(
      onTap: () => Navigator.pop(context),
      child: SizedBox(
        width: 40,
        height: 40,
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white24,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Icon(Icons.arrow_back_ios_new, color: Colors.white),
        ),
      ),
    ),
  );
}
