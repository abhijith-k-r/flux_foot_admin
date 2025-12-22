// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:flux_foot_admin/core/constants/web_colors.dart';
import 'package:flux_foot_admin/core/widgets/custom_back_button.dart';
import 'package:flux_foot_admin/features/carousel_image/views/widgets/header_info_widget.dart';
import 'package:flux_foot_admin/features/carousel_image/views/widgets/left_colum_widget.dart';
import 'package:flux_foot_admin/features/carousel_image/views/widgets/right_colum_widget.dart';
import 'package:flux_foot_admin/features/carousel_image/views/widgets/save_button.dart';

class CarouselManagementContent extends StatelessWidget {
  const CarouselManagementContent({super.key});

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: WebColors.bgDarkGrey,
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: SingleChildScrollView(
          child: Container(
            constraints: const BoxConstraints(maxWidth: 1280),
            padding: const EdgeInsets.all(24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                customBackButton(context),
                const SizedBox(height: 24),
                // ! Page Header
                LayoutBuilder(
                  builder: (context, constraints) {
                    return constraints.maxWidth > 600
                        ? Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Expanded(child: buildHeaderInfo()),
                              const SizedBox(width: 16),
                              buildSaveButton(context),
                            ],
                          )
                        : Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              buildHeaderInfo(),
                              const SizedBox(height: 16),
                              buildSaveButton(context),
                            ],
                          );
                  },
                ),
                const SizedBox(height: 32),
                // ! Main Grid Layout
                LayoutBuilder(
                  builder: (context, constraints) {
                    if (constraints.maxWidth > 1024) {
                      return Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(flex: 8, child: buildLeftColumn(context)),
                          const SizedBox(width: 32),
                          SizedBox(width: 350, child: buildRightColumn(context)),
                        ],
                      );
                    } else {
                      return Column(
                        children: [
                          buildLeftColumn(context),
                          const SizedBox(height: 24),
                          buildRightColumn(context),
                        ],
                      );
                    }
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
