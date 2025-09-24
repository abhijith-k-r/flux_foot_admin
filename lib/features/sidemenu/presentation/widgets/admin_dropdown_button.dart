import 'package:flutter/material.dart';
import 'package:flux_foot_admin/features/sidemenu/presentation/provider/drop_down_btn_provider.dart';
import 'package:provider/provider.dart';


class AdminDropdown extends StatelessWidget {
  const AdminDropdown({super.key});

  @override
  Widget build(BuildContext context) {
    return buildAdminDropdown(context);
  }

  Widget buildAdminDropdown(BuildContext context) {
    return Consumer<DropDownButtonProvider>(
      builder: (context, dropdownButton, child) {
        final size = MediaQuery.of(context).size.width;
        return PopupMenuButton<String>(
          // Button to trigger the dropdown
          itemBuilder: (BuildContext context) => <PopupMenuEntry<String>>[
            // Non-clickable "Admin" title
            PopupMenuItem<String>(
              enabled: false, // Disables clicking
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  vertical: 8.0,
                  horizontal: 16.0,
                ),
                child: Text(
                  'Admin',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.black87,
                  ),
                ),
              ),
            ),
            // Clickable "Log Out" option
            PopupMenuItem<String>(
              value: 'log_out',
              child: Row(
                children: [
                  Icon(Icons.logout, color: Colors.black54),
                  SizedBox(width: 8),
                  Text('Log Out'),
                ],
              ),
            ),
            // Placeholder for future fields (empty space)
            PopupMenuItem<String>(
              enabled: false, // Disables clicking
              child: SizedBox(height: 16.0), // Reserved space for future items
            ),
          ],
          // Callback when a menu item is selected
          onSelected: (value) => dropdownButton.isSelected(context, value),
          // Customize the popup menu appearance
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8.0),
          ),
          elevation: 4.0,
          color: Colors.white,
          // Button to trigger the dropdown
          child: Container(
            // width: size * 0.08,
            padding: EdgeInsets.symmetric(
              horizontal: size * 0.01,
              vertical: size * 0.004,
            ),
            decoration: BoxDecoration(
              color: Color(0xFF4C6EF5), // Matches the image's button color
              borderRadius: BorderRadius.circular(8.0),
            ),
            child: Row(
              spacing: 10,
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(Icons.admin_panel_settings, color: Colors.white, size: 16),
                Text(
                  'Admin',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Icon(Icons.arrow_drop_down, color: Colors.white),
              ],
            ),
          ),
        );
      },
    );
  }
}
