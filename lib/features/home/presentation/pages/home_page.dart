import 'dart:ui' as ui;

import 'package:ai_meditation/core/ui/bottom_sheet_util.dart';
import 'package:ai_meditation/core/ui/glass_concave_tab_bar.dart';
import 'package:ai_meditation/core/ui/tab_bar.dart';
import 'package:ai_meditation/features/daily_routine/domain/entities/daily_routine_activity.dart';
import 'package:ai_meditation/features/daily_routine/presentation/pages/start_routine_page.dart';
import 'package:ai_meditation/features/generation/domain/entities/generation_options.dart';
import 'package:ai_meditation/features/home/presentation/widgets/action_botton.dart';
import 'package:ai_meditation/features/home/presentation/widgets/home_meditation_card.dart';
import 'package:ai_meditation/features/home/presentation/widgets/recomendtation_item.dart';
import 'package:ai_meditation/features/paywall/presentation/controllers/paywall_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:signals_flutter/signals_flutter.dart';

import '../../../../core/di/injection_container.dart';
import '../../../breathing/presentation/pages/breathing_page.dart';
import '../../../generation/presentation/pages/generation_page.dart';
import '../../../daily_routine/presentation/pages/daily_routine_page.dart';
import '../../../history/domain/entities/meditation_history_item.dart';
import '../../../history/presentation/controllers/history_controller.dart';
import '../controllers/home_controller.dart';
import '../widgets/recommendation_card.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late final HomeController _controller;
  final paymentController = getIt<PaywallController>();
  int _selectedRecommendationTab = 0;
  static const _recommendationPresets = <List<GenerationOptions>>[
    // Tab 0: Sleep
    [
      GenerationOptions(
        goal: 'Calm',
        durationMinutes: 10,
        voiceStyle: 'Warm',
        backgroundSound: 'rain',
      ),
      GenerationOptions(
        goal: 'Calm',
        durationMinutes: 6,
        voiceStyle: 'Soft',
        backgroundSound: 'ambient music',
      ),
      GenerationOptions(
        goal: 'Neutral',
        durationMinutes: 8,
        voiceStyle: 'Warm',
        backgroundSound: 'nature',
      ),
    ],

    // Tab 1: Stress & Anxiety
    [
      GenerationOptions(
        goal: 'Stressed',
        durationMinutes: 5,
        voiceStyle: 'Deep',
        backgroundSound: 'none',
      ),
      GenerationOptions(
        goal: 'Anxious',
        durationMinutes: 8,
        voiceStyle: 'Neutral',
        backgroundSound: 'ambient music',
      ),
      GenerationOptions(
        goal: 'Stressed',
        durationMinutes: 10,
        voiceStyle: 'Deep',
        backgroundSound: 'rain',
      ),
    ],

    // Tab 2: Daily meditation
    [
      GenerationOptions(
        goal: 'Neutral',
        durationMinutes: 5,
        voiceStyle: 'Soft',
        backgroundSound: 'nature',
      ),
      GenerationOptions(
        goal: 'Calm',
        durationMinutes: 7,
        voiceStyle: 'Neutral',
        backgroundSound: 'ambient music',
      ),
      GenerationOptions(
        goal: 'Neutral',
        durationMinutes: 10,
        voiceStyle: 'Warm',
        backgroundSound: 'none',
      ),
    ],
  ];

  @override
  void initState() {
    super.initState();
    _controller = getIt<HomeController>()..load();

     paymentController.initBanner();

  }

  @override
  Widget build(BuildContext context) => Scaffold(
    body: SafeArea(
      child: Stack(
        children: [
          Positioned.fill(
            child: Image.asset("assets/images/home_bg.png", fit: BoxFit.cover),
          ),
          Positioned.fill(
            child: ListView(
              children: [
                SizedBox(height: 32),
                Watch((context)=> (paymentController.bannerAd.value != null)?
              Container(
          height: paymentController.bannerAd.value!.size.height.toDouble(),
    width: paymentController.bannerAd.value!.size.width.toDouble(),
    child: AdWidget(ad: paymentController.bannerAd.value!),
  ):SizedBox(),),
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
                                              child: ActionButton(
                                                title: 'Generate Meditation'
                                                    .toUpperCase(),
                                                position:
                                                    ActionButtonPosition.top,
                                                iconAsset:
                                                    'assets/images/generate_mediation.svg',
                                                onPressed: () async {

                                                  _showBottomSheet(
                                                      context,
                                                      const GenerationPage(),
                                                    );
                                                },
                                              ),
                                            ),
                                          ],
                                        ),
                                        const SizedBox(height: 4),
                                        Row(
                                          children: [
                                            Expanded(
                                              child: ActionButton(
                                                title: 'Breathing Exercise'
                                                    .toUpperCase(),
                                                position:
                                                    ActionButtonPosition.middle,
                                                iconAsset:
                                                    'assets/images/breathing_exercise.svg',
                                                onPressed: () =>
                                                    _showBottomSheet(
                                                      context,
                                                      const BreathingPage(),
                                                    ),
                                              ),
                                            ),
                                          ],
                                        ),
                                        const SizedBox(height: 4),
                                        Row(
                                          children: [
                                            Expanded(
                                              child: ActionButton(
                                                title: 'Daily Routine'
                                                    .toUpperCase(),
                                                position:
                                                    ActionButtonPosition.bottom,
                                                iconAsset:
                                                    'assets/images/daily_routine.svg',
                                                onPressed: () =>
                                                    _showBottomSheet(
                                                      context,
                                                      const StartRoutinePage(),
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
                                        // Текущий item (у тебя он уже создаётся inline — вынесем в переменную)
                                        Builder(
                                          builder: (context) {
                                            final item = DailyRoutineMeditation(
                                              title: "Calm",
                                              backgroundSound: "ambient music",
                                              badgeText: "CSDVCdsvs",
                                              description:
                                                  "Take a quick meditation break",
                                              durationMinutes: 4,
                                              goal: "Calm",
                                              voiceStyle: "Soft",
                                              imageAsset:
                                                  "assets/images/breath1.jpg",
                                            );

                                            return GestureDetector(
                                              behavior: HitTestBehavior.opaque,
                                              onTap: () {
                                                final presets =
                                                    GenerationOptions(
                                                      goal: item.goal,
                                                      durationMinutes:
                                                          item.durationMinutes,
                                                      voiceStyle:
                                                          item.voiceStyle,
                                                      backgroundSound:
                                                          item.backgroundSound,
                                                    );

                                                _showBottomSheet(
                                                  context,
                                                  GenerationPage(
                                                    presets: presets,
                                                  ),
                                                );
                                              },
                                              child: HomeMeditationCard(
                                                item: item,
                                                imageAsset:
                                                    "assets/images/breath1.jpg",
                                              ),
                                            );
                                          },
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
                                        child: MyTabBar(
                                          selectedIndex: 0,
                                          tabs: [
                                            TabItem(title: "Sleep"),
                                            TabItem(title: "Stress & ANXIENTY"),
                                            TabItem(title: "Daily meditation"),
                                          ],
                                          onTap: onSelectRecomendation,
                                        ),
                                      ),
                                      SizedBox(height: 12),
                                      Row(
                                        children: [
                                          Expanded(
                                            child: SingleChildScrollView(
                                              scrollDirection: Axis.horizontal,
                                              child: Row(
                                                children: [
                                                  SizedBox(width: 16),

                                                  ...List.generate(3, (i) {
                                                    final presets =
                                                        _recommendationPresets[_selectedRecommendationTab][i];
                                                    return GestureDetector(
                                                      behavior: HitTestBehavior
                                                          .opaque,
                                                      onTap: () {
                                                        _showBottomSheet(
                                                          context,
                                                          GenerationPage(
                                                            presets: presets,
                                                          ),
                                                        );
                                                      },
                                                      child: RecomentationItem(
                                                        number: i + 1,
                                                      ),
                                                    );
                                                  }),
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
        ],
      ),
    ),
  );
  void onSelectRecomendation(int index) {
    setState(() => _selectedRecommendationTab = index);
  }
}

void _showBottomSheet(BuildContext context, Widget child) {
  showMyBootomSheet(
    context,
    height: MediaQuery.of(context).size.height * 0.9,
    child: child,
  );
}
