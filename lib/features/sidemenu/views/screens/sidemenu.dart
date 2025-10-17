// ignore_for_file: deprecated_member_use, unused_import, use_build_context_synchronously

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_side_menu/flutter_side_menu.dart';
import 'package:flux_foot_admin/core/constants/web_colors.dart';
import 'package:flux_foot_admin/features/sidemenu/views/widgets/custom_sidemenu.dart';
import 'package:flux_foot_admin/features/sidemenu/views/widgets/web_appbar.dart';
import 'package:flux_foot_admin/features/seller_management/models/seller_status_model.dart';
import 'package:flux_foot_admin/features/sidemenu/view_models/provider/sidemenu_provider.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class SideMenuWithAppbar extends StatelessWidget {
  const SideMenuWithAppbar({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Consumer<SidemenuProvider>(
        builder: (context, sidemenuprovider, child) {
          return Column(
            children: [
              CustomWebAppbar(title: sidemenuprovider.currentPageTitle),

              // !Custom Side menu
              Expanded(
                child: Row(
                  children: [
                    CustomSideMenu(
                      menuItems: sidemenuprovider.menuItems,
                      selectedIndex: sidemenuprovider.selectedIndex,
                      onItemTap: sidemenuprovider.onMenuItemTap,
                    ),
                    Expanded(
                      child: Container(
                        padding: const EdgeInsets.all(20),
                        // ! contents..!
                        child: sidemenuprovider.buildMainContent(context),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}   

// !====== For Sample Text====
Widget buildDashboardContent() {
  return Center(
    child: Text(
      "Dashboard Content Here",
      style: GoogleFonts.openSans(color: Colors.white, fontSize: 24),
    ),
  );
}

Widget buildUserManagementContent() {
  return Center(
    child: Text(
      "User Management Content Here",
      style: GoogleFonts.openSans(color: Colors.white, fontSize: 24),
    ),
  );
}

Widget buildOrdersContent() {
  return Center(
    child: Text(
      "Orders Content Here",
      style: GoogleFonts.openSans(color: Colors.white, fontSize: 24),
    ),
  );
}

// Updated action button widget
Widget buildActionButton({
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
            ? Border.all(color: WebColors.borderSideGrey, width: 1)
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
