
import 'package:flutter/material.dart';

// ! Fade Push
void fadePush(BuildContext context, Widget page) {
  Navigator.push(
    context,
    PageRouteBuilder(
      pageBuilder: (context, animation, secondaryAnimation) => page,
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        return FadeTransition(opacity: animation, child: child);
      },
    ),
  );
}

// ! Fade Push ReplaceMent
void fadePUshReplaceMent(BuildContext context, Widget page) {
  Navigator.pushReplacement(
    context,
    PageRouteBuilder(
      pageBuilder: (context, animation, secondaryAnimation) => page,
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        return FadeTransition(opacity: animation, child: child);
      },
    ),
  );
}


// ! Fade push And RemoveUntil
void fadePushAndRemoveUntil(BuildContext context, Widget page) {
  Navigator.pushAndRemoveUntil(
    context,
    PageRouteBuilder(
      pageBuilder: (context, animation, secondaryAnimation) => page,
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        return FadeTransition(opacity: animation, child: child);
      },
    ),
    (Route<dynamic> route) => false,
  );
}

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
        color: Colors.transparent,
        child: Container(
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(10),
          ),
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Icon(Icons.check_circle, color: Colors.white, size: 16),
              const SizedBox(width: 10),
              Text(message, style: const TextStyle(color: Colors.white)),
              const SizedBox(width: 30),
              IconButton(
                icon: const Icon(Icons.close, color: Colors.white, size: 15),
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
