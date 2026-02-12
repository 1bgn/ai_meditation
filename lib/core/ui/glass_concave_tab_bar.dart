import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:liquid_glass_renderer/liquid_glass_renderer.dart';

class GlassConcaveTabBar extends StatelessWidget {
  GlassConcaveTabBar({
    super.key,
    required this.currentIndex,
    required this.onChanged,
    required this.icons,
    this.height = 72,
    this.itemSize = 44,
    this.iconSize = 20,
    this.iconColor = const Color(0xFF8D8D8D),
    this.selectedIconColor = Colors.black,
    this.borderColor = const Color(0x66FFFFFF),
    this.glassSettings,
    this.borderRadius = 28,
  });

  final int currentIndex;
  final ValueChanged<int> onChanged;
  final List<(String, String)> icons;

  final double height;
  final double itemSize;
  final double iconSize;

  final Color iconColor;
  final Color selectedIconColor;
  final Color borderColor;

  LiquidGlassSettings? glassSettings;
  final double borderRadius;

  @override
  Widget build(BuildContext context) {
    final barShape = LiquidRoundedSuperellipse(borderRadius: 100);
    final br = BorderRadius.circular(borderRadius);
    glassSettings ??= LiquidGlassSettings(
      thickness: 20,
      blur: 10,
      glassColor: Colors.white.withOpacity(0.8),
      lightAngle: 60,
      lightIntensity: 2,
      saturation: 1,
    );
    return SafeArea(
      top: false,
      child: SizedBox(
        height: height,
        child: Padding(
          padding: const EdgeInsets.all(0),
          child: LiquidGlassLayer(
            settings: glassSettings!,
            child: ClipRRect(
              borderRadius: br,
              child: LayoutBuilder(
                builder: (context, c) {
                  return Stack(
                    children: [
                      // Стеклянная подложка (фон бара)
                      Positioned.fill(
                        child: LiquidGlass(
                          shape: barShape,
                          glassContainsChild:
                              false, // контент рисуется поверх стекла
                          child: SizedBox(width: c.maxWidth, height: height),
                        ),
                      ),

                      // Кнопки поверх
                      Padding(
                        padding: const EdgeInsets.all(4),
                        child: Row(
                          children: List.generate(icons.length, (i) {
                            final selected = i == currentIndex;
                            return Expanded(
                              child: _ConcaveTabItem(
                                selected: selected,
                                iconAsset: icons[i].$1,
                                title: icons[i].$2,
                                iconSize: iconSize,
                                iconColor: iconColor,
                                selectedIconColor: selectedIconColor,
                                borderColor: borderColor,
                                onTap: () => onChanged(i),
                              ),
                            );
                          }),
                        ),
                      ),
                    ],
                  );
                },
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _ConcaveTabItem extends StatelessWidget {
  const _ConcaveTabItem({
    required this.selected,
    required this.iconSize,
    required this.iconAsset,
    required this.iconColor,
    required this.selectedIconColor,
    required this.borderColor,
    required this.title,
    required this.onTap,
  });

  final bool selected;
  final double iconSize;
  final String iconAsset;
  final String title;

  final Color iconColor;
  final Color selectedIconColor;
  final Color borderColor;

  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final br = BorderRadius.circular(100);
    final shape = LiquidRoundedSuperellipse(borderRadius: 100);

    final inner = Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          SvgPicture.asset(
            iconAsset,
            width: iconSize,
            height: iconSize,
            color: selected ? selectedIconColor : iconColor,
          ),
          const SizedBox(height: 4),
          Text(
            title,
            style: GoogleFonts.funnelDisplay(
              fontSize: 10,
              fontWeight: FontWeight.w700,
              height: 12 / 10,
              letterSpacing: -0.5,
              color: selected ? Colors.black : Colors.grey,
            ),
          ),
        ],
      ),
    );

    Widget content;

    if (selected) {
      // ВАЖНО: цвет полупрозрачный, иначе “просвет” пропадёт
      content = LiquidGlass(
        shape: shape,
        glassContainsChild: false,
        child: ClipRRect(
          borderRadius: br,
          child: Container(
            decoration: BoxDecoration(
              color: const Color(
                0x18FFFFFF,
              ), // было 0xffF6F7FA (почти непрозрачно)
              borderRadius: br,
              border: Border.all(color: borderColor, width: 1),
            ),
            alignment: Alignment.center,
            child: inner,
          ),
        ),
      );
    } else {
      // Не выбран: оставь как тебе нравится (можно ClayContainer/простой контейнер)
      content = Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: br,
          border: Border.all(color: borderColor, width: 1),
        ),
        alignment: Alignment.center,
        child: inner,
      );
    }

    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        customBorder: RoundedRectangleBorder(borderRadius: br),
        child: content,
      ),
    );
  }
}
