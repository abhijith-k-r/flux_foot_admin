import 'package:flutter/material.dart';
import 'package:flux_foot_admin/core/constants/web_colors.dart';

// ! Custom Back Button
Padding customBackButton(BuildContext context) {
  return Padding(
    padding: const EdgeInsets.all(10),
    child: Container(
      width: 40,
      height: 40,
      decoration: BoxDecoration(
        color: WebColors.defaultGrey,
        borderRadius: BorderRadius.circular(15),
      ),
      child: IconButton(
        onPressed: () {
          Navigator.pop(context);
        },
        icon: Icon(Icons.close, color: WebColors.iconeWhite),
        tooltip: 'Back',
      ),
    ),
  );
}
