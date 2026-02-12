import 'dart:ui' as ui;

import 'package:ai_meditation/core/ui/tab_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:signals_flutter/signals_flutter.dart';

import '../../../../core/di/injection_container.dart';
import '../../../../core/ui/concave_circle_button.dart';
import '../../domain/entities/meditation_history_item.dart';
import '../controllers/history_controller.dart';

class HistoryPage extends StatefulWidget {
  const HistoryPage({super.key});

  @override
  State<HistoryPage> createState() => _HistoryPageState();
}

class _HistoryPageState extends State<HistoryPage> {
  late final HistoryController _meditationsController;

  int _tabIndex = 0;

  static const _meditationImages = [
    'assets/images/morning_meditation.png',
    'assets/images/evening_meditation.png',
  ];

  final _breathingItems = <_BreathingHistoryUiItem>[];

  @override
  void initState() {
    super.initState();
    _meditationsController = getIt<HistoryController>()..load();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffF6F7FA),
      body: SafeArea(
        bottom: false,
        child: Stack(
          children: [
            Positioned.fill(
              child: Image.asset(
                "assets/images/home_bg.png",
                fit: BoxFit.cover,
              ),
            ),

            Column(
              children: [
                const SizedBox(height: 16),
                _HistoryHeader(
                  title: 'History',
                  onClose: () => Navigator.of(context).maybePop(),
                  onLike: () {},
                  onRepeat: () {},
                ),
                const SizedBox(height: 16),

                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 0),
                    child: _HistoryGlassBody(
                      tabIndex: _tabIndex,
                      onTabChanged: (i) => setState(() => _tabIndex = i),
                      meditationsController: _meditationsController,
                      meditationImages: _meditationImages,
                      breathingItems: _breathingItems,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _HistoryGlassBody extends StatelessWidget {
  const _HistoryGlassBody({
    required this.tabIndex,
    required this.onTabChanged,
    required this.meditationsController,
    required this.meditationImages,
    required this.breathingItems,
  });

  final int tabIndex;
  final ValueChanged<int> onTabChanged;

  final HistoryController meditationsController;
  final List<String> meditationImages;
  final List<_BreathingHistoryUiItem> breathingItems;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 0),
      padding: const EdgeInsets.only(top: 16),
      decoration: BoxDecoration(
        color: const Color.fromRGBO(255, 255, 255, 0.48),
        borderRadius: BorderRadius.circular(40),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(40),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(40),
            gradient: const LinearGradient(
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
              Positioned.fill(
                child: Padding(
                  padding: const EdgeInsets.all(2),
                  child: Image.asset(
                    "assets/images/home_bg.png",
                    fit: BoxFit.cover,
                    opacity: const AlwaysStoppedAnimation(.68),
                  ),
                ),
              ),

              Positioned.fill(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Expanded(
                            child: MyTabBarFill(
                              selectedIndex: tabIndex,
                              tabs: [
                                TabItem(title: 'Meditations'),
                                TabItem(title: 'Breathing'),
                              ],
                              onTap: onTabChanged,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 16),

                      Expanded(
                        child: IndexedStack(
                          index: tabIndex,
                          children: [
                            // Meditations
                            Watch((context) {
                              final items = meditationsController.items.value;

                              if (items.isEmpty) {
                                return const Center(
                                  child: Text('No meditations yet.'),
                                );
                              }

                              return ListView.separated(
                                physics: const BouncingScrollPhysics(),
                                padding: const EdgeInsets.only(bottom: 24),
                                itemCount: items.length,
                                separatorBuilder: (_, __) =>
                                    const SizedBox(height: 18),
                                itemBuilder: (context, index) {
                                  final item = items[index];
                                  final image =
                                      meditationImages[index %
                                          meditationImages.length];

                                  return _MeditationCard(
                                    item: item,
                                    imageAsset: image,
                                  );
                                },
                              );
                            }),

                            // Breathing
                            Builder(
                              builder: (context) {
                                if (breathingItems.isEmpty) {
                                  return const Center(
                                    child: Text('No breathing history yet.'),
                                  );
                                }

                                return ListView.separated(
                                  physics: const BouncingScrollPhysics(),
                                  padding: const EdgeInsets.only(bottom: 24),
                                  itemCount: breathingItems.length,
                                  separatorBuilder: (_, __) =>
                                      const SizedBox(height: 18),
                                  itemBuilder: (context, index) {
                                    final item = breathingItems[index];
                                    return _BreathingCard(
                                      item: item,
                                      imageAsset:
                                          'assets/images/daily_routine.svg',
                                      color: const Color.fromRGBO(
                                        119,
                                        201,
                                        126,
                                        0.16,
                                      ),
                                      durationLabel:
                                          '${item.durationMinutes} min',
                                    );
                                  },
                                );
                              },
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _MeditationCard extends StatelessWidget {
  const _MeditationCard({
    required this.item,
    required this.imageAsset,
    this.onDelete,
  });

  final MeditationHistoryItem item;
  final String imageAsset;
  final VoidCallback? onDelete;

  @override
  Widget build(BuildContext context) {
    final dateText =
        '${item.createdAt.year.toString().padLeft(4, '0')}-'
        '${item.createdAt.month.toString().padLeft(2, '0')}-'
        '${item.createdAt.day.toString().padLeft(2, '0')}';

    return Column(
      children: [
        Container(
          padding: const EdgeInsets.all(4),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(20),
          ),
          child: Stack(
            children: [
              // Чтобы контент не залезал под иконку справа сверху
              Padding(
                padding: const EdgeInsets.only(right: 28),
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
                                  stops: const [0.0, 1.0],
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
                          Text(
                            '${item.durationMinutes} minutes'.toUpperCase(),
                            style: GoogleFonts.funnelDisplay(
                              fontSize: 16,
                              height: 24 / 16,
                              letterSpacing: -0.5,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            'Take a quick meditation break',
                            style: GoogleFonts.funnelDisplay(
                              fontSize: 14,
                              height: 20 / 14,
                              color: const Color(0xffAAAEBA),
                              letterSpacing: -0.5,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Container(
                            padding: const EdgeInsets.only(
                              left: 8,
                              right: 8,
                              top: 3,
                              bottom: 3,
                            ),
                            decoration: const BoxDecoration(
                              color: Color.fromRGBO(119, 201, 126, 0.08),
                              borderRadius: BorderRadius.all(
                                Radius.circular(100),
                              ),
                            ),
                            child: Wrap(
                              direction: Axis.horizontal,
                              children: [
                                SvgPicture.asset("assets/images/mat.svg"),
                                const SizedBox(width: 6),
                                Text(
                                  "Daily Routine".toUpperCase(),
                                  style: GoogleFonts.funnelDisplay(
                                    fontSize: 14,
                                    height: 20 / 14,
                                    color: const Color.fromRGBO(
                                      119,
                                      201,
                                      126,
                                      1,
                                    ),
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

              Positioned(
                top: 0,
                right: 0,
                child: Material(
                  color: Colors.transparent,
                  child: InkWell(
                    borderRadius: BorderRadius.circular(12),
                    onTap: onDelete,
                    child: Padding(
                      padding: const EdgeInsets.all(6),
                      child: SvgPicture.asset(
                        'assets/images/delete.svg',
                        width: 32,
                        height: 32,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class _BreathingHistoryUiItem {
  final String title;
  final int durationMinutes;
  final int inhaleSeconds;
  final int exhaleSeconds;
  final String? moodLabel;

  _BreathingHistoryUiItem({
    required this.title,
    required this.durationMinutes,
    required this.inhaleSeconds,
    required this.exhaleSeconds,
    this.moodLabel,
  });
}

class _BreathingCard extends StatelessWidget {
  const _BreathingCard({
    required this.item,
    required this.imageAsset,
    required this.color,
    required this.durationLabel,
  });

  final _BreathingHistoryUiItem item;
  final String imageAsset;
  final Color color;
  final String durationLabel;

  @override
  Widget build(BuildContext context) {
    final imageBackground = Container(
      width: 88,
      height: 88,
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(18),
      ),
      child: Center(child: SvgPicture.asset(imageAsset, width: 40)),
    );

    return Column(
      children: [
        Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(20),
          ),
          child: Row(
            children: [
              imageBackground,
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '${item.title} • $durationLabel',
                      style: GoogleFonts.funnelDisplay(
                        fontSize: 16,
                        height: 24 / 16,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      item.moodLabel == null
                          ? 'Calm your mind and body'
                          : 'Mood: ${item.moodLabel}',
                      style: GoogleFonts.funnelDisplay(
                        fontSize: 14,
                        height: 20 / 14,
                        color: const Color(0xffAAAEBA),
                        letterSpacing: -0.5,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    const SizedBox(height: 4),
                    RichText(
                      text: TextSpan(
                        text: 'Inhale ',
                        style: GoogleFonts.funnelDisplay(
                          fontSize: 14,
                          height: 20 / 14,
                          color: const Color(0xffAAAEBA),
                          letterSpacing: -0.5,
                          fontWeight: FontWeight.w400,
                        ),
                        children: [
                          TextSpan(
                            text: '${item.inhaleSeconds} sec. ',
                            style: GoogleFonts.funnelDisplay(
                              fontSize: 14,
                              height: 20 / 14,
                              color: Colors.black,
                              letterSpacing: -0.5,
                              fontWeight: FontWeight.w400,
                            ),
                            children: [
                              TextSpan(
                                text: 'Exhale',
                                style: GoogleFonts.funnelDisplay(
                                  fontSize: 14,
                                  height: 20 / 14,
                                  color: const Color(0xffAAAEBA),
                                  letterSpacing: -0.5,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                              TextSpan(
                                text: ' ${item.exhaleSeconds} sec.',
                                style: GoogleFonts.funnelDisplay(
                                  fontSize: 14,
                                  height: 20 / 14,
                                  color: Colors.black,
                                  letterSpacing: -0.5,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                            ],
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

class _HistoryHeader extends StatelessWidget {
  const _HistoryHeader({
    required this.title,
    required this.onClose,
    required this.onLike,
    required this.onRepeat,
  });

  final String title;
  final VoidCallback onClose;
  final VoidCallback onLike;
  final VoidCallback onRepeat;

  @override
  Widget build(BuildContext context) => SizedBox(
    height: 58,
    child: Stack(
      children: [
        Align(
          alignment: Alignment.topCenter,
          child: Padding(
            padding: const EdgeInsets.only(top: 24),
            child: Text(
              title.toUpperCase(),
              style: GoogleFonts.funnelDisplay(
                fontSize: 16,
                height: 24 / 16,
                fontWeight: FontWeight.w600,
                letterSpacing: -0.5,
                color: Colors.black,
              ),
            ),
          ),
        ),
        Positioned(
          top: 18,
          right: 23,
          child: Wrap(
            direction: Axis.horizontal,
            children: [
              ConcaveCircleButton(
                onPressed: onLike,
                iconColor: Colors.grey,
                svgAssetPath: 'assets/images/like.svg',
                size: 40,
                iconSize: 20,
              ),
            ],
          ),
        ),
      ],
    ),
  );
}
