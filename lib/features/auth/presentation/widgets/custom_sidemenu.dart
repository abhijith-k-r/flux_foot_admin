import 'package:flutter/material.dart';
import 'package:flutter_side_menu/flutter_side_menu.dart';
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
    final size = MediaQuery.of(context).size.width;
    return SideMenu(
      backgroundColor: const Color(0xFF1E2A44),
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
              color: isSelected ? Colors.white : Colors.white70,
              size: 20,
            ),
            selectedTitleStyle: isSelected
                ? GoogleFonts.openSans(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: Colors.white,
                  )
                : GoogleFonts.openSans(
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                    color: Colors.white,
                  ),
            borderRadius: BorderRadius.circular(8),
            highlightSelectedColor: Color(0xFF4B5EFC),
          );
        }).toList(),
        footer: Padding(
          padding: const EdgeInsets.only(bottom: 8),
          child: Container(
            height: size * 0.03,
            width: size * 0.2,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15),
              border: BoxBorder.all(color: Colors.black),
            ),
            child: size > 0.03
                ? Padding(
                    padding: const EdgeInsets.all(5),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        CircleAvatar(
                          child: Icon(Icons.person_outline_outlined),
                        ),
                        Text('Marcus RashFord'),
                      ],
                    ),
                  )
                : CircleAvatar(child: Icon(Icons.person_outline_outlined)),
          ),
        ),
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
