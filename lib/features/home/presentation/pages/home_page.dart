import 'dart:ui' as ui;

import 'package:adaptive_platform_ui/adaptive_platform_ui.dart';
import 'package:ai_meditation/core/ui/glass_concave_tab_bar.dart';
import 'package:ai_meditation/features/daily_routine/domain/entities/daily_routine_activity.dart';
import 'package:ai_meditation/features/daily_routine/presentation/pages/start_routine_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:signals_flutter/signals_flutter.dart';

import '../../../../core/di/injection_container.dart';
import '../../../breathing/presentation/pages/breathing_page.dart';
import '../../../generation/presentation/pages/generation_page.dart';
import '../../../daily_routine/presentation/pages/daily_routine_page.dart';
import '../controllers/home_controller.dart';
import '../widgets/recommendation_card.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late final HomeController _controller;

  @override
  void initState() {
    super.initState();
    _controller = getIt<HomeController>()..load();
  }

  @override
  Widget build(BuildContext context) => Scaffold(
    body: SafeArea(
      child: AdaptiveScaffold(
        bottomNavigationBar: AdaptiveBottomNavigationBar(
          useNativeBottomBar:
              true, // Enable native iOS 26 UITabBar with Liquid Glass effects (default)
          items: [
            AdaptiveNavigationDestination(
              // icon: dynamic → SF Symbol (iOS) или IconData (кроссплатформенно)
              icon: PlatformInfo.isIOS ? 'house.fill' : Icons.home,
              label: 'Home',
            ),
            AdaptiveNavigationDestination(
              icon: PlatformInfo.isIOS ? 'magnifyingglass' : Icons.search,
              label: 'Search',
            ),
          ],
          selectedIndex: 0,
          onTap: (index) {},
        ),
        body: Stack(
          children: [
            Positioned.fill(
              child: Image.asset(
                "assets/images/home_bg.png",
                fit: BoxFit.cover,
              ),
            ),
            Positioned.fill(
              child: ListView(
                children: [
                  SizedBox(height: 32),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      RichText(
                        text: TextSpan(
                          text: "Hello, ",
                          style: TextStyle(
                            fontFamily: "Amstelvar",
                            fontSize: 24,
                            height: 32 / 24,
                            letterSpacing: -1.5,
                            fontStyle: FontStyle.italic,
                            color: Colors.black,
                          ),
                          children: [
                            TextSpan(
                              text: "Vitalii",
                              style: GoogleFonts.funnelDisplay(
                                fontSize: 24,
                                height: 32 / 24,
                                letterSpacing: -1.5,
                                fontWeight: FontWeight.w600,
                                color: Colors.black,
                                fontStyle: FontStyle.normal,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 32),
                          child: RichText(
                            textAlign: TextAlign.center,
                            text: TextSpan(
                              text: "How are you ",
                              style: TextStyle(
                                fontFamily: "Amstelvar",
                                fontSize: 48,
                                height: 52 / 48,
                                letterSpacing: -1.5,
                                fontWeight: FontWeight.w400,
                                fontStyle: FontStyle.italic,
                                color: Colors.black,
                                fontVariations: [FontVariation('wght', 300)],
                              ),
                              children: [
                                TextSpan(
                                  text: "feeling ",
                                  style: GoogleFonts.funnelDisplay(
                                    fontSize: 48,
                                    height: 52 / 48,
                                    letterSpacing: -1.5,
                                    fontWeight: FontWeight.w600,
                                    color: Colors.black,
                                    fontStyle: FontStyle.normal,
                                  ),
                                  children: [
                                    TextSpan(
                                      text: "today?",
                                      style: TextStyle(
                                        fontFamily: "Amstelvar",
                                        fontSize: 48,
                                        fontWeight: FontWeight.w400,
                                        height: 52 / 48,
                                        letterSpacing: -1.5,
                                        fontStyle: FontStyle.italic,
                                        color: Colors.black,
                                        fontVariations: [
                                          FontVariation('wght', 300),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 32),

                  Container(
                    padding: EdgeInsets.only(left: 0, right: 0, top: 16),
                    decoration: BoxDecoration(
                      color: const Color.fromRGBO(255, 255, 255, 0.48),
                      borderRadius: BorderRadius.circular(40),
                    ),
                    child: ClipRRect(
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(40),
                          gradient: LinearGradient(
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                            colors: [
                              Color.fromRGBO(255, 255, 255, 0),
                              Color.fromRGBO(255, 255, 255, 1),
                            ],
                          ),
                        ),
                        child: Stack(
                          children: [
                            Stack(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(2),
                                  child: Image.asset(
                                    "assets/images/home_bg.png",
                                    opacity: const AlwaysStoppedAnimation(.68),
                                  ),
                                ),
                              ],
                            ),
                            Positioned.fill(
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 0,
                                ),
                                child: Column(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                        horizontal: 16,
                                      ),
                                      child: Column(
                                        children: [
                                          Row(
                                            children: [
                                              Expanded(
                                                child: _ActionButton(
                                                  title: 'Generate Meditation'
                                                      .toUpperCase(),
                                                  position:
                                                      _ActionButtonPosition.top,
                                                  iconAsset:
                                                      'assets/images/generate_mediation.svg',
                                                  onPressed: () =>
                                                      _showGenerationSheet(
                                                        context,
                                                      ),
                                                ),
                                              ),
                                            ],
                                          ),
                                          const SizedBox(height: 4),
                                          Row(
                                            children: [
                                              Expanded(
                                                child: _ActionButton(
                                                  title: 'Breathing Exercise'
                                                      .toUpperCase(),
                                                  position:
                                                      _ActionButtonPosition
                                                          .middle,
                                                  iconAsset:
                                                      'assets/images/breathing_exercise.svg',
                                                  onPressed: () =>
                                                      _showBreathingSheet(
                                                        context,
                                                      ),
                                                ),
                                              ),
                                            ],
                                          ),
                                          const SizedBox(height: 4),
                                          Row(
                                            children: [
                                              Expanded(
                                                child: _ActionButton(
                                                  title: 'Daily Routine'
                                                      .toUpperCase(),
                                                  position:
                                                      _ActionButtonPosition
                                                          .bottom,
                                                  iconAsset:
                                                      'assets/images/daily_routine.svg',
                                                  onPressed: () =>
                                                      _showRoutineSheet(
                                                        context,
                                                      ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                    const SizedBox(height: 16),

                                    Divider(
                                      color: Color.fromRGBO(17, 17, 17, 0.04),
                                    ),
                                    const SizedBox(height: 24),
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                        horizontal: 16,
                                      ),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            "Today’s Meditation",
                                            style: GoogleFonts.funnelDisplay(
                                              fontSize: 16,
                                              fontWeight: FontWeight.w600,
                                              height: 24 / 16,
                                              letterSpacing: -0.5,
                                            ),
                                          ),
                                          Text(
                                            _controller.currentDateString(),
                                            style: GoogleFonts.funnelDisplay(
                                              fontSize: 14,
                                              fontWeight: FontWeight.w400,
                                              height: 20 / 14,
                                              color: Color(0xff90939F),
                                              letterSpacing: -0.5,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    const SizedBox(height: 16),
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                        horizontal: 16,
                                      ),
                                      child: Column(
                                        children: [
                                          _MeditationCard(
                                            item: DailyRoutineMeditation(
                                              title: "Calm",
                                              backgroundSound: "Ambient Music",
                                              badgeText: "CSDVCdsvs",
                                              description:
                                                  "Take a quick meditation break",
                                              durationMinutes: 4,
                                              goal: "Calm",
                                              voiceStyle: "",
                                              imageAsset:
                                                  "assets/images/breath1.jpg",
                                            ),
                                            imageAsset:
                                                "assets/images/breath1.jpg",
                                          ),
                                        ],
                                      ),
                                    ),
                                    const SizedBox(height: 24),

                                    Divider(
                                      color: Color.fromRGBO(17, 17, 17, 0.04),
                                    ),
                                    const SizedBox(height: 24),
                                    Column(
                                      children: [
                                        Row(
                                          children: [
                                            SizedBox(width: 16),
                                            Text(
                                              "Recommended Sessions",
                                              style: GoogleFonts.funnelDisplay(
                                                fontSize: 16,
                                                fontWeight: FontWeight.w600,
                                                height: 24 / 16,
                                                letterSpacing: -0.5,
                                              ),
                                            ),
                                          ],
                                        ),
                                        SizedBox(height: 12),
                                        Padding(
                                          padding: const EdgeInsets.only(
                                            left: 16,
                                          ),
                                          child: _TabBar(),
                                        ),
                                        SizedBox(height: 12),
                                        Row(
                                          children: [
                                            Expanded(
                                              child: SingleChildScrollView(
                                                scrollDirection:
                                                    Axis.horizontal,
                                                child: Row(
                                                  children: [
                                                    SizedBox(width: 16),

                                                    _RecomentationItem(
                                                      number: 1,
                                                    ),
                                                    _RecomentationItem(
                                                      number: 2,
                                                    ),
                                                    _RecomentationItem(
                                                      number: 3,
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            // Positioned.fill(
            //   child: Align(
            //     alignment: Alignment.bottomCenter,
            //     child: Padding(
            //       padding: const EdgeInsets.symmetric(horizontal: 28.0),
            //       child: ,
            //     ),
            //   ),
            // ),
            // Positioned.fill(
            //   child: Align(
            //     alignment: Alignment.bottomCenter,
            //     child: Padding(
            //       padding: const EdgeInsets.symmetric(horizontal: 28.0),
            //       child: GlassConcaveTabBar(
            //         currentIndex: 0,
            //         onChanged: (i) {},
            //         icons: [
            //           ("assets/images/home.svg", "Home"),
            //           ("assets/images/history.svg", "History"),
            //         ],
            //       ),
            //     ),
            //   ),
            // ),
          ],
        ),
      ),
    ),
  );
}

class _TabBar extends StatefulWidget {
  @override
  State<_TabBar> createState() => _TabBarState();
}

class _TabBarState extends State<_TabBar> {
  int selectedTab = 0;
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(100)),
        color: Colors.white,
      ),
      padding: EdgeInsets.all(4),
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          children: [
            _Tab(
              index: 0,
              title: "Sleep",
              isSelected: selectedTab == 0,
              onTap: (val) {
                setState(() {
                  selectedTab = val;
                });
              },
            ),
            _Tab(
              index: 1,
              title: "Stress & ANXIENTY",
              isSelected: selectedTab == 1,
              onTap: (val) {
                setState(() {
                  selectedTab = val;
                });
              },
            ),
            _Tab(
              index: 2,
              title: "Daily meditation",
              isSelected: selectedTab == 2,
              onTap: (val) {
                setState(() {
                  selectedTab = val;
                });
              },
            ),
          ],
        ),
      ),
    );
  }
}

class _Tab extends StatelessWidget {
  final String title;
  final bool isSelected;
  final Function(int) onTap;
  final int index;

  const _Tab({
    super.key,
    required this.title,
    required this.index,
    required this.isSelected,
    required this.onTap,
  });
  @override
  Widget build(BuildContext context) {
    if (!isSelected) {
      return GestureDetector(
        onTap: () {
          onTap(index);
        },
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 21, vertical: 8),
          child: Center(
            child: Text(
              title.toUpperCase(),
              style: GoogleFonts.funnelDisplay(
                fontSize: 13,
                height: 20 / 13,
                letterSpacing: -0.5,
                color: Color(0xffAAAEBA),
              ),
            ),
          ),
        ),
      );
    }
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 21, vertical: 8),
      decoration: BoxDecoration(
        color: Colors.black,
        borderRadius: BorderRadius.all(Radius.circular(100)),
      ),
      child: Center(
        child: Text(
          title.toUpperCase(),
          style: GoogleFonts.funnelDisplay(
            fontSize: 13,
            height: 20 / 13,
            letterSpacing: -0.5,
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}

enum _ActionButtonPosition { top, middle, bottom }

class _ActionButton extends StatelessWidget {
  const _ActionButton({
    required this.title,
    required this.position,
    required this.onPressed,
    required this.iconAsset,
  });

  final String title;
  final _ActionButtonPosition position;
  final VoidCallback onPressed;
  final String iconAsset;

  @override
  Widget build(BuildContext context) {
    final borderRadius = switch (position) {
      _ActionButtonPosition.top => BorderRadius.only(
        topLeft: const Radius.circular(32),
        topRight: const Radius.circular(32),
        bottomLeft: const Radius.circular(12),
        bottomRight: const Radius.circular(12),
      ),
      _ActionButtonPosition.middle => BorderRadius.circular(12),
      _ActionButtonPosition.bottom => BorderRadius.only(
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

class _MeditationCard extends StatelessWidget {
  const _MeditationCard({required this.item, required this.imageAsset});

  final DailyRoutineMeditation item;
  final String imageAsset;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(20),
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Stack(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(16),
                    child: Image.asset(
                      imageAsset,
                      width: 88,
                      height: 88,
                      fit: BoxFit.cover,
                    ),
                  ),
                  Positioned.fill(
                    child: Align(
                      alignment: Alignment.bottomCenter,
                      child: Container(
                        height: 36,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          gradient: LinearGradient(
                            colors: [
                              Colors.black.withOpacity(0.5),
                              Colors.black.withOpacity(0.0),
                            ],
                            stops: [0.0, 1.0],
                            begin: Alignment.bottomCenter,
                            end: Alignment.topCenter,
                          ),
                        ),
                        child: ClipRRect(
                          child: BackdropFilter(
                            filter: ui.ImageFilter.blur(
                              sigmaX: 1.0,
                              sigmaY: 1.0,
                            ),
                            child: Container(),
                          ),
                        ),
                      ),
                    ),
                  ),
                  Positioned.fill(
                    child: Align(
                      alignment: Alignment.bottomCenter,
                      child: Padding(
                        padding: const EdgeInsets.only(bottom: 8),
                        child: Text(
                          '${item.durationMinutes} MIN'.toUpperCase(),
                          style: GoogleFonts.funnelDisplay(
                            fontSize: 14,
                            height: 20 / 14,
                            color: Colors.white,
                            letterSpacing: -0.5,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          '${item.durationMinutes} minutes'.toUpperCase(),
                          style: GoogleFonts.funnelDisplay(
                            fontSize: 16,
                            height: 24 / 16,
                            letterSpacing: -0.5,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 4),
                    Text(
                      item.description,
                      style: GoogleFonts.funnelDisplay(
                        fontSize: 14,
                        height: 20 / 14,
                        color: const Color(0xffAAAEBA),
                        letterSpacing: -0.5,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Container(
                      padding: EdgeInsets.only(
                        left: 8,
                        right: 8,
                        top: 3,
                        bottom: 3,
                      ),
                      decoration: BoxDecoration(
                        color: Color.fromRGBO(119, 201, 126, 0.08),
                        borderRadius: BorderRadius.all(Radius.circular(100)),
                      ),
                      child: Wrap(
                        direction: Axis.horizontal,
                        children: [
                          SvgPicture.asset("assets/images/mat.svg"),
                          SizedBox(width: 6),
                          Text(
                            "Daily Routine".toUpperCase(),
                            style: GoogleFonts.funnelDisplay(
                              fontSize: 14,
                              height: 20 / 14,
                              color: Color.fromRGBO(119, 201, 126, 1),
                              letterSpacing: -0.5,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

void _showGenerationSheet(BuildContext context) {
  showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    backgroundColor: Colors.transparent,
    builder: (context) => ClipRRect(
      borderRadius: const BorderRadius.only(
        topLeft: Radius.circular(32),
        topRight: Radius.circular(32),
      ),
      child: SizedBox(
        height: MediaQuery.of(context).size.height * 0.9,
        child: const GenerationPage(),
      ),
    ),
  );
}

void _showBreathingSheet(BuildContext context) {
  showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    backgroundColor: Colors.transparent,
    builder: (context) => ClipRRect(
      borderRadius: const BorderRadius.only(
        topLeft: Radius.circular(32),
        topRight: Radius.circular(32),
      ),
      child: SizedBox(
        height: MediaQuery.of(context).size.height * 0.90,
        child: const BreathingPage(),
      ),
    ),
  );
}

void _showRoutineSheet(BuildContext context) {
  showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    backgroundColor: Colors.transparent,
    builder: (context) => ClipRRect(
      borderRadius: const BorderRadius.only(
        topLeft: Radius.circular(32),
        topRight: Radius.circular(32),
      ),
      child: SizedBox(
        height: MediaQuery.of(context).size.height * 0.9,
        child: const StartRoutinePage(),
      ),
    ),
  );
}

class _RecomentationItem extends StatelessWidget {
  final int number;

  const _RecomentationItem({super.key, required this.number});

  String get breathImg {
    switch (number) {
      case 1:
        return 'assets/images/breath1.jpg';
      case 2:
        return 'assets/images/breath2.jpg';
      case 3:
        return 'assets/images/breath3.jpg';
      default:
        return 'assets/images/breath1.jpg';
    }
  }

  int get breathTime {
    switch (number) {
      case 1:
        return 3;
      case 2:
        return 5;
      case 3:
        return 10;
      default:
        return 3;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 157,
      margin: EdgeInsets.only(right: 8),
      padding: EdgeInsets.all(4),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(24),
        color: Colors.white,
      ),
      child: Stack(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: Image.asset(
              breathImg,
              width: 149,
              height: 243,
              fit: BoxFit.cover,
            ),
          ),
          Positioned.fill(
            child: Align(
              alignment: Alignment.topCenter,
              child: Container(
                padding: EdgeInsets.symmetric(vertical: 3),
                margin: EdgeInsets.only(top: 8, left: 8, right: 8),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(100),
                  color: Color(0xff11111129).withOpacity(0.16),
                ),
                child: Row(
                  children: [
                    SizedBox(width: 22),
                    SvgPicture.asset("assets/images/breathing_icon.svg"),
                    SizedBox(width: 6),
                    Text(
                      "BREATHING",
                      style: GoogleFonts.funnelDisplay(
                        color: Colors.white,
                        fontSize: 12,
                        height: 15 / 12,
                        letterSpacing: -0.5,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          Positioned.fill(
            child: Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                height: 68,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  gradient: LinearGradient(
                    colors: [
                      Colors.black.withOpacity(0.5),
                      Colors.black.withOpacity(0.0),
                    ],
                    stops: [0.0, 1.0],
                    begin: Alignment.bottomCenter,
                    end: Alignment.topCenter,
                  ),
                ),
                child: ClipRRect(
                  child: BackdropFilter(
                    filter: ui.ImageFilter.blur(sigmaX: 1.0, sigmaY: 1.0),
                    child: Container(),
                  ),
                ),
              ),
            ),
          ),
          Positioned.fill(
            child: Align(
              alignment: Alignment.bottomLeft,
              child: Container(
                margin: EdgeInsets.only(bottom: 12, left: 16),
                child: Wrap(
                  direction: Axis.vertical,
                  children: [
                    Text(
                      "$breathTime MIN",
                      style: GoogleFonts.funnelDisplay(
                        fontWeight: FontWeight.w600,
                        fontSize: 12,
                        height: 20 / 12,
                        letterSpacing: -0.5,
                        color: Colors.white.withOpacity(0.64),
                      ),
                    ),
                    SizedBox(height: 4),
                    Text(
                      "SLEEP",
                      style: GoogleFonts.funnelDisplay(
                        fontWeight: FontWeight.w600,
                        fontSize: 12,
                        height: 20 / 12,
                        letterSpacing: -0.5,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
