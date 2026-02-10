import 'package:ai_meditation/core/ui/slide_to_start.dart';
import 'package:cupertino_native/components/button.dart';
import 'package:cupertino_native/style/sf_symbol.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:signals_flutter/signals_flutter.dart';

import '../../../../core/di/injection_container.dart';
import '../../../../core/router/app_router.dart';
import '../../domain/entities/breathing_options.dart';
import '../controllers/breathing_controller.dart';

class BreathingPage extends StatefulWidget {
  const BreathingPage({super.key});

  @override
  State<BreathingPage> createState() => _BreathingPageState();
}

class _BreathingPageState extends State<BreathingPage> {
  late final BreathingController _controller;

  @override
  void initState() {
    super.initState();
    _controller = getIt<BreathingController>();
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
        Positioned(child:  Align(
          alignment: Alignment.topCenter,
          child: Container(
            height: 112,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: AlignmentGeometry.topCenter,
                      end: AlignmentGeometry.bottomCenter,
                      colors: [Color(0xffF3F4F8), Color(0xffF3F4F8).withAlpha(0)],
                    ),
                  ),),
        ),),
        Positioned.fill(
          child: Column(
            children: [
              Container(
                decoration: BoxDecoration(
              
                ),
                height: 58,
                child: Stack(
                  children: [
                    Positioned(
                      top: 18,
                      left: 23,
                      child: CNButton.icon(
                        size: 40,
                        icon: const CNSymbol(
                          'xmark',
                          size: 12,
                          color: Color(0xffAAAEBA),
                        ),
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
              SizedBox(height: 24,),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 17),
                  child: Column(
                                
                    children: [
                      Watch(
                        (context) => _BreathingOptionsSection(
                          options: _controller.options.value,
                        ),
                      ),
                      Spacer(),
                  
                      const SizedBox(height: 24),
                        SafeArea(
                          bottom: true,
                          child: Watch(
                             (context) {
                              return Container(
                                height: 96,
                                child: Center(
                                  child: SlideToStart(
                                    enabled: _controller.options.value.mood!=null && _controller.options.value.durationMinutes!=null,
                                                      label: 'START SESSION',
                                                      onComplete: () async{
                                                        context.push(AppRoutes.breathingSession);
                                                      },
                                                    ),
                                ),
                              );
                            }
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

class _BreathingOptionsSection extends StatelessWidget {
  const _BreathingOptionsSection({required this.options});

  final BreathingOptions options;

  @override
  Widget build(BuildContext context) => Column(
    children: [
      _BreathingOptionTile(
        svgEnableIconPath: 'assets/images/enable_goal.svg',
        svgDisableIconPath: 'assets/images/disable_goal.svg',
        title: 'Mood Check-in',
        value: options.mood,
        // value:null,
        onTap: () => context.push(AppRoutes.breathingMood),
      ),
      const SizedBox(height: 12),
      _BreathingOptionTile(
        svgEnableIconPath: 'assets/images/enable_duration.svg',
        svgDisableIconPath: 'assets/images/disable_duration.svg',
        title: 'Duration',
        value: options.durationMinutes != null
            ? '${options.durationMinutes} min'
            : null,
        onTap: () => context.push(AppRoutes.breathingDuration),
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
