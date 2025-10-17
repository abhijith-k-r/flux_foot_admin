import 'package:flutter/material.dart';
import 'package:flux_foot_admin/features/brand_management/views/screen/brand_management_screen.dart';
import 'package:flux_foot_admin/features/category_manager/views/screen/category_management_screen.dart';
import 'package:flux_foot_admin/features/sidemenu/views/widgets/custom_sidemenu.dart';
import 'package:flux_foot_admin/features/sidemenu/views/screens/sidemenu.dart';
import 'package:flux_foot_admin/features/seller_management/views/screens/seller_management.dart';

class SidemenuProvider extends ChangeNotifier {
  String _currentPageTitle = "Dashboard Overview";
  int _selectedIndex = 0;

  String get currentPageTitle => _currentPageTitle;
  int get selectedIndex => _selectedIndex;

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
      title: "Category Management",
      icon: Icons.category,
      pageTitle: "Category Management",
    ),
    SideMenuItems(
      title: "Brand Management",
      icon: Icons.branding_watermark,
      pageTitle: "Brand Management",
    ),
    SideMenuItems(
      title: "Orders",
      icon: Icons.shopping_cart,
      pageTitle: "Orders Management",
    ),
  ];

  void onMenuItemTap(int index) {
    _selectedIndex = index;
    _currentPageTitle = menuItems[index].pageTitle;
    notifyListeners();
  }

  Widget buildMainContent(BuildContext context) {
    switch (selectedIndex) {
      case 0:
        return buildDashboardContent();
      case 1:
        return buildUserManagementContent();
      case 2:
        return SellerManagement();
      case 3:
        return CategoryManagementScreen();
      case 4:
        return BrandManagementScreen();
      case 5:
        return buildOrdersContent();
      default:
        return buildDashboardContent();
    }
  }
}
