import 'package:flutter/material.dart';
import 'package:flux_foot_admin/core/constants/web_colors.dart';

// ! Custom SnackBar
void showOverlaySnackbar(BuildContext context, String message, Color color) {
  // ignore: unnecessary_nullable_for_final_variable_declarations
  final OverlayState? overlay = Overlay.of(context);
  if (overlay == null) {
    return; // Exit if no overlay is available
  }

  // Define the OverlayEntry
  late OverlayEntry overlayEntry;

  overlayEntry = OverlayEntry(
    builder: (context) => Positioned(
      top: 50,
      right: 10,
      child: Material(
        color: WebColors.transparent,
        child: Container(
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(10),
          ),
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(Icons.check_circle, color: WebColors.iconeWhite, size: 16),
              const SizedBox(width: 10),
              Text(message, style: TextStyle(color: WebColors.iconeWhite)),
              const SizedBox(width: 30),
              IconButton(
                icon: Icon(Icons.close, color: WebColors.iconeWhite, size: 15),
                onPressed: () {
                  // Safely remove the overlay entry
                  if (overlayEntry.mounted) {
                    overlayEntry.remove();
                  }
                },
              ),
            ],
          ),
        ),
      ),
    ),
  );

  overlay.insert(overlayEntry);

  Future.delayed(const Duration(seconds: 3), () {
    if (overlayEntry.mounted) {
      overlayEntry.remove();
    }
  });
}
