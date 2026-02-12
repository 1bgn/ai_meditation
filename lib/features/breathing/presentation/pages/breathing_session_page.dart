import 'package:ai_meditation/core/ui/concave_circle_button.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:signals_flutter/signals_flutter.dart';

import '../../../../core/di/injection_container.dart';
import '../controllers/breathing_controller.dart';
import '../controllers/breathing_session_controller.dart';

class BreathingSessionPage extends StatefulWidget {
  const BreathingSessionPage({super.key});

  @override
  State<BreathingSessionPage> createState() => _BreathingSessionPageState();
}

class _BreathingSessionPageState extends State<BreathingSessionPage> {
  late final BreathingSessionController _controller;
  late final BreathingController _breathingController;

  String? _mood;
  Duration? _duration;

  @override
  void initState() {
    super.initState();
    _controller = getIt<BreathingSessionController>();
    _breathingController = getIt<BreathingController>();

    _mood = _breathingController.options.value.mood;

    final durationMinutes = _breathingController.options.value.durationMinutes;
    _duration = durationMinutes != null
        ? Duration(minutes: durationMinutes)
        : null;

    _startSession();
  }

  void _startSession() {
    _controller.start(
      mood: _mood,
      duration: _duration,
      onSessionEnd: _showCongrats,
    );
  }

  void _restartSession() {
    _controller.stop();
    _startSession();
  }

  void _showCongrats() {
    if (!mounted) return;
    Navigator.of(context).pop(true);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => Scaffold(
    body: Watch((context) {
      return Stack(
        children: [
          Positioned.fill(
            child: Align(
              child: Image.asset(
                "assets/images/breath_session_img.png",
                fit: BoxFit.cover,
              ),
            ),
          ),
          Positioned.fill(
            child: Align(
              alignment: Alignment.center,
              child: Watch(
                (context) => AnimatedContainer(
                  duration: const Duration(milliseconds: 800),
                  width: _controller.isInhale.value ? 343 : 233,
                  height: _controller.isInhale.value ? 343 : 233,
                  decoration: const BoxDecoration(),
                  child: Image.asset("assets/images/breath_img.png"),
                ),
              ),
            ),
          ),
          Positioned.fill(
            child: Align(
              alignment: Alignment.center,
              child: Image.asset("assets/images/breath_center.png", width: 132),
            ),
          ),
          Positioned.fill(
            child: Align(
              alignment: Alignment.center,
              child: Text(
                _controller.isInhale.value ? "Inhale" : "Exhale",
                style: GoogleFonts.funnelDisplay(
                  fontWeight: FontWeight.w600,
                  color: Colors.white,
                  fontSize: 24,
                  height: 32 / 24,
                  letterSpacing: -1.5,
                ),
              ),
            ),
          ),
          Positioned.fill(
            child: Align(
              alignment: Alignment.topLeft,
              child: SafeArea(
                child: Padding(
                  padding: const EdgeInsets.only(top: 23.65, left: 23.65),
                  child: ConcaveCircleButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    svgAssetPath: "assets/images/close.svg",
                  ),
                ),
              ),
            ),
          ),
          Positioned.fill(
            child: Align(
              alignment: Alignment.bottomLeft,
              child: Padding(
                padding: const EdgeInsets.only(
                  bottom: 48,
                  left: 23.65,
                  right: 23.65,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    ConcaveCircleButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      iconSize: 15,
                      svgAssetPath: "assets/images/volume.svg",
                    ),
                    ConcaveCircleButton(
                      onPressed: _restartSession,
                      iconSize: 15,
                      svgAssetPath: "assets/images/repeat.svg",
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      );
    }),
  );
}
