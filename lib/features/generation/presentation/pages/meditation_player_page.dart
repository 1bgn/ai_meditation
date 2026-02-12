import 'dart:ui';
import 'dart:ui' as ui;

import 'package:ai_meditation/core/tts/build_tts.dart';
import 'package:ai_meditation/core/ui/liquid_glass_circle_icon_buttons.dart';
import 'package:ai_meditation/features/generation/presentation/pages/background_and_volume_selector_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:just_audio/just_audio.dart';
import 'package:progressive_blur/progressive_blur.dart';
import 'package:signals_flutter/signals_flutter.dart';

import '../../../../core/di/injection_container.dart';
import '../../../../shared/widgets/feature_error_widget.dart';
import '../controllers/meditation_player_controller.dart';

class MeditationPlayerArgs {
  const MeditationPlayerArgs({
    required this.title,
    required this.script,
    required this.durationMinutes,
    required this.voiceStyle,
    required this.backgroundSound,
    required this.buildTTs,
    this.preloadedSource,
  });

  final String title;
  final String script;
  final int durationMinutes;
  final String voiceStyle;
  final String backgroundSound;
  final AudioSource? preloadedSource;
  final BuiltTts buildTTs;
}

class MeditationPlayerPage extends StatefulWidget {
  const MeditationPlayerPage({super.key, required this.args});

  final MeditationPlayerArgs args;

  @override
  State<MeditationPlayerPage> createState() => _MeditationPlayerPageState();
}

class _MeditationPlayerPageState extends State<MeditationPlayerPage> {
  late final MeditationPlayerController _controller;
  Future<bool?> _showBackgroundAndVolumeSelectorSheet(
    BuildContext context, {
    required int durationMinutes,
  }) => showModalBottomSheet<bool>(
    context: context,
    isScrollControlled: true,
    isDismissible: true,
    enableDrag: true,
    backgroundColor: Colors.transparent,
    builder: (sheetContext) => ClipRRect(
      borderRadius: const BorderRadius.only(
        topLeft: Radius.circular(32),
        topRight: Radius.circular(32),
      ),
      child: SizedBox(
        height: MediaQuery.of(context).size.height * 0.88,
        child: BackgroundAndVolumeSelectorPage(
          durationMinutes: durationMinutes,
          controller: _controller,
          onClose: () => Navigator.of(sheetContext).pop(false),
          onStart: () => Navigator.of(sheetContext).pop(true),
        ),
      ),
    ),
  );
  @override
  void initState() {
    super.initState();
    _controller = getIt<MeditationPlayerController>();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _controller.start(
        buildTts: widget.args.buildTTs,
        script: widget.args.script,
        voiceStyle: widget.args.voiceStyle,
        preloadedSource: widget.args.preloadedSource,
        backgroundSound: widget.args.backgroundSound,
      );
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    getIt.resetLazySingleton(instance: _controller);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Scaffold(
        body: Stack(
          children: [
            Positioned.fill(
              child: Image.asset("assets/images/place.jpg", fit: BoxFit.cover),
            ),
            Positioned.fill(
              child: Align(
                alignment: Alignment.bottomCenter,
                child: Container(
                  height: 387,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        Colors.black.withOpacity(1),
                        Colors.black.withOpacity(0.0),
                      ],
                      stops: [0.0, 1.0],
                      begin: Alignment.bottomCenter,
                      end: Alignment.topCenter,
                    ),
                  ),
                  child: ClipRRect(
                    child: BackdropFilter(
                      filter: ui.ImageFilter.blur(sigmaX: .0, sigmaY: 3.0),
                      child: Container(),
                    ),
                  ),
                ),
              ),
            ),

            Positioned.fill(
              child: Align(
                alignment: Alignment.topCenter,
                child: SafeArea(
                  child: Padding(
                    padding: const EdgeInsets.only(
                      top: 16.0,
                      left: 16,
                      right: 16,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        LiquidGlassCircleIconButton(
                          svgAssetIcon: "assets/images/close.svg",
                          onTap: () {
                            context.pop();
                          },
                          radius: 22,
                        ),
                        LiquidGlassCircleIconButton(
                          svgAssetIcon: "assets/images/like.svg",
                          onTap: () {},
                          radius: 22,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),

            Positioned.fill(
              child: Align(
                alignment: Alignment.topCenter,
                child: Padding(
                  padding: const EdgeInsets.only(top: 358),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      LiquidGlassCircleIconButton(
                        svgAssetIcon: "assets/images/white_back_15.svg",
                        onTap: () =>
                            _controller.seekBy(const Duration(seconds: -15)),
                        radius: 22,
                      ),
                      const SizedBox(width: 17),
                      Watch(
                        (context) => LiquidGlassCircleIconButton(
                          onTap: _controller.togglePlayPause,
                          iconSize: 24,
                          svgAssetIcon: "assets/images/white_play.svg",
                          radius: 48,
                        ),
                      ),
                      const SizedBox(width: 17),
                      LiquidGlassCircleIconButton(
                        svgAssetIcon: "assets/images/white_next_15.svg",
                        onTap: () =>
                            _controller.seekBy(const Duration(seconds: 15)),
                        radius: 22,
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Positioned.fill(
              top: 562,
              left: 16,
              right: 16,
              child: Watch((context) {
                return Align(
                  child: SliderTheme(
                    data: SliderThemeData(
                      padding: EdgeInsets.zero,
                      activeTrackColor: Colors.white,
                      inactiveTrackColor: Colors.white.withOpacity(0.08),
                      thumbColor: Colors.white,
                      overlayColor: Colors.black.withOpacity(0.16),
                      overlayShape: const RoundSliderOverlayShape(
                        overlayRadius: 14,
                      ),
                      trackHeight: 6,
                      thumbShape: const RoundSliderThumbShape(
                        enabledThumbRadius: 8,
                      ),
                    ),
                    child: Slider(
                      value: _controller.position.value.inSeconds * 1.0,
                      min: 0.0,
                      max: _controller.trackDuration.value.inSeconds * 1.0,

                      onChanged: (value) {
                        _controller.seek(value.toInt());
                        setState(() {
                          // _volume = value;
                        });
                      },
                    ),
                  ),
                );
              }),
            ),
            Positioned.fill(
              top: 592,
              left: 16,
              right: 16,
              child: Align(
                child: Watch((context) {
                  return Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "${_controller.readTime(_controller.position.value)}",
                        style: GoogleFonts.funnelDisplay(color: Colors.white),
                      ),
                      Text(
                        "${_controller.readTime(_controller.trackDuration.value)}",
                        style: GoogleFonts.funnelDisplay(color: Colors.white),
                      ),
                    ],
                  );
                }),
              ),
            ),
            Positioned.fill(
              child: Align(
                alignment: Alignment.bottomCenter,
                child: SafeArea(
                  child: Padding(
                    padding: const EdgeInsets.only(
                      top: 16.0,
                      left: 16,
                      right: 16,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        LiquidGlassPillButton2(
                          leading: SvgPicture.asset(
                            "assets/images/sound_list.svg",
                          ),
                          onTap: () {
                            _showBackgroundAndVolumeSelectorSheet(
                              context,
                              durationMinutes:
                                  _controller.duration.value.inSeconds,
                            );
                          },
                          child: Watch((context) {
                            return Row(
                              children: [
                                Wrap(
                                  direction: Axis.vertical,
                                  children: [
                                    Text(
                                      "Background sounds",
                                      style: GoogleFonts.funnelDisplay(
                                        fontSize: 12,
                                        letterSpacing: -0.5,
                                        height: 18 / 12,
                                        color: Color.fromRGBO(
                                          255,
                                          255,
                                          215,
                                          0.32,
                                        ),
                                        fontWeight: FontWeight.w400,
                                      ),
                                    ),
                                    Text(
                                      "${_controller.backgroundSound.value}",
                                      style: GoogleFonts.funnelDisplay(
                                        fontSize: 16,
                                        letterSpacing: -0.5,
                                        height: 24 / 16,
                                        color: Colors.white,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            );
                          }),
                        ),
                        LiquidGlassCircleIconButton(
                          svgAssetIcon: "assets/images/white_share.svg",
                          onTap: () {},
                          radius: 22,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _SeekIcon extends StatelessWidget {
  const _SeekIcon({required this.icon, required this.label});

  final IconData icon;
  final String label;

  @override
  Widget build(BuildContext context) => Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Icon(icon),
      Text(label, style: Theme.of(context).textTheme.labelSmall),
    ],
  );
}
