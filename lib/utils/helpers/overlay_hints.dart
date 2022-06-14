import 'package:flutter/material.dart';
import 'package:usainua/widgets/animated_widgets/animated_dot_hint.dart';

class OverlayHints {
  static void initDotHint({
    required BuildContext context,
    required OverlayController overlayController,
  }) {
    OverlayEntry? overlayEntry;
    OverlayState? overlayState = Overlay.of(context);

    overlayController.dispose = () {
      overlayEntry?.remove();
    };

    overlayEntry = OverlayEntry(
      builder: (context) => Positioned(
        right: 0,
        top: 0,
        child: AnimatedDotHint(
          overlayController: overlayController,
        ),
      ),
    );

    Future.delayed(const Duration(seconds: 0), () {
      overlayState?.insert(overlayEntry!);
    });
  }
}

class OverlayController {
  Function open = () {};
  VoidCallback close = () {};
  VoidCallback dispose = () {};
}
