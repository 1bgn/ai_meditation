import 'dart:ui' as ui;

import 'package:ai_meditation/core/ui/bottom_sheet_util.dart';
import 'package:ai_meditation/features/generation/domain/entities/generation_options.dart';
import 'package:ai_meditation/features/generation/presentation/pages/generation_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:signals_flutter/signals_flutter.dart';

import '../../../../core/di/injection_container.dart';
import '../../../../core/router/app_router.dart';
import '../../../../core/ui/concave_circle_button.dart';
import '../../../../core/ui/slide_to_start.dart';
import '../../domain/entities/daily_routine_activity.dart';
import '../controllers/daily_routine_controller.dart';
import '../models/routine_meditation_args.dart';
import '../../../../features/breathing/presentation/controllers/breathing_controller.dart';

class DailyRoutinePage extends StatefulWidget {
  const DailyRoutinePage({super.key});

  @override
  State<DailyRoutinePage> createState() => _DailyRoutinePageState();
}

class _DailyRoutinePageState extends State<DailyRoutinePage> {
  late final DailyRoutineController _controller;

  static const _sectionImages = [
    'assets/images/morning_meditation.png',
    'assets/images/daily_routine.svg',
    'assets/images/evening_meditation.png',
  ];

  @override
  void initState() {
    super.initState();
    _controller = getIt<DailyRoutineController>();
  }

  void _showBottomSheet(BuildContext context, Widget child) {
    showMyBootomSheet(
      context,
      height: MediaQuery.of(context).size.height * 0.9,
      child: child,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffF6F7FA),
      body: SafeArea(
        bottom: false,
        child: Column(
          children: [
            const SizedBox(height: 16),
            _RoutineHeader(onClose: () => Navigator.of(context).maybePop()),
            const SizedBox(height: 24),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Watch((context) {
                  final items = _controller.routineItems.value;
                  if (items.isEmpty) {
                    return const Center(child: CircularProgressIndicator());
                  }
                  return ListView.separated(
                    physics: const BouncingScrollPhysics(),
                    padding: EdgeInsets.zero,
                    itemCount: items.length,
                    separatorBuilder: (_, __) => const SizedBox(height: 18),
                    itemBuilder: (context, index) {
                      final item = items[index];
                      final image = _sectionImages[index];
                      return InkWell(
                        borderRadius: BorderRadius.circular(20),
                        onTap: () => _onCardTap(item),
                        child: item is DailyRoutineBreathing
                            ? _BreathingCard(
                                item: item,
                                imageAsset: image,
                                color: const Color.fromRGBO(
                                  119,
                                  201,
                                  126,
                                  0.16,
                                ),
                                durationLabel: '${item.durationMinutes} min',
                              )
                            : _MeditationCard(
                                item: item as DailyRoutineMeditation,
                                imageAsset: image,
                              ),
                      );
                    },
                  );
                }),
              ),
            ),
            const SizedBox(height: 6),

            Container(
              decoration: BoxDecoration(
                color: Color(0xffF6F7FA).withOpacity(0.92),
                border: Border.all(color: Colors.white, width: 1),
                borderRadius: BorderRadius.all(Radius.circular(24)),
              ),
              child: Column(
                children: [
                  const SizedBox(height: 16),

                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: SlideToStart(
                      label: 'START',
                      enabled: true,
                      onComplete: () async {
                        await _controller.completeRoutine(
                          nextDay: DateTime.now().add(const Duration(days: 1)),
                        );
                        if (!mounted) return;
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('Daily routine saved to history'),
                          ),
                        );
                      },
                    ),
                  ),
                  const SizedBox(height: 16),
                  TextButton(
                    onPressed: () {},
                    child: Text(
                      'Mark as done'.toUpperCase(),
                      style: GoogleFonts.funnelDisplay(
                        letterSpacing: -1,
                        fontWeight: FontWeight.w600,
                        color: Colors.black,
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _onCardTap(DailyRoutineActivity activity) {
    if (activity is DailyRoutineMeditation) {
      final presets = GenerationOptions(
        goal: activity.goal,
        durationMinutes: activity.durationMinutes,
        voiceStyle: activity.voiceStyle,
        backgroundSound: activity.backgroundSound,
      );

      _showBottomSheet(
        context,
        GenerationPage(
          presets: presets,
        ), // presets применятся, но сохраняться не должны
      );
      return;
    }

    if (activity is DailyRoutineBreathing) {
      final breathingController = getIt<BreathingController>();
      breathingController.updateMood(activity.badgeText);
      breathingController.updateDuration(activity.durationMinutes);
      context.push(AppRoutes.breathingSession);
    }
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
        _DailyRoutineHeader(title: item.title),
        const SizedBox(height: 12),
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

class _BreathingCard extends StatelessWidget {
  const _BreathingCard({
    required this.item,
    required this.imageAsset,
    required this.color,
    required this.durationLabel,
  });

  final DailyRoutineBreathing item;
  final String imageAsset;
  final Color color;
  final String durationLabel;

  @override
  Widget build(BuildContext context) {
    final imageBackground = Container(
      width: 88,
      height: 88,
      decoration: BoxDecoration(
        color: Color.fromRGBO(119, 201, 126, 0.16),

        borderRadius: BorderRadius.circular(18),
      ),
      child: Center(child: SvgPicture.asset(imageAsset, width: 40)),
    );

    return Column(
      children: [
        _DailyRoutineHeader(title: item.title),
        const SizedBox(height: 12),
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
                      item.title,
                      style: GoogleFonts.funnelDisplay(
                        fontSize: 16,
                        height: 24 / 16,
                        fontWeight: FontWeight.w700,
                      ),
                    ),

                    const SizedBox(height: 4),

                    Text(
                      "Calm your mind and body",
                      style: GoogleFonts.funnelDisplay(
                        fontSize: 14,
                        height: 20 / 14,
                        color: Color(0xffAAAEBA),
                        letterSpacing: -0.5,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    const SizedBox(height: 4),
                    RichText(
                      text: TextSpan(
                        text: "Inhale ",
                        style: GoogleFonts.funnelDisplay(
                          fontSize: 14,
                          height: 20 / 14,
                          color: Color(0xffAAAEBA),
                          letterSpacing: -0.5,
                          fontWeight: FontWeight.w400,
                        ),
                        children: [
                          TextSpan(
                            text: "4 sec. ",
                            style: GoogleFonts.funnelDisplay(
                              fontSize: 14,
                              height: 20 / 14,
                              color: Colors.black,
                              letterSpacing: -0.5,
                              fontWeight: FontWeight.w400,
                            ),
                            children: [
                              TextSpan(
                                text: "Exhale",
                                style: GoogleFonts.funnelDisplay(
                                  fontSize: 14,
                                  height: 20 / 14,
                                  color: Color(0xffAAAEBA),
                                  letterSpacing: -0.5,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                              TextSpan(
                                text: " 6 sec.",
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

class _RoutineHeader extends StatelessWidget {
  const _RoutineHeader({required this.onClose});

  final VoidCallback onClose;

  @override
  Widget build(BuildContext context) => SizedBox(
    height: 58,
    child: Stack(
      children: [
        Positioned(
          top: 18,
          left: 23,
          child: ConcaveCircleButton(
            onPressed: onClose,
            svgAssetPath: 'assets/images/close.svg',
          ),
        ),
        Align(
          alignment: Alignment.topCenter,
          child: Padding(
            padding: const EdgeInsets.only(top: 8),
            child: SvgPicture.asset('assets/images/grabber.svg'),
          ),
        ),
        Align(
          alignment: Alignment.topCenter,
          child: Padding(
            padding: const EdgeInsets.only(top: 24),
            child: Text(
              'Routine'.toUpperCase(),
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
            children: [
              ConcaveCircleButton(
                onPressed: onClose,
                svgAssetPath: 'assets/images/like.svg',
                iconSize: 15,
              ),
              SizedBox(width: 8),
              ConcaveCircleButton(
                onPressed: onClose,
                svgAssetPath: 'assets/images/repeat.svg',
                iconSize: 15,
              ),
            ],
            direction: Axis.horizontal,
          ),
        ),
      ],
    ),
  );
}

class _DailyRoutineHeader extends StatelessWidget {
  const _DailyRoutineHeader({required this.title});

  final String title;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 40,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(100),
      ),
      child: Center(
        child: Text(
          title,
          style: GoogleFonts.funnelDisplay(
            fontSize: 16,
            height: 24 / 16,
            letterSpacing: -0.5,
            fontWeight: FontWeight.w700,
          ),
        ),
      ),
    );
  }
}
