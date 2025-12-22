import 'package:flutter/material.dart';
import 'package:flux_foot_admin/features/dashboard/views/widgets/carousel_card.dart';
import 'package:flux_foot_admin/features/dashboard/views/widgets/dahboardview_statuscard.dart';

class DashboardContent extends StatelessWidget {
  const DashboardContent({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(40),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Stats Grid
          LayoutBuilder(
            builder: (context, constraints) {
              if (constraints.maxWidth > 900) {
                return Row(
                  children: [
                    Expanded(
                      child: buildStatCard(
                        icon: Icons.group,
                        iconColor: const Color(0xFF0d59f2),
                        backgroundColor: const Color(0xFFEBF2FF),
                        title: 'Total Active Users',
                        value: '12,405',
                        valueColor: const Color(0xFF0d59f2),
                      ),
                    ),
                    const SizedBox(width: 24),
                    Expanded(
                      child: buildStatCard(
                        icon: Icons.storefront,
                        iconColor: const Color(0xFF0d59f2),
                        backgroundColor: const Color(0xFFEBF2FF),
                        title: 'Total Active Sellers',
                        value: '340',
                        valueColor: const Color(0xFF0d59f2),
                      ),
                    ),
                    const SizedBox(width: 24),
                    Expanded(
                      child: buildStatCard(
                        icon: Icons.warning_amber_rounded,
                        iconColor: const Color(0xFFEF4444),
                        backgroundColor: const Color(0xFFFEE2E2),
                        title: 'Products Pending',
                        value: '5',
                        valueColor: const Color(0xFFDC2626),
                        hasAlert: true,
                      ),
                    ),
                  ],
                );
              } else {
                return Column(
                  children: [
                    buildStatCard(
                      icon: Icons.group,
                      iconColor: const Color(0xFF0d59f2),
                      backgroundColor: const Color(0xFFEBF2FF),
                      title: 'Total Active Users',
                      value: '12,405',
                      valueColor: const Color(0xFF0d59f2),
                    ),
                    const SizedBox(height: 24),
                    buildStatCard(
                      icon: Icons.storefront,
                      iconColor: const Color(0xFF0d59f2),
                      backgroundColor: const Color(0xFFEBF2FF),
                      title: 'Total Active Sellers',
                      value: '340',
                      valueColor: const Color(0xFF0d59f2),
                    ),
                    const SizedBox(height: 24),
                    buildStatCard(
                      icon: Icons.warning_amber_rounded,
                      iconColor: const Color(0xFFEF4444),
                      backgroundColor: const Color(0xFFFEE2E2),
                      title: 'Products Pending',
                      value: '5',
                      valueColor: const Color(0xFFDC2626),
                      hasAlert: true,
                    ),
                  ],
                );
              }
            },
          ),

          const SizedBox(height: 32),

          // ! Hero Carousel Widget
          buildHeroCarousel(),

          const SizedBox(height: 32),
        ],
      ),
    );
  }
  
}
