// ignore_for_file: deprecated_member_use, use_build_context_synchronously

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flux_foot_admin/core/constants/web_colors.dart';
import 'package:flux_foot_admin/core/widgets/show_snackbar.dart';
import 'package:flux_foot_admin/features/seller_management/views/widgets/showing_helper_function.dart';
import 'package:flux_foot_admin/features/sidemenu/views/screens/sidemenu.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

// !==== Seller Table
class SellerTable extends StatelessWidget {
  const SellerTable({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: WebColors.bgDarkBlue1,
        borderRadius: BorderRadius.circular(12),
      ),
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          // Header Row
          Container(
            padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 20),
            decoration: BoxDecoration(
              color: WebColors.bgDarkBlue2,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Row(
              children: [
                Expanded(
                  flex: 2,
                  child: Text(
                    'Name',
                    style: TextStyle(
                      color: WebColors.textWhite,
                      fontWeight: FontWeight.bold,
                      fontSize: 15,
                    ),
                  ),
                ),
                Expanded(
                  flex: 2,
                  child: Text(
                    'Phone No',
                    style: TextStyle(
                      color: WebColors.textWhite,
                      fontWeight: FontWeight.bold,
                      fontSize: 15,
                    ),
                  ),
                ),
                Expanded(
                  flex: 2,
                  child: Text(
                    'Email',
                    style: TextStyle(
                      color: WebColors.textWhite,
                      fontWeight: FontWeight.bold,
                      fontSize: 15,
                    ),
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: Text(
                    'Status',
                    style: TextStyle(
                      color: WebColors.textWhite,
                      fontWeight: FontWeight.bold,
                      fontSize: 15,
                    ),
                  ),
                ),
                Expanded(
                  flex: 2,
                  child: Text(
                    'Action',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: WebColors.textWhite,
                      fontWeight: FontWeight.bold,
                      fontSize: 15,
                    ),
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: Text(
                    'View Details',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: WebColors.textWhite,
                      fontWeight: FontWeight.bold,
                      fontSize: 15,
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 8),

          // The list content
          StreamBuilder<QuerySnapshot>(
            stream: FirebaseFirestore.instance
                .collection('sellers')
                .snapshots(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(
                  child: LoadingAnimationWidget.fourRotatingDots(
                    color: WebColors.logocolor,
                    size: 70,
                  ),
                );
              }
              if (snapshot.hasError) {
                return Center(
                  child: Text(
                    'Error: ${snapshot.error}',
                    style: GoogleFonts.openSans(color: WebColors.errorRed),
                  ),
                );
              }
              final allSellers = snapshot.data?.docs ?? [];
              final displaySellers = allSellers;

              if (displaySellers.isEmpty) {
                return Center(
                  child: Text(
                    'No sellers found.',
                    style: GoogleFonts.openSans(color: WebColors.textWhite),
                  ),
                );
              }

              return ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: displaySellers.length,
                itemBuilder: (context, index) {
                  final sellerDoc = displaySellers[index];
                  final data = sellerDoc.data();

                  if (data == null) return const SizedBox.shrink();

                  final sellerData = data as Map<String, dynamic>;
                  final sellerId = sellerDoc.id;

                  final name = sellerData['name'] ?? 'N/A';
                  final dynamic phoneValue = sellerData['phone'];
                  final String phone = phoneValue != null
                      ? phoneValue.toString()
                      : 'N/A';
                  final email = sellerData['email'] ?? 'N/A';
                  final status = sellerData['status'] ?? 'unknown';
                  final storename = sellerData['store name'] ?? 'N/A';
                  final businesstype = sellerData['business type'] ?? 'N/A';
                  final warehouse = sellerData['warehouse'] ?? 'N/A';
                  final licenseUrl = sellerData['business_license_url'] ?? '';

                  return Container(
                    margin: const EdgeInsets.only(bottom: 8),
                    padding: const EdgeInsets.symmetric(
                      vertical: 12,
                      horizontal: 20,
                    ),
                    decoration: BoxDecoration(
                      color: WebColors.bgDarkBlue2,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Row(
                      children: [
                        //! Name
                        Expanded(
                          flex: 2,
                          child: Row(
                            children: [
                              const CircleAvatar(
                                radius: 13,
                                child: Icon(Icons.person_outlined, size: 20),
                              ),
                              const SizedBox(width: 10),
                              Expanded(
                                child: Text(
                                  name,
                                  style: GoogleFonts.openSans(
                                    color: WebColors.textWhite,
                                    fontSize: 15,
                                  ),
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                            ],
                          ),
                        ),
                        //! Phone
                        Expanded(
                          flex: 2,
                          child: Text(
                            phone,
                            style: GoogleFonts.openSans(
                              color: WebColors.textWhiteLite,
                              fontSize: 15,
                            ),
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        //! Email
                        Expanded(
                          flex: 2,
                          child: Text(
                            email,
                            style: GoogleFonts.openSans(
                              color: WebColors.textWhiteLite,
                              fontSize: 15,
                            ),
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        //! Status
                        Expanded(
                          flex: 1,
                          child: Text(
                            getStatusDisplayText(status),
                            textAlign: TextAlign.center,
                            style: GoogleFonts.openSans(
                              color: getStatusColor(status),
                              fontSize: 12,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                        //! Action Buttons
                        Expanded(
                          flex: 2,
                          child: ActionButtons(
                            status: status,
                            sellerId: sellerId,
                          ),
                        ),
                        // View Details
                        Expanded(
                          flex: 1,
                          child: Center(
                            child: IconButton(
                              color: WebColors.buttonBlue,
                              onPressed: () {
                                onShowSellerDetails(
                                  context,
                                  status,
                                  sellerId,
                                  name,
                                  email,
                                  phone,
                                  storename,
                                  businesstype,
                                  warehouse,
                                  licenseUrl,
                                );
                              },
                              icon: const Icon(Icons.arrow_forward_ios),
                            ),
                          ),
                        ),
                      ],
                    ),
                  );
                },
              );
            },
          ),
        ],
      ),
    );
  }
}

// !Custom Action Buttons For Approval Sellers
class ActionButtons extends StatelessWidget {
  const ActionButtons({
    super.key,
    required this.status,
    required this.sellerId,
  });

  final dynamic status;
  final String sellerId;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        if (status.toLowerCase() == 'active' ||
            status.toLowerCase() == 'approved')
          buildActionButton(
            text: 'Block',
            color: WebColors.textWhite,
            backgroundColor: WebColors.borderSideGrey,
            onPressed: () => updateSellerStatus(context, sellerId, 'blocked'),
          ),
        if (status.toLowerCase() == 'blocked' ||
            status.toLowerCase() == 'rejected')
          buildActionButton(
            text: 'UnBlock',
            color: WebColors.textWhite,
            backgroundColor: WebColors.borderSideGrey,
            onPressed: () => updateSellerStatus(context, sellerId, 'active'),
          ),
        if (status.toLowerCase() == 'pending' ||
            status.toLowerCase() == 'waiting')
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              buildActionButton(
                text: 'Accept',
                color: WebColors.activeGreen,
                backgroundColor: WebColors.activeGreen.withOpacity(0.2),
                onPressed: () =>
                    updateSellerStatus(context, sellerId, 'active'),
              ),
              const SizedBox(width: 5),
              buildActionButton(
                text: 'Reject',
                color: WebColors.errorRed,
                backgroundColor: WebColors.errorRed.withOpacity(0.2),
                onPressed: () =>
                    updateSellerStatus(context, sellerId, 'rejected'),
              ),
            ],
          ),
      ],
    );
  }
}

//! Helper function to get status color
Color getStatusColor(String status) {
  switch (status.toLowerCase()) {
    case 'approved':
    case 'active':
      return WebColors.activeGreen;
    case 'inactive':
    case 'blocked':
      return WebColors.errorRed;
    case 'pending':
    case 'waiting':
      return WebColors.waitinColor;
    default:
      return WebColors.defaultGrey;
  }
}

// !Helper function to get display text for status
String getStatusDisplayText(String status) {
  switch (status.toLowerCase()) {
    case 'approved':
    case 'active':
      return 'Active';
    case 'inactive':
    case 'blocked':
      return 'InActive';
    case 'pending':
    case 'waiting':
      return 'Waiting';
    case 'rejected':
      return 'Rejected';
    default:
      return status;
  }
}

// ! Update Seller Status
Future<void> updateSellerStatus(
  BuildContext context,
  String sellerId,
  String newStatus,
) async {
  final FirebaseFirestore firestore = FirebaseFirestore.instance;

  try {
    await firestore.collection('sellers').doc(sellerId).update({
      'status': newStatus,
    });
    // Optionally show a success message
    if (context.mounted) {
      showOverlaySnackbar(
        context,
        'Seller status updated to $newStatus',
        newStatus == 'blocked' || newStatus == 'Rejected'
            ? WebColors.errorRed
            : WebColors.activeGreen,
      );
    }
  } catch (e) {
    showOverlaySnackbar(
      context,
      'Error updating seller status',
      WebColors.errorRed,
    );
  }
}
