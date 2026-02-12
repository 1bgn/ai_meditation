import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class MyTabBar extends StatelessWidget {
  final ValueChanged<int> onTap;
  final List<TabItem> tabs;
  final int selectedIndex;

  const MyTabBar({
    super.key,
    required this.tabs,
    required this.onTap,
    required this.selectedIndex,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(100)),
        color: Colors.white,
      ),
      padding: const EdgeInsets.all(4),
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          children: tabs.asMap().entries.map((entry) {
            final i = entry.key;
            final tab = entry.value;

            return _MyTab(
              title: tab.title,
              index: i,
              isSelected: selectedIndex == i,
              onTap: onTap,
            );
          }).toList(),
        ),
      ),
    );
  }
}

class TabItem {
  final String title;
  TabItem({required this.title});
}

class _MyTab extends StatelessWidget {
  final String title;
  final bool isSelected;
  final ValueChanged<int> onTap;
  final int index;

  const _MyTab({
    required this.title,
    required this.index,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final child = Container(
      padding: const EdgeInsets.symmetric(horizontal: 21, vertical: 8),
      decoration: isSelected
          ? const BoxDecoration(
              color: Colors.black,
              borderRadius: BorderRadius.all(Radius.circular(100)),
            )
          : null,
      child: Center(
        child: Text(
          title.toUpperCase(),
          style: GoogleFonts.funnelDisplay(
            fontSize: 13,
            height: 20 / 13,
            letterSpacing: -0.5,
            color: isSelected ? Colors.white : const Color(0xffAAAEBA),
          ),
        ),
      ),
    );

    if (isSelected) return child;

    return GestureDetector(onTap: () => onTap(index), child: child);
  }
}
