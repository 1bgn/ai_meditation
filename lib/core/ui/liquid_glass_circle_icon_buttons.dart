import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:liquid_glass_renderer/liquid_glass_renderer.dart';

class LiquidGlassCircleIconButton extends StatefulWidget {
  const LiquidGlassCircleIconButton({
    super.key,
    required this.svgAssetIcon,
    required this.onTap,
    required this.radius,
    this.iconSize,
    this.settings = const LiquidGlassSettings(
      thickness: 20,
      blur: 10,
      glassColor: Color(0x22FFFFFF),
      lightAngle: 60,
      lightIntensity: 2,
      saturation: 1,
    ),
  });

  final String svgAssetIcon;
  final VoidCallback onTap;
  final double radius;
  final double? iconSize;
  final LiquidGlassSettings settings;

  @override
  State<LiquidGlassCircleIconButton> createState() => _LiquidGlassCircleIconButtonState();
}

class _LiquidGlassCircleIconButtonState extends State<LiquidGlassCircleIconButton> {


  @override
  void initState() {
    super.initState();
   SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.dark.copyWith(
   statusBarColor: Colors.white, 
   statusBarBrightness: Brightness.dark 
));
  }
  @override
  Widget build(BuildContext context) {
    final double d = widget.radius * 2;
    final double s = widget.iconSize ?? (widget.radius * 0.9);

    return LiquidGlass.withOwnLayer(
      settings: widget.settings,
      shape: const LiquidOval(), // поддерживаемая форма
      child: SizedBox(
        height: d,
        width: d,
        child: ClipOval(
          child: Material(
            type: MaterialType.transparency,
            child: InkWell(
              onTap: widget.onTap,
              child: Center(
                child: SvgPicture.asset(
                  widget.svgAssetIcon,
                  color: Colors.white,
                  width: s,
                  height: s,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}


class LiquidGlassPillButton extends StatelessWidget {
  const LiquidGlassPillButton({
    super.key,
    required this.onTap,
    required this.child,
    this.height = 48,
    this.borderRadius = 100,
    this.padding = const EdgeInsets.symmetric(horizontal: 16),
    this.settings = const LiquidGlassSettings(
      thickness: 18,
      blur: 8,
      glassColor: Color(0x22FFFFFF),
      saturation: 1.15,
    ),
  });

  final VoidCallback onTap;
  final Widget child;

  final double height;
  final double borderRadius;
  final EdgeInsets padding;
  final LiquidGlassSettings settings;

  @override
  Widget build(BuildContext context) {
    final r = BorderRadius.circular(borderRadius);

    return LiquidGlass.withOwnLayer(
      settings: settings,
      shape: LiquidRoundedSuperellipse(borderRadius:borderRadius),
      child: ConstrainedBox(
        constraints: BoxConstraints(minHeight: height),
        child: ClipRRect(
          borderRadius: r,
          child: Material(
            type: MaterialType.transparency,
            child: InkWell(
              onTap: onTap,
              child: Padding(
                padding: padding,
                child: DefaultTextStyle.merge(
                  style: const TextStyle(fontSize: 16),
                  child: Row(
                    mainAxisSize: MainAxisSize.min, 
                    children: [child],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}


class LiquidGlassPillButton2 extends StatelessWidget {
  const LiquidGlassPillButton2({
    super.key,
    required this.onTap,
    required this.child,
    this.leading,
    this.height = 48,
    this.borderRadius = 100,
    this.leadingGap = 10,
    this.labelPadding = const EdgeInsets.only(left: 14, right: 16),
    this.settings = const LiquidGlassSettings(
      thickness: 20,
      blur: 10,
      glassColor: Color(0x22FFFFFF),
      lightAngle: 60,
      lightIntensity: 2,
      saturation: 1,
    ),
  });

  final VoidCallback onTap;
  final Widget child;

  final Widget? leading;

  final double height;
  final double borderRadius;

  final double leadingGap;

  final EdgeInsets labelPadding;

  final LiquidGlassSettings settings;

  @override
  Widget build(BuildContext context) {
    final r = BorderRadius.circular(borderRadius);

    return LiquidGlass.withOwnLayer(
      settings: settings,
      shape: LiquidRoundedSuperellipse(borderRadius: borderRadius),
      child: ClipRRect(
        borderRadius: r,
        child: Material(
          type: MaterialType.transparency,
          child: InkWell(
            onTap: onTap,
            borderRadius: r, 
            child: SizedBox(
              height: height,
              child: Row(
                mainAxisSize: MainAxisSize.min, 
                children: [
                  if (leading != null)
                    leading!,
                  Padding(
                    padding: labelPadding,
                    child: Center(child: child),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
