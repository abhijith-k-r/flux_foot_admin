// ignore_for_file: deprecated_member_use, unused_import, use_build_context_synchronously

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_side_menu/flutter_side_menu.dart';
import 'package:flux_foot_admin/core/constants/app_colors.dart';
import 'package:flux_foot_admin/features/auth/presentation/widgets/custom_sidemenu.dart';
import 'package:flux_foot_admin/features/auth/presentation/widgets/web_appbar.dart';
import 'package:flux_foot_admin/features/dashboard/data/model/seller_status_model.dart';
import 'package:google_fonts/google_fonts.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({super.key});

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  String currentPageTitle = "Dashboard Overview";
  int selectedIndex = 0;

  final List<SideMenuItems> menuItems = [
    SideMenuItems(
      title: "Dashboard",
      icon: Icons.dashboard,
      pageTitle: "Dashboard Overview",
    ),
    SideMenuItems(
      title: "User Management",
      icon: Icons.people,
      pageTitle: "User Management",
    ),
    SideMenuItems(
      title: "Seller Management",
      icon: Icons.store,
      pageTitle: "Seller Management",
    ),
    SideMenuItems(
      title: "Orders",
      icon: Icons.shopping_cart,
      pageTitle: "Orders Management",
    ),
  ];

  void _onMenuItemTap(int index) {
    setState(() {
      selectedIndex = index;
      currentPageTitle = menuItems[index].pageTitle;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          CustomWebAppbar(title: currentPageTitle),

          // !Custom Side menu
          Expanded(
            child: Row(
              children: [
                CustomSideMenu(
                  menuItems: menuItems,
                  selectedIndex: selectedIndex,
                  onItemTap: _onMenuItemTap,
                ),
                Expanded(
                  child: Container(
                    padding: const EdgeInsets.all(20),
                    child: buildMainContent(),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget buildMainContent() {
    switch (selectedIndex) {
      case 0:
        return _buildDashboardContent();
      case 1:
        return _buildUserManagementContent();
      case 2:
        return _buildSellerManagementContent();
      case 3:
        return _buildOrdersContent();
      default:
        return _buildDashboardContent();
    }
  }

  Widget _buildDashboardContent() {
    return Center(
      child: Text(
        "Dashboard Content Here",
        style: GoogleFonts.openSans(color: Colors.white, fontSize: 24),
      ),
    );
  }

  Widget _buildUserManagementContent() {
    return Center(
      child: Text(
        "User Management Content Here",
        style: GoogleFonts.openSans(color: Colors.white, fontSize: 24),
      ),
    );
  }

  // !=============

  Future<void> _updateSellerStatus(String sellerId, String newStatus) async {
    final FirebaseFirestore firestore = FirebaseFirestore.instance;

    try {
      await firestore.collection('sellers').doc(sellerId).update({
        'status': newStatus,
      });
      // Optionally show a success message
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Seller status updated to $newStatus'),
          backgroundColor: Colors.green,
        ),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Error updating seller status'),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  // Helper function to get status color
  Color _getStatusColor(String status) {
    switch (status.toLowerCase()) {
      case 'approved':
      case 'active':
        return Colors.green;
      case 'inactive':
      case 'blocked':
        return Colors.red;
      case 'pending':
      case 'waiting':
        return Colors.orange;
      default:
        return Colors.grey;
    }
  }

  Widget _buildSellerManagementContent() {
    final size = MediaQuery.of(context).size.width;

    // ! Sellers Staus Counts

    // Function to fetch the seller counts from Firestore
    Future<SellerCounts> fetchSellerCounts() async {
      final snapshot = await FirebaseFirestore.instance
          .collection('sellers')
          .get();

      // Get all documents
      final allSellers = snapshot.docs;
      final total = allSellers.length;

      // Initialize counts
      int active = 0;
      int blocked = 0;
      int pending = 0;

      // Iterate and count based on status
      for (var doc in allSellers) {
        // Safely get the status, defaulting to 'unknown'
        final status = (doc.data()['status'] as String? ?? 'unknown')
            .toLowerCase();

        if (status == 'active' || status == 'approved') {
          active++;
        } else if (status == 'blocked' || status == 'rejected') {
          blocked++;
        } else if (status == 'pending' || status == 'waiting') {
          pending++;
        }
      }

      return SellerCounts(
        total: total,
        active: active,
        blocked: blocked,
        pending: pending,
      );
    }

    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // 🔑 Use FutureBuilder to display the counts
          FutureBuilder<SellerCounts>(
            future: fetchSellerCounts(), // Call the fetching function
            builder: (context, snapshot) {
              // Display loading state
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const SizedBox(
                  height: 100, // Match height of your status boxes
                  child: Center(
                    child: CircularProgressIndicator(color: Colors.white70),
                  ),
                );
              }

              // Handle error state
              if (snapshot.hasError) {
                return Text(
                  'Error loading stats: ${snapshot.error}',
                  style: TextStyle(color: Colors.red),
                );
              }

              // Get the counts (use 0 if data is somehow null, though unlikely here)
              final counts =
                  snapshot.data ??
                  SellerCounts(total: 0, active: 0, blocked: 0, pending: 0);

              return Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  CustomSellerStatus(
                    size: size,
                    satsTitle: 'Total Seller',
                    // Use the actual count from the fetched data
                    countSellr: counts.total.toString(),
                    boxColor: Color.fromARGB(255, 99, 63, 201),
                    iconColor: Colors.deepPurpleAccent,
                  ),
                  CustomSellerStatus(
                    size: size,
                    satsTitle: 'Active Sellers',
                    // Use the actual count
                    countSellr: counts.active.toString(),
                    boxColor: const Color.fromARGB(255, 78, 155, 80),
                    iconColor: Colors.greenAccent,
                  ),
                  CustomSellerStatus(
                    size: size,
                    satsTitle: 'Pending Sellers',
                    // Use the actual count
                    countSellr: counts.blocked.toString(),
                    boxColor: Colors.amber,
                    iconColor: Colors.amberAccent,
                  ),
                  CustomSellerStatus(
                    size: size,
                    satsTitle: 'Block Sellers',
                    // Use the actual count
                    countSellr: counts.blocked.toString(),
                    boxColor: const Color.fromARGB(255, 190, 80, 72),
                    iconColor: Colors.redAccent,
                  ),
                ],
              );
            },
          ),
          SizedBox(height: 30),
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                color: Color.fromARGB(255, 14, 15, 19), // Dark background
                borderRadius: BorderRadius.circular(12),
              ),
              padding: EdgeInsets.all(16),
              child: Column(
                children: [
                  // Header Row
                  Container(
                    padding: EdgeInsets.symmetric(vertical: 16, horizontal: 20),
                    decoration: BoxDecoration(
                      color: Color(0xFF1E2A44), // Darker header background
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Row(
                      children: [
                        Expanded(
                          flex: 2,
                          child: Text(
                            'Name',
                            style: GoogleFonts.openSans(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 20,
                            ),
                          ),
                        ),
                        Expanded(
                          flex: 2,
                          child: Text(
                            'Phone No',
                            style: GoogleFonts.openSans(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 20,
                            ),
                          ),
                        ),
                        Expanded(
                          flex: 2,
                          child: Text(
                            'Email',
                            style: GoogleFonts.openSans(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 20,
                            ),
                          ),
                        ),
                        Expanded(
                          flex: 2,
                          child: Text(
                            'Status',
                            style: GoogleFonts.openSans(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 20,
                            ),
                          ),
                        ),
                        Expanded(
                          flex: 1,
                          child: Text(
                            'Action',
                            style: GoogleFonts.openSans(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 20,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 8),
                  Flexible(
                    child: StreamBuilder<QuerySnapshot>(
                      // Fetch ALL sellers, not just pending ones
                      stream: FirebaseFirestore.instance
                          .collection('sellers')
                          .snapshots(),
                      builder: (context, snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return Center(child: CircularProgressIndicator());
                        }
                        if (snapshot.hasError) {
                          return Center(
                            child: Text(
                              'Error: ${snapshot.error}',
                              style: GoogleFonts.openSans(color: Colors.red),
                            ),
                          );
                        }
                        final allSellers = snapshot.data?.docs ?? [];

                        // Show ALL sellers, not filtered
                        final displaySellers = allSellers;

                        if (displaySellers.isEmpty) {
                          return Center(
                            child: Text(
                              'No sellers found.',
                              style: GoogleFonts.openSans(
                                color: Colors.white70,
                              ),
                            ),
                          );
                        }

                        return ListView.builder(
                          itemCount: displaySellers.length,
                          itemBuilder: (context, index) {
                            final sellerDoc = displaySellers[index];
                            final data = sellerDoc.data();

                            if (data == null) {
                              return const SizedBox.shrink();
                            }

                            final sellerData = data as Map<String, dynamic>;
                            final sellerId = sellerDoc.id;

                            // Safely access fields
                            final name = sellerData['name'] ?? 'N/A';
                            final dynamic phoneValue = sellerData['phone'];
                            final String phone = phoneValue != null
                                ? phoneValue.toString()
                                : 'N/A';
                            final email = sellerData['email'] ?? 'N/A';
                            final status = sellerData['status'] ?? 'unknown';

                            return Container(
                              margin: EdgeInsets.only(bottom: 8),
                              padding: EdgeInsets.symmetric(
                                vertical: 12,
                                horizontal: 20,
                              ),
                              decoration: BoxDecoration(
                                color: Color(0xFF1E2A44), // Row background
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: Row(
                                children: [
                                  // Name
                                  Expanded(
                                    flex: 2,
                                    child: Text(
                                      name,
                                      style: GoogleFonts.openSans(
                                        color: Colors.white,
                                        fontSize: 14,
                                      ),
                                    ),
                                  ),
                                  // Phone
                                  Expanded(
                                    flex: 2,
                                    child: Text(
                                      phone,
                                      style: GoogleFonts.openSans(
                                        color: Colors.white70,
                                        fontSize: 14,
                                      ),
                                    ),
                                  ),
                                  // Email
                                  Expanded(
                                    flex: 2,
                                    child: Text(
                                      email,
                                      style: GoogleFonts.openSans(
                                        color: Colors.white70,
                                        fontSize: 14,
                                      ),
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ),
                                  // Status
                                  Expanded(
                                    flex: 2,
                                    child: Text(
                                      _getStatusDisplayText(status),
                                      textAlign: TextAlign.center,
                                      style: GoogleFonts.openSans(
                                        color: _getStatusColor(status),
                                        fontSize: 12,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  ),
                                  // Action Buttons
                                  Expanded(
                                    flex: 2,
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceEvenly,
                                      children: [
                                        // For Active sellers - show Block button
                                        if (status.toLowerCase() == 'active' ||
                                            status.toLowerCase() == 'approved')
                                          _buildActionButton(
                                            text: 'Block',
                                            color: Colors.white,
                                            backgroundColor: Colors.white24,
                                            onPressed: () =>
                                                _updateSellerStatus(
                                                  sellerId,
                                                  'blocked',
                                                ),
                                          ),

                                        // For Inactive/Blocked sellers - show UnBlock button
                                        if (status.toLowerCase() ==
                                                'inactive' ||
                                            status.toLowerCase() == 'blocked')
                                          _buildActionButton(
                                            text: 'UnBlock',
                                            color: Colors.white,
                                            backgroundColor: Colors.white24,
                                            onPressed: () =>
                                                _updateSellerStatus(
                                                  sellerId,
                                                  'active',
                                                ),
                                          ),

                                        // For Pending/Waiting sellers - show Accept and Reject buttons
                                        if (status.toLowerCase() == 'pending' ||
                                            status.toLowerCase() == 'waiting')
                                          Row(
                                            spacing: 5,
                                            children: [
                                              _buildActionButton(
                                                text: 'Accept',
                                                color: Colors.green,
                                                backgroundColor: Colors.green
                                                    .withOpacity(0.2),
                                                onPressed: () =>
                                                    _updateSellerStatus(
                                                      sellerId,
                                                      'active',
                                                    ),
                                              ),
                                              _buildActionButton(
                                                text: 'Reject',
                                                color: Colors.red,
                                                backgroundColor: Colors.red
                                                    .withOpacity(0.2),
                                                onPressed: () =>
                                                    _updateSellerStatus(
                                                      sellerId,
                                                      'rejected',
                                                    ),
                                              ),
                                            ],
                                          ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            );
                          },
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  // Helper function to get display text for status
  String _getStatusDisplayText(String status) {
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

  // Updated action button widget
  Widget _buildActionButton({
    required String text,
    required Color color,
    Color? backgroundColor,
    required VoidCallback onPressed,
  }) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
        decoration: BoxDecoration(
          color: backgroundColor ?? color.withOpacity(0.2),
          borderRadius: BorderRadius.circular(6),
          border: text == 'Block' || text == 'UnBlock'
              ? Border.all(color: Colors.white24, width: 1)
              : null,
        ),
        child: Text(
          text,
          style: GoogleFonts.openSans(
            color: color,
            fontSize: 12,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }

  Widget _buildOrdersContent() {
    return Center(
      child: Text(
        "Orders Content Here",
        style: GoogleFonts.openSans(color: Colors.white, fontSize: 24),
      ),
    );
  }
}

// ! Seller Status as Custom Container

class CustomSellerStatus extends StatelessWidget {
  const CustomSellerStatus({
    super.key,
    required this.size,
    required this.boxColor,
    required this.iconColor,
    required this.satsTitle,
    required this.countSellr,
  });

  final double size;
  final String satsTitle;
  final String countSellr;
  final Color boxColor;
  final Color iconColor;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size * 0.18,
      height: size * 0.09,
      decoration: BoxDecoration(
        color: Color(0xFF1E2A44),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Padding(
        padding: EdgeInsets.only(left: size * 0.01, top: size * 0.01),
        child: Column(
          spacing: 20,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  satsTitle,
                  style: GoogleFonts.openSans(color: Colors.white),
                ),
                Padding(
                  padding: EdgeInsets.only(right: size * 0.01),
                  child: Container(
                    width: size * 0.02,
                    height: size * 0.02,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                      color: boxColor,
                    ),
                    child: Icon(
                      Icons.person_outline_sharp,
                      size: size * 0.015,
                      color: iconColor,
                    ),
                  ),
                ),
              ],
            ),
            Text(
              countSellr,
              style: GoogleFonts.openSans(
                fontWeight: FontWeight.bold,
                fontSize: size * 0.015,
                color: Colors.white,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
