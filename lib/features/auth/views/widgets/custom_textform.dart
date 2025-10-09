import 'package:flutter/material.dart';
import 'package:flux_foot_admin/core/constants/web_colors.dart';
import 'package:google_fonts/google_fonts.dart';

// !Custom Text Form Field
class CustomTextFormField extends StatelessWidget {
  final String label;
  final String hintText;
  final Widget? prefIcon;
  final Widget? suffIcon;
  final TextEditingController? controller;
  final FocusNode? focusNode;
  final bool obscureText;
  final TextInputType? keyboardType;
  final TextInputAction? textInputAction;
  final String? Function(String?)? validator;
  final Function(String)? onFieldSubmitted;

  const CustomTextFormField({
    super.key,
    required this.label,
    required this.hintText,
    this.prefIcon,
    this.suffIcon,
    this.controller,
    this.focusNode,
    this.obscureText = false,
    this.keyboardType,
    this.textInputAction,
    this.validator,
    this.onFieldSubmitted,
  });

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final isMobile = size.width < 768;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: GoogleFonts.openSans(
            color: WebColors.textWhite,
            fontSize: isMobile ? 14 : 12,
            fontWeight: FontWeight.w500,
          ),
        ),
        SizedBox(height: 8),
        TextFormField(
          controller: controller,
          focusNode: focusNode,
          obscureText: obscureText,
          keyboardType: keyboardType,
          textInputAction: textInputAction,
          validator: validator,
          onFieldSubmitted: onFieldSubmitted,
          style: GoogleFonts.openSans(
            color: WebColors.textWhite,
            fontSize: isMobile ? 16 : 14,
          ),
          decoration: InputDecoration(
            hintText: hintText,
            hintStyle: GoogleFonts.openSans(
              color: WebColors.iconGreyShade,
              fontSize: isMobile ? 16 : 14,
            ),
            prefixIcon: prefIcon,
            suffixIcon: suffIcon,
            fillColor: Color(0xFF2E3A55),
            filled: true,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(color: WebColors.borderSideGrey),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(color: WebColors.borderSideGrey),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(
                color: WebColors.borderSideOrangeAcnt,
                width: 2,
              ),
            ),
            errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(color: WebColors.errorRed),
            ),
            focusedErrorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(color: WebColors.errorRed, width: 2),
            ),
            contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 16),
          ),
        ),
      ],
    );
  }
}
