import 'package:ai_meditation/features/history/presentation/pages/history_page.dart';
import 'package:ai_meditation/features/home/presentation/pages/home_page.dart';
import 'package:flutter/material.dart';

class PageSelector extends StatefulWidget {
  @override
  State<PageSelector> createState() => _PageSelectorState();
}

class _PageSelectorState extends State<PageSelector> {
  @override
  Widget build(BuildContext context) {
    return IndexedStack(children: [HomePage(), HistoryPage()]);
  }
}
