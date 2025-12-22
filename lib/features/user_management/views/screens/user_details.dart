import 'package:flutter/material.dart';
import 'package:flux_foot_admin/core/constants/web_colors.dart';
import 'package:flux_foot_admin/core/widgets/custom_back_button.dart';
import 'package:flux_foot_admin/core/widgets/custom_text.dart';
import 'package:flux_foot_admin/features/user_management/views/widgets/user_details_widgets.dart';
import 'package:google_fonts/google_fonts.dart';

class ShowUserDetailsScreen extends StatelessWidget {
  final dynamic status;
  final String sellerId;
  final dynamic name;
  final dynamic email;
  final String phone;
  final String dob;
  final String imageUrl;

  const ShowUserDetailsScreen({
    super.key,
    this.status,
    required this.sellerId,
    this.name,
    this.email,
    required this.phone,
    required this.dob,
    required this.imageUrl,
  });

  @override
  Widget build(BuildContext context) {
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
                        'User Details',
                        style: GoogleFonts.openSans(
                          color: WebColors.textWhite,
                          fontSize: size * 0.015,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      customText(
                        size * 0.015,
                        status ? 'Online' : 'Offline',
                        webcolors: status
                            ? WebColors.activeGreen
                            : WebColors.errorRed,
                      ),
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
                        backgroundImage: imageUrl.isNotEmpty
                            ? NetworkImage(imageUrl)
                            : null,
                        child: imageUrl.isEmpty
                            ? Icon(Icons.person_outlined, size: size * 0.06)
                            : null,
                      ),
                      // ! seller More Details
                      UserDetailsWidgets(
                        size: size,
                        name: name,
                        phone: phone,
                        email: email,
                        dob: dob,
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
  }
}
