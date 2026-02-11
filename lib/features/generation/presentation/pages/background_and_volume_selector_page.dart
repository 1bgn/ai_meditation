import 'package:ai_meditation/core/ui/concave_circle_button.dart';
import 'package:ai_meditation/core/ui/slide_to_start.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';

class GeneratedMeditationSheet extends StatelessWidget {
  const GeneratedMeditationSheet({
    required this.durationMinutes,
    required this.onClose,
    required this.onStart,
  });

  final int durationMinutes;
  final VoidCallback onClose;
  final VoidCallback onStart;

  @override
  Widget build(BuildContext context) {
    final isShortMeditation = durationMinutes <= 5;
    final title = isShortMeditation
        ? 'Take a quick meditation break'
        : 'Take a long meditation break';
    final imagePath = isShortMeditation
        ? 'assets/images/morning_meditation.png'
        : 'assets/images/evening_meditation.png';

    return Container(
      color: Colors.white,
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
                              'Meditation Ready'.toUpperCase(),
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
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 17),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(24),
                    child: SizedBox(
                      height: 189,
                      width: double.infinity,
                      child: Image.asset(imagePath, fit: BoxFit.cover),
                    ),
                  ),
                ),
                const SizedBox(height: 24),
                Text(
                  '$durationMinutes min',
                  style: GoogleFonts.funnelDisplay(
                    fontSize: 24,
                    height: 32 / 24,
                    color: Colors.black,
                    letterSpacing: -0.8,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  title,
                  style: GoogleFonts.funnelDisplay(
                    fontSize: 18,
                    height: 24 / 18,
                    color: Colors.black,
                    letterSpacing: -0.5,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const Spacer(),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 17),
                  child: SafeArea(
                    top: false,
                    child: SizedBox(
                      height: 96,
                      child: Center(
                        child: SlideToStart(
                          enabled: true,
                          label: 'START',
                          onComplete: () async => onStart(),
                        ),
                      ),
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
}
