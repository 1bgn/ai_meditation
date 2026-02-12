import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

enum ActionButtonPosition { top, middle, bottom }

class ActionButton extends StatelessWidget {
  const ActionButton({
    required this.title,
    required this.position,
    required this.onPressed,
    required this.iconAsset,
  });

  final String title;
  final ActionButtonPosition position;
  final VoidCallback onPressed;
  final String iconAsset;

  @override
  Widget build(BuildContext context) {
    final borderRadius = switch (position) {
      ActionButtonPosition.top => BorderRadius.only(
        topLeft: const Radius.circular(32),
        topRight: const Radius.circular(32),
        bottomLeft: const Radius.circular(12),
        bottomRight: const Radius.circular(12),
      ),
      ActionButtonPosition.middle => BorderRadius.circular(12),
      ActionButtonPosition.bottom => BorderRadius.only(
        bottomLeft: const Radius.circular(32),
        bottomRight: const Radius.circular(32),
        topLeft: const Radius.circular(12),
        topRight: const Radius.circular(12),
      ),
    };

    return FilledButton(
      onPressed: onPressed,
      style: FilledButton.styleFrom(
        shape: RoundedRectangleBorder(borderRadius: borderRadius),
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 26),
      ),
      child: Row(
        children: [
          SvgPicture.asset(iconAsset, width: 24, height: 24),
          const SizedBox(width: 36.5),
          Expanded(child: Text(title)),
        ],
      ),
    );
  }
}
