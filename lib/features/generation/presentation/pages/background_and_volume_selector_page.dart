import 'package:ai_meditation/core/di/injection_container.dart';
import 'package:ai_meditation/core/ui/concave_circle_button.dart';
import 'package:ai_meditation/core/ui/slide_to_start.dart';
import 'package:ai_meditation/features/generation/presentation/controllers/meditation_player_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';

enum BackgroundSound { none, nature, ambient, rain }

class BackgroundAndVolumeSelectorPage extends StatefulWidget {
  const BackgroundAndVolumeSelectorPage({
    required this.durationMinutes,
    required this.onClose,
    required this.controller,
    required this.onStart,
  });

  final int durationMinutes;
  final VoidCallback onClose;
  final MeditationPlayerController controller;
  final VoidCallback onStart;

  @override
  State<BackgroundAndVolumeSelectorPage> createState() =>
      _BackgroundAndVolumeSelectorPageState();
}

class _BackgroundAndVolumeSelectorPageState
    extends State<BackgroundAndVolumeSelectorPage> {
  final backgroundSoundMap = {
    'Ocean': 'assets/sounds/ocean_sound.wav',
    'Rain': 'assets/sounds/rain_sound.wav',
    'Forest': 'assets/sounds/forest_sound.wav',
    'Nature': 'assets/sounds/nature_sound.wav',
    'Ambient music': 'assets/sounds/ambient_sound.wav',
  };

  late final backgroundSounds = backgroundSoundMap.keys.toList();
  BackgroundSound _selectedSound = BackgroundSound.none;
  double _volume = 0.5;
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
                                onPressed: widget.onClose,
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
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 0),
                          child: Column(
                            children: [
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 17,
                                ),
                                child: Column(
                                  children: [
                                    Row(
                                      children: [
                                        Expanded(
                                          child: GestureDetector(
                                            onTap: () {
                                              setState(() {
                                                _selectedSound =
                                                    BackgroundSound.none;
                                                widget.controller
                                                    .setBackgroundSound("None");
                                                widget.controller
                                                    .stopBackground();
                                              });
                                            },
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
                                                        textAlign:
                                                            TextAlign.center,
                                                        style:
                                                            GoogleFonts.funnelDisplay(
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w500,
                                                              fontSize: 14,
                                                              letterSpacing:
                                                                  -0.5,
                                                              height: 20 / 14,
                                                            ),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                        SizedBox(width: 12),
                                        Expanded(
                                          child: GestureDetector(
                                            onTap: () {
                                              widget.controller
                                                  .setBackgroundSound('Nature');
                                              setState(() {
                                                _selectedSound =
                                                    BackgroundSound.nature;
                                              });
                                            },
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
                                                        textAlign:
                                                            TextAlign.center,
                                                        style:
                                                            GoogleFonts.funnelDisplay(
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w500,
                                                              fontSize: 14,
                                                              letterSpacing:
                                                                  -0.5,
                                                              height: 20 / 14,
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
                                    SizedBox(height: 12),
                                    Row(
                                      children: [
                                        Expanded(
                                          child: GestureDetector(
                                            onTap: () {
                                              setState(() {
                                                _selectedSound =
                                                    BackgroundSound.ambient;
                                                widget.controller
                                                    .setBackgroundSound(
                                                      'Ambient Music',
                                                    );
                                              });
                                            },
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
                                                        "Ambient Music",
                                                        textAlign:
                                                            TextAlign.center,
                                                        style:
                                                            GoogleFonts.funnelDisplay(
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w500,
                                                              fontSize: 14,
                                                              letterSpacing:
                                                                  -0.5,
                                                              height: 20 / 14,
                                                            ),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                        SizedBox(width: 12),
                                        Expanded(
                                          child: GestureDetector(
                                            onTap: () {
                                              setState(() {
                                                _selectedSound =
                                                    BackgroundSound.rain;
                                                widget.controller
                                                    .setBackgroundSound('Rain');
                                              });
                                            },
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
                                                        textAlign:
                                                            TextAlign.center,
                                                        style:
                                                            GoogleFonts.funnelDisplay(
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w500,
                                                              fontSize: 14,
                                                              letterSpacing:
                                                                  -0.5,
                                                              height: 20 / 14,
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
                                  ],
                                ),
                              ),
                              const Spacer(),

                              Container(
                                padding: EdgeInsets.only(top: 24),
                                decoration: BoxDecoration(
                                  color: Colors.white.withValues(),
                                  borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(40),
                                    topRight: Radius.circular(40),
                                  ),
                                  border: Border.all(
                                    color: Colors.white,
                                    width: 1,
                                  ),
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 16,
                                  ),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        'Backgound Volume',
                                        style: GoogleFonts.funnelDisplay(
                                          fontSize: 16,
                                          height: 24 / 16,
                                          color: Colors.black,
                                          letterSpacing: -0.5,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                      const SizedBox(height: 24),
                                      SliderTheme(
                                        data: SliderThemeData(
                                          padding: EdgeInsets.only(),
                                          activeTrackColor: Colors.black,
                                          inactiveTrackColor: const Color(
                                            0xffE0E0E0,
                                          ),
                                          thumbColor: Colors.white,
                                          overlayColor: Colors.black
                                              .withOpacity(0.16),
                                          overlayShape:
                                              const RoundSliderOverlayShape(
                                                overlayRadius:
                                                    14, // <-- размер overlay (по умолчанию 24)
                                              ),
                                          trackHeight: 6,
                                          thumbShape:
                                              const RoundSliderThumbShape(
                                                enabledThumbRadius: 8,
                                              ),
                                        ),
                                        child: Slider(
                                          value: _volume,
                                          min: 0.0,
                                          max: 1.0,

                                          onChanged: (value) {
                                            widget.controller.setVolume(value);
                                            setState(() {
                                              _volume = value;
                                            });
                                          },
                                        ),
                                      ),
                                      SizedBox(height: 24),
                                    ],
                                  ),
                                ),
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
          ),
        ],
      ),
    );
  }
}
