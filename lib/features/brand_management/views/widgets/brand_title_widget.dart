import 'package:flutter/material.dart';
import 'package:flux_foot_admin/core/constants/web_colors.dart';
import 'package:flux_foot_admin/core/widgets/custom_text.dart';

Widget buildTitleContents(double size) {
  return Card(
    elevation: 3,
    shadowColor: WebColors.textWhiteLite,
    color: WebColors.bgDarkBlue1,
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
    child: Padding(
      padding: const EdgeInsets.only(top: 15, bottom: 15),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          SizedBox(
            width: size * 0.15,
            child: Center(child: customText(20, 'Name')),
          ),

          SizedBox(
            width: size * 0.15,
            child: Center(child: customText(20, 'Status')),
          ),

          SizedBox(
            width: size * 0.15,
            child: Center(child: customText(20, 'Created At')),
          ),

          SizedBox(
            width: size * 0.15,
            child: Center(child: customText(20, 'Action')),
          ),
        ],
      ),
    ),
  );
}
