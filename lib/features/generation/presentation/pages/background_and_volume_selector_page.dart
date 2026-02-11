import 'package:ai_meditation/core/ui/concave_circle_button.dart';
import 'package:ai_meditation/core/ui/slide_to_start.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';

class BackgroundAndVolumeSelectorPage extends StatelessWidget {
  const BackgroundAndVolumeSelectorPage({
    required this.durationMinutes,
    required this.onClose,
    required this.onStart,
  });

  final int durationMinutes;
  final VoidCallback onClose;
  final VoidCallback onStart;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Stack(
        children: [
          Positioned.fill(
            child: Image.asset(
              "assets/images/volume_selector_bg.png",
              fit: BoxFit.cover,
            ),
          ),
          Positioned.fill(
            child: Stack(
              children: [
                Positioned(
                  child: Align(
                    alignment: Alignment.topCenter,
                    child: Container(
                      height: 112,
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          begin: AlignmentGeometry.topCenter,
                          end: AlignmentGeometry.bottomCenter,
                          colors: [
                            const Color(0xffF3F4F8),
                            const Color(0xffF3F4F8).withAlpha(0),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                Positioned.fill(
                  child: Column(
                    children: [
                      SizedBox(
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
                            Positioned(
                              child: Align(
                                alignment: Alignment.topCenter,
                                child: Padding(
                                  padding: const EdgeInsets.only(top: 8),
                                  child: SvgPicture.asset(
                                    'assets/images/grabber.svg',
                                  ),
                                ),
                              ),
                            ),
                            Positioned(
                              child: Align(
                                alignment: Alignment.topCenter,
                                child: Padding(
                                  padding: const EdgeInsets.only(top: 24),
                                  child: Text(
                                    'Background sounds'.toUpperCase(),
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

                      const SizedBox(height: 15),
                      Column(
                        children: [
                          Column(
                            children: [
                              Row(
                                children: [
                                  Expanded(
                                    child: Column(
                                      children: [
                                        Image.asset(
                                          "assets/images/none_img.png",
                                        ),
                                        SizedBox(height: 4),
                                        Row(
                                          children: [
                                            Expanded(
                                              child: Text(
                                                "None",
                                                textAlign: TextAlign.center,
                                                style:
                                                    GoogleFonts.funnelDisplay(
                                                      fontWeight:
                                                          FontWeight.w500,
                                                      fontSize: 14,
                                                      letterSpacing: -0.5,
                                                      height: 20 / 14,
                                                    ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                  SizedBox(width: 12),
                                  Expanded(
                                    child: Column(
                                      children: [
                                        Image.asset(
                                          "assets/images/nature_img.png",
                                        ),
                                        SizedBox(height: 4),
                                        Row(
                                          children: [
                                            Expanded(
                                              child: Text(
                                                "Nature",
                                                textAlign: TextAlign.center,
                                                style:
                                                    GoogleFonts.funnelDisplay(
                                                      fontWeight:
                                                          FontWeight.w500,
                                                      fontSize: 14,
                                                      letterSpacing: -0.5,
                                                      height: 20 / 14,
                                                    ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(height: 12),
                              Row(
                                children: [
                                  Expanded(
                                    child: Column(
                                      children: [
                                        Image.asset(
                                          "assets/images/ambient_img.png",
                                        ),
                                        SizedBox(height: 4),
                                        Row(
                                          children: [
                                            Expanded(
                                              child: Text(
                                                "Ambient music",
                                                textAlign: TextAlign.center,
                                                style:
                                                    GoogleFonts.funnelDisplay(
                                                      fontWeight:
                                                          FontWeight.w500,
                                                      fontSize: 14,
                                                      letterSpacing: -0.5,
                                                      height: 20 / 14,
                                                    ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                  SizedBox(width: 12),
                                  Expanded(
                                    child: Column(
                                      children: [
                                        Image.asset(
                                          "assets/images/forest_img.png",
                                        ),
                                        SizedBox(height: 4),
                                        Row(
                                          children: [
                                            Expanded(
                                              child: Text(
                                                "Rain",
                                                textAlign: TextAlign.center,
                                                style:
                                                    GoogleFonts.funnelDisplay(
                                                      fontWeight:
                                                          FontWeight.w500,
                                                      fontSize: 14,
                                                      letterSpacing: -0.5,
                                                      height: 20 / 14,
                                                    ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ],
                      ),

                      const Spacer(),
                      // Padding(
                      //   padding: const EdgeInsets.symmetric(horizontal: 17),
                      //   child: SafeArea(
                      //     top: false,
                      //     child: SizedBox(
                      //       height: 96,
                      //       child: Center(
                      //         child: SlideToStart(
                      //           enabled: true,
                      //           label: 'START',
                      //           onComplete: () async => onStart(),
                      //         ),
                      //       ),
                      //     ),
                      //   ),
                      // ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
