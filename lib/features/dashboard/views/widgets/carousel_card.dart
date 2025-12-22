// ignore_for_file: deprecated_member_use

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flux_foot_admin/features/dashboard/views/widgets/large_screen_layout.dart';
import 'package:flux_foot_admin/features/dashboard/views/widgets/small_screen_layout.dart';

// ! Carousel Card
Widget buildHeroCarousel() {
  final List<Map<String, String>> carouselItems = [
    {
      'title': 'Homepage Media & Carousel Control',
      'description':
          'Click to manage images, rotation, and display settings for the main app feed.',
      'buttonText': 'Manage Display',
    },
    {
      'title': 'Analytics Dashboard',
      'description':
          'View comprehensive statistics and insights about your platform performance.',
      'buttonText': 'View Analytics',
    },
    {
      'title': 'User Management',
      'description':
          'Monitor and manage all user activities, permissions, and account settings.',
      'buttonText': 'Manage Users',
    },
  ];

  return CarouselSlider(
    options: CarouselOptions(
      height: 280,
      autoPlay: true,
      autoPlayInterval: const Duration(seconds: 5),
      autoPlayAnimationDuration: const Duration(milliseconds: 800),
      autoPlayCurve: Curves.easeInOut,
      enlargeCenterPage: true,
      viewportFraction: 1.0,
      enableInfiniteScroll: true,
    ),
    items: carouselItems.map((item) {
      return Builder(
        builder: (BuildContext context) {
          final screenWidth = MediaQuery.of(context).size.width;
          final isSmallScreen = screenWidth < 800;

          return Container(
            width: MediaQuery.of(context).size.width,
            margin: const EdgeInsets.symmetric(vertical: 8),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(24),
              gradient: const LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  Color(0xFF0B1120),
                  Color(0xFF1e3a8a),
                  Color(0xFF0d59f2),
                ],
              ),
              boxShadow: [
                BoxShadow(
                  color: const Color(0xFF0B1120).withOpacity(0.2),
                  blurRadius: 24,
                  offset: const Offset(0, 8),
                ),
              ],
            ),
            child: Stack(
              children: [
                // Decorative circles
                Positioned(
                  right: -80,
                  top: -80,
                  child: Container(
                    width: 384,
                    height: 384,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.white.withOpacity(0.05),
                    ),
                  ),
                ),
                Positioned(
                  left: -80,
                  bottom: -80,
                  child: Container(
                    width: 256,
                    height: 256,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: const Color(0xFF0d59f2).withOpacity(0.2),
                    ),
                  ),
                ),

                // Content
                Padding(
                  padding: EdgeInsets.all(isSmallScreen ? 24 : 48),
                  child: isSmallScreen
                      ? buildSmallScreenLayout(context, item)
                      : buildLargeScreenLayout(context, item),
                ),
              ],
            ),
          );
        },
      );
    }).toList(),
  );
}
