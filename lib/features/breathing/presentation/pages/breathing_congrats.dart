import 'dart:ui' as ui;

import 'package:ai_meditation/core/ui/slide_to_start.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:signals_flutter/signals_flutter.dart';

import '../../../../core/di/injection_container.dart';
import '../../../../core/router/app_router.dart';
import '../../../../core/ui/concave_circle_button.dart';
import '../../domain/entities/breathing_options.dart';
import '../controllers/breathing_controller.dart';
import 'duration_selection_page.dart';
import 'mood_selection_page.dart';

class CongratsPage extends StatefulWidget {
  const CongratsPage({super.key});

  @override
  State<CongratsPage> createState() => _CongratsPageState();
}

class _CongratsPageState extends State<CongratsPage> {
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
                        "Congrats!",
                        textAlign: TextAlign.center,
                        style: GoogleFonts.funnelDisplay(
                          fontSize: 32,
                          height: 40 / 32,
                          color: Colors.black,
                          letterSpacing: -1.5,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 48),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(left: 0),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(left: 16),
                            child: Text(
                              "Recommended Sessions",
                              style: GoogleFonts.funnelDisplay(
                                fontWeight: FontWeight.w500,
                                fontSize: 16,
                                height: 24 / 16,
                                letterSpacing: -0.5,
                              ),
                            ),
                          ),
                        ],
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
                                  _RecomentationItem(number: 1),
                                  _RecomentationItem(number: 2),
                                  _RecomentationItem(number: 3),
                                ],
                              ),
                            ),
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
      ],
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
