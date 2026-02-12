import 'package:clay_containers/constants.dart';
import 'package:clay_containers/widgets/clay_container.dart';
import 'package:flutter/material.dart' hide BoxDecoration, BoxShadow;
import 'package:flutter_inset_shadow/flutter_inset_shadow.dart';
import 'package:flutter_svg/flutter_svg.dart';

class ConcaveCircleButton extends StatefulWidget {
  const ConcaveCircleButton({
    super.key,
    this.iconSize = 12,
    required this.onPressed,
    required this.svgAssetPath,
    this.size = 40,
    this.iconColor,
  });

  final VoidCallback onPressed;
  final String svgAssetPath;
  final double size;
  final Color? iconColor;
  final double iconSize;
  @override
  State<ConcaveCircleButton> createState() => _ConcaveCircleButtonState();
}

class _ConcaveCircleButtonState extends State<ConcaveCircleButton> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.onPressed,
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(color: Colors.white, width: 0.5),
          borderRadius: BorderRadius.circular(widget.size / 2),
        ),
        child: ClayContainer(
          color: Colors.white,
          height: widget.size - 2,
          width: widget.size - 2,
          borderRadius: (widget.size - 1) / 2,
          depth: 25,
          curveType: CurveType.concave,
          spread: 40,
          child: Center(
            child: SvgPicture.asset(
              widget.svgAssetPath,
              color: widget.iconColor,
              width: widget.iconSize,
              height: widget.iconSize,
            ),
          ),
        ),
      ),
    );
  }
}
