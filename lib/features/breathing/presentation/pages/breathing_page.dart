import 'package:ai_meditation/core/ui/slide_to_start.dart';
import 'package:ai_meditation/features/breathing/presentation/pages/breathing_congrats.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:signals_flutter/signals_flutter.dart';

import '../../../../core/di/injection_container.dart';
import '../../../../core/router/app_router.dart';
import '../../../../core/ui/concave_circle_button.dart';
import '../../../history/domain/entities/breathing_history_item.dart';
import '../../../history/domain/entities/meditation_history_item.dart';
import '../../../history/presentation/controllers/breathing_history_controller.dart';
import '../../../history/presentation/controllers/history_controller.dart';
import '../../domain/entities/breathing_options.dart';
import '../controllers/breathing_controller.dart';
import 'duration_selection_page.dart';
import 'mood_selection_page.dart';

class BreathingPage extends StatefulWidget {
  const BreathingPage({super.key});

  @override
  State<BreathingPage> createState() => _BreathingPageState();
}

class _BreathingPageState extends State<BreathingPage> {
  late final BreathingController _controller;

  final _breathingHistoryController = getIt<BreathingHistoryController>();
  @override
  void initState() {
    super.initState();
    _controller = getIt<BreathingController>();
  }

  Future<void> _showSelectionSheet(BuildContext context, Widget child) =>
      showModalBottomSheet<void>(
        context: context,
        isScrollControlled: true,
        backgroundColor: Colors.transparent,
        builder: (context) => ClipRRect(
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(32),
            topRight: Radius.circular(32),
          ),
          child: SizedBox(
            height: MediaQuery.of(context).size.height * 0.87,
            child: child,
          ),
        ),
      );

  Future<void> _showCongratsSheet(BuildContext context) =>
      showModalBottomSheet<void>(
        context: context,
        isScrollControlled: true,
        backgroundColor: Colors.transparent,
        builder: (context) => ClipRRect(
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(32),
            topRight: Radius.circular(32),
          ),
          child: SizedBox(
            height: MediaQuery.of(context).size.height * 0.87,
            child: CongratsPage(),
          ),
        ),
      );
  @override
  Widget build(BuildContext context) => Scaffold(
    body: Stack(
      children: [
        Positioned.fill(
          child: ClipRRect(
            child: Transform.translate(
              offset: Offset(0, -40),
              child: Image.asset(
                "assets/images/breathing_exercise_bg.png",
                fit: BoxFit.cover,
              ),
            ),
          ),
        ),
        Positioned(
          child: Align(
            alignment: Alignment.topCenter,
            child: Container(
              height: 112,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: AlignmentGeometry.topCenter,
                  end: AlignmentGeometry.bottomCenter,
                  colors: [Color(0xffF3F4F8), Color(0xffF3F4F8).withAlpha(0)],
                ),
              ),
            ),
          ),
        ),
        Positioned.fill(
          child: Column(
            children: [
              Container(
                decoration: BoxDecoration(),
                height: 58,
                child: Stack(
                  children: [
                    Positioned(
                      top: 18,
                      left: 23,
                      child: ConcaveCircleButton(
                        size: 40,
                        svgAssetPath: 'assets/images/close.svg',
                        onPressed: () {
                          Navigator.pop(context);
                        },
                      ),
                    ),
                    Positioned(
                      child: Align(
                        alignment: Alignment.topCenter,
                        child: Padding(
                          padding: const EdgeInsets.only(top: 8.0),
                          child: SvgPicture.asset("assets/images/grabber.svg"),
                        ),
                      ),
                    ),

                    Positioned(
                      child: Align(
                        alignment: Alignment.topCenter,
                        child: Padding(
                          padding: const EdgeInsets.only(top: 24.0),
                          child: Text(
                            'Breathing Exercise'.toUpperCase(),
                            style: GoogleFonts.funnelDisplay(
                              fontSize: 16,
                              height: 24 / 16,
                              color: Colors.black,
                              letterSpacing: -0.5,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Image.asset(
                "assets/images/breathing_main_img.png",
                height: 189.93,
              ),
              SizedBox(height: 20),
              Row(
                children: [
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 54.25),
                      child: Text(
                        "Fill in the details below to\ngenerate a breathing exercise",
                        textAlign: TextAlign.center,
                        style: GoogleFonts.funnelDisplay(
                          fontSize: 18,
                          height: 24 / 18,
                          color: Colors.black,
                          letterSpacing: -0.5,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 24),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 17),
                  child: Column(
                    children: [
                      Watch(
                        (context) => _BreathingOptionsSection(
                          options: _controller.options.value,
                          onMoodTap: () => _showSelectionSheet(
                            context,
                            const MoodSelectionPage(),
                          ),
                          onDurationTap: () => _showSelectionSheet(
                            context,
                            const BreathingDurationSelectionPage(),
                          ),
                        ),
                      ),
                      Spacer(),

                      const SizedBox(height: 24),
                      SafeArea(
                        bottom: true,
                        child: Watch((context) {
                          return Container(
                            height: 96,
                            child: Center(
                              child: SlideToStart(
                                enabled:
                                    _controller.options.value.mood != null &&
                                    _controller.options.value.durationMinutes !=
                                        null,
                                label: 'START SESSION',
                                onComplete: () async {
                                  final result = await context.push<bool>(AppRoutes.breathingSession);

                                  if (!context.mounted) return;

                                  if (result == true) {
                                    final now = DateTime.now();
                                    final options = _controller.options.value;

                                    await _breathingHistoryController.add(
                                      BreathingHistoryItem(
                                        id: now.microsecondsSinceEpoch.toString(), // простой уникальный id [web:87]
                                        title: 'Breathing session',
                                        durationMinutes: options.durationMinutes!, // enabled гарантирует non-null
                                        inhaleSeconds: 4, // подставь реальные значения твоего упражнения
                                        exhaleSeconds: 6,
                                        moodLabel: options.mood!,
                                        createdAt: now,
                                      ),
                                    );

                                    await _showCongratsSheet(context);
                                  }

                                },
                              ),
                            ),
                          );
                        }),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    ),
  );
}

class _BreathingOptionsSection extends StatelessWidget {
  const _BreathingOptionsSection({
    required this.options,
    required this.onMoodTap,
    required this.onDurationTap,
  });

  final BreathingOptions options;
  final VoidCallback onMoodTap;
  final VoidCallback onDurationTap;

  @override
  Widget build(BuildContext context) => Column(
    children: [
      _BreathingOptionTile(
        svgEnableIconPath: 'assets/images/enable_goal.svg',
        svgDisableIconPath: 'assets/images/disable_goal.svg',
        title: 'Mood Check-in',
        value: options.mood,
        onTap: onMoodTap,
      ),
      const SizedBox(height: 12),
      _BreathingOptionTile(
        svgEnableIconPath: 'assets/images/enable_duration.svg',
        svgDisableIconPath: 'assets/images/disable_duration.svg',
        title: 'Duration',
        value: options.durationMinutes != null
            ? '${options.durationMinutes} min'
            : null,
        onTap: onDurationTap,
      ),
    ],
  );
}

class _BreathingOptionTile extends StatelessWidget {
  const _BreathingOptionTile({
    required this.title,
    required this.value,
    required this.onTap,
    required this.svgEnableIconPath,
    required this.svgDisableIconPath,
  });
  final String svgEnableIconPath;
  final String svgDisableIconPath;
  final String title;
  final String? value;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) => InkWell(
    onTap: onTap,
    child: Container(
      padding: EdgeInsets.only(left: 8, top: 8, bottom: 8, right: 24),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(100),
      ),
      child: Row(
        children: [
          value != null
              ? SvgPicture.asset(svgEnableIconPath)
              : SvgPicture.asset(svgDisableIconPath),
          SizedBox(width: 12),

          value != null
              ? Expanded(
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Text(
                            title,
                            style: GoogleFonts.funnelDisplay(
                              fontSize: 13,
                              height: 18 / 13,
                              color: Color(0xffAAAEBA),
                              letterSpacing: -0.5,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          Text(
                            value!,
                            style: GoogleFonts.funnelDisplay(
                              fontSize: 16,
                              height: 24 / 16,
                              color: Colors.black,
                              letterSpacing: -0.5,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                )
              : Text(
                  title,
                  style: GoogleFonts.funnelDisplay(
                    fontSize: 16,
                    height: 24 / 16,
                    color: Color(0xff90939F),
                    letterSpacing: -0.5,
                    fontWeight: FontWeight.w400,
                  ),
                ),
          Spacer(),
          SvgPicture.asset("assets/images/right-arrow.svg"),
        ],
      ),
    ),
  );

  // ListTile(
  // onTap: onTap,
  // title: Text(title),
  // subtitle: Text(value),
  // trailing: const Icon(Icons.chevron_right),
  // shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
  // tileColor: Theme.of(context).colorScheme.surfaceContainerHighest,
  // )
}
