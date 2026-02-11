import 'dart:ui' as ui;

import 'package:ai_meditation/core/ui/slide_to_start.dart';
import 'package:ai_meditation/features/daily_routine/presentation/pages/daily_routine_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:signals_flutter/signals_flutter.dart';

import '../../../../core/di/injection_container.dart';
import '../../../../core/router/app_router.dart';
import '../../../../core/ui/concave_circle_button.dart';

class StartRoutinePage extends StatefulWidget {
  const StartRoutinePage({super.key});

  @override
  State<StartRoutinePage> createState() => _StartRoutinePageState();
}

class _StartRoutinePageState extends State<StartRoutinePage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) => Scaffold(
    body: Stack(
      children: [
        Positioned.fill(
          child: ClipRRect(
            child: Transform.translate(
              offset: Offset(0, -40),
              child: Image.asset(
                "assets/images/green_bg.png",
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
                            'Daily Routine'.toUpperCase(),
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
              SizedBox(height: 24),
              Image.asset("assets/images/breath_start.png", height: 194.93),
              SizedBox(height: 20),
              Row(
                children: [
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 47),
                      child: Text(
                        "Daily Routine helps you maintain balance throughout the day. Here you can generate a personalised practice — from morning meditation to evening relaxation.",
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
              Spacer(),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),

                child: SlideToStart(
                  enabled: true,
                  onComplete: () async {
                    _showRoutineSheet(context);
                  },
                  label: "Start Session".toUpperCase(),
                ),
              ),
              SizedBox(height: 70),
            ],
          ),
        ),
      ],
    ),
  );
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
          height: MediaQuery.of(context).size.height * 0.88,
          child: const DailyRoutinePage(),
        ),
      ),
    );
  }
}
