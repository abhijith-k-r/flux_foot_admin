import 'package:flutter/material.dart';
import 'package:flutter_side_menu/flutter_side_menu.dart';
import 'package:flux_foot_admin/core/constants/web_colors.dart';
import 'package:google_fonts/google_fonts.dart';

// ! Custom Side Menu
class CustomSideMenu extends StatelessWidget {
  final List<SideMenuItems> menuItems;
  final int selectedIndex;
  final Function(int) onItemTap;

  const CustomSideMenu({
    super.key,
    required this.menuItems,
    required this.selectedIndex,
    required this.onItemTap,
  });

  @override
  Widget build(BuildContext context) {
    return SideMenu(
      backgroundColor: WebColors.bgDarkBlue2,
      builder: (data) => SideMenuData(
        header: Container(
          padding: const EdgeInsets.all(10),
          child: const SizedBox(height: 10),
        ),
        items: menuItems.asMap().entries.map((entry) {
          final index = entry.key;
          final item = entry.value;
          final isSelected = selectedIndex == index;

          return SideMenuItemDataTile(
            isSelected: isSelected,
            onTap: () => onItemTap(index),
            title: item.title,
            icon: Icon(
              item.icon,
              color: isSelected ? WebColors.textWhite : WebColors.iconGreyShade,
              size: 20,
            ),
            selectedTitleStyle: isSelected
                ? GoogleFonts.openSans(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: WebColors.textWhite,
                  )
                : GoogleFonts.openSans(
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                    color: WebColors.textWhite,
                  ),
            borderRadius: BorderRadius.circular(8),
            highlightSelectedColor: WebColors.buttonBlue,
          );
        }).toList(),
      ),
    );
  }
}

class SideMenuItems {
  final String title;
  final IconData icon;
  final String pageTitle;

  SideMenuItems({
    required this.title,
    required this.icon,
    required this.pageTitle,
  });
}
