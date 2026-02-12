import 'package:flutter/material.dart';

Future<bool?> showMyBootomSheet(
  BuildContext context, {
  required double height,
  required Widget child,
}) => showModalBottomSheet<bool>(
  context: context,
  isScrollControlled: true,
  isDismissible: true,
  enableDrag: true,
  useRootNavigator: true,
  backgroundColor: Colors.transparent,
  builder: (sheetContext) => ClipRRect(
    borderRadius: const BorderRadius.only(
      topLeft: Radius.circular(32),
      topRight: Radius.circular(32),
    ),
    child: SizedBox(height: height, child: child),
  ),
);
