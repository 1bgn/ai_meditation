import 'package:ai_meditation/core/ui/slide_to_start.dart';
import 'package:ai_meditation/core/ui/concave_circle_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:signals_flutter/signals_flutter.dart';

import '../../../../core/di/injection_container.dart';
import '../../../../core/router/app_router.dart';
import '../../../../core/tts/tts_service.dart';
import '../../../../shared/widgets/feature_error_widget.dart';
import '../../domain/entities/generation_options.dart';
import '../controllers/generation_controller.dart';
import 'background_sound_selection_page.dart';
import 'duration_selection_page.dart';
import 'goal_selection_page.dart';
import 'meditation_player_page.dart';
import 'voice_style_selection_page.dart';

class GenerationPage extends StatefulWidget {
  const GenerationPage({super.key});

  @override
  State<GenerationPage> createState() => _GenerationPageState();
}

class _GenerationPageState extends State<GenerationPage> {
  late final GenerationController _controller;
  final _isPreparingAudio = signal(false);

  @override
  void initState() {
    super.initState();
    _controller = getIt<GenerationController>()..load();
  }

  Future<void> _generateAndOpenPlayer(BuildContext context) async {
    final script = await _controller.generate();
    if (!context.mounted || script == null) {
      return;
    }
    final didConfirmStart = await _showGeneratedMeditationSheet(
      context,
      durationMinutes: _controller.options.value.durationMinutes!,
    );
    if (!context.mounted || didConfirmStart != true) {
      return;
    }
    _isPreparingAudio.value = true;
    try {
      final source = await getIt<TtsService>().buildAudioSource(
        script,
        language: _playerLanguage,
        pitch: 1.0,
        rate: 0.6,
        voiceStyle: _controller.options.value.voiceStyle,
      );
      if (!context.mounted) {
        return;
      }
      context.push(
        AppRoutes.player,
        extra: MeditationPlayerArgs(
          title: '${_controller.options.value.goal} Meditation',
          script: script,
          durationMinutes: _controller.options.value.durationMinutes!,
          voiceStyle: _controller.options.value.voiceStyle!,
          backgroundSound: _controller.options.value.backgroundSound!,
          preloadedSource: source,
        ),
      );
    } catch (e) {
      _controller.error.value = e.toString();
    } finally {
      _isPreparingAudio.value = false;
    }
  }

  Future<void> _showSelectionSheet(
    BuildContext context,
    Widget child,
  ) => showModalBottomSheet<void>(
    context: context,
    isScrollControlled: true,
    isDismissible: false,
    enableDrag: true,
    backgroundColor: Colors.transparent,
    builder: (context) => ClipRRect(
      borderRadius: const BorderRadius.only(
        topLeft: Radius.circular(32),
        topRight: Radius.circular(32),
      ),
      child: SizedBox(
        height: MediaQuery.of(context).size.height * 0.88,
        child: child,
      ),
    ),
  );

  Future<bool?> _showGeneratedMeditationSheet(
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
        child: _GeneratedMeditationSheet(
          durationMinutes: durationMinutes,
          onClose: () => Navigator.of(sheetContext).pop(false),
          onStart: () => Navigator.of(sheetContext).pop(true),
        ),
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
                'assets/images/meditation_bg.png',
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
                  colors: [
                    Color(0xffF3F4F8),
                    Color(0xffF3F4F8).withAlpha(0),
                  ],
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
                      child: ConcaveCircleButton(onPressed: (){
                        Navigator.pop(context);
                      },svgAssetPath: "assets/images/close.svg",)),
                    
                    Positioned(
                      child: Align(
                        alignment: Alignment.topCenter,
                        child: Padding(
                          padding: const EdgeInsets.only(top: 8),
                          child: SvgPicture.asset('assets/images/grabber.svg'),
                        ),
                      ),
                    ),
                    Positioned(
                      child: Align(
                        alignment: Alignment.topCenter,
                        child: Padding(
                          padding: const EdgeInsets.only(top: 24),
                          child: Text(
                            'Generate Meditation'.toUpperCase(),
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
                'assets/images/meditaion_main_img.png',
                height: 189.93,
              ),
              const SizedBox(height: 20),
              Row(
                children: [
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 54.25),
                      child: Text(
                        'Fill in the details below to\ngenerate a meditation',
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
              const SizedBox(height: 24),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 17),
                  child: Column(
                    children: [
                      Watch(
                        (context) => _OptionsSection(
                          options: _controller.options.value,
                          onGoalTap: () => _showSelectionSheet(
                            context,
                            const GoalSelectionPage(),
                          ),
                          onDurationTap: () => _showSelectionSheet(
                            context,
                            const GenerationDurationSelectionPage(),
                          ),
                          onVoiceTap: () => _showSelectionSheet(
                            context,
                            const VoiceStyleSelectionPage(),
                          ),
                          onBackgroundTap: () => _showSelectionSheet(
                            context,
                            const BackgroundSoundSelectionPage(),
                          ),
                        ),
                      ),
                      const SizedBox(height: 16),
                      Watch(
                        (context) => _controller.error.value == null
                            ? const SizedBox.shrink()
                            : FeatureErrorWidget(
                                error: _controller.error.value!,
                              ),
                      ),
                      const Spacer(),
                      const SizedBox(height: 24),
                      SafeArea(
                        bottom: true,
                        child: Watch(
                          (context) {
                            final isBusy = _controller.isGenerating.value ||
                                _isPreparingAudio.value;
                            final buttonLabel = _controller.isGenerating.value
                                ? 'GENERATING...'
                                : _isPreparingAudio.value
                                    ? 'PREPARING AUDIO...'
                                    : 'GENERATE';
                            return SizedBox(
                              height: 96,
                              child: Center(
                                child: SlideToStart(
                                  enabled: !isBusy&&_controller.options.value.goal!=null&&_controller.options.value.durationMinutes!=null&&_controller.options.value.voiceStyle!=null&&_controller.options.value.backgroundSound!=null,
                                  label: buttonLabel,
                                  onComplete: () =>
                                      _generateAndOpenPlayer(context),
                                ),
                              ),
                            );
                          },
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
  );
}

const _playerLanguage = 'en-US';

class _OptionsSection extends StatelessWidget {
  const _OptionsSection({
    required this.options,
    required this.onGoalTap,
    required this.onDurationTap,
    required this.onVoiceTap,
    required this.onBackgroundTap,
  });

  final GenerationOptions options;
  final VoidCallback onGoalTap;
  final VoidCallback onDurationTap;
  final VoidCallback onVoiceTap;
  final VoidCallback onBackgroundTap;

  @override
  Widget build(BuildContext context) => Column(
    children: [
      _GenerationOptionTile(
        svgEnableIconPath: 'assets/images/enable_goal.svg',
        svgDisableIconPath: 'assets/images/disable_goal.svg',
        title: 'Goal',
        value: options.goal,
        onTap: onGoalTap,
      ),
      const SizedBox(height: 12),
      _GenerationOptionTile(
        svgEnableIconPath: 'assets/images/enable_duration.svg',
        svgDisableIconPath: 'assets/images/disable_duration.svg',
        title: 'Duration',
        value: options.durationMinutes != null
            ? '${options.durationMinutes} min'
            : null,
        onTap: onDurationTap,
      ),
      const SizedBox(height: 12),
      _GenerationOptionTile(
        svgEnableIconPath: 'assets/images/enable_style.svg',
        svgDisableIconPath: 'assets/images/disable_style.svg',
        title: 'Voice Style',
        value: options.voiceStyle,
        onTap: onVoiceTap,
      ),
      const SizedBox(height: 12),
      _GenerationOptionTile(
        svgEnableIconPath: 'assets/images/enable_sound.svg',
        svgDisableIconPath: 'assets/images/disable_sound.svg',
        title: 'Background Sound',
        value: options.backgroundSound,
        onTap: onBackgroundTap,
      ),
    ],
  );
}

class _GenerationOptionTile extends StatelessWidget {
  const _GenerationOptionTile({
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
      padding: const EdgeInsets.only(left: 8, top: 8, bottom: 8, right: 24),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(100),
      ),
      child: Row(
        children: [
          value != null
              ? SvgPicture.asset(svgEnableIconPath)
              : SvgPicture.asset(svgDisableIconPath),
          const SizedBox(width: 12),
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
                              color: const Color(0xffAAAEBA),
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
                    color: const Color(0xff90939F),
                    letterSpacing: -0.5,
                    fontWeight: FontWeight.w400,
                  ),
                ),
          const Spacer(),
          SvgPicture.asset('assets/images/right-arrow.svg'),
        ],
      ),
    ),
  );
}

class _GeneratedMeditationSheet extends StatelessWidget {
  const _GeneratedMeditationSheet({
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
                            child: SvgPicture.asset('assets/images/grabber.svg'),
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
                      child: Image.asset(
                        imagePath,
                        fit: BoxFit.cover,
                      ),
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
