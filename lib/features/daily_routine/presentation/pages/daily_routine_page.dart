import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../core/di/injection_container.dart';
import '../../../../core/ui/slide_to_start.dart';
import '../../domain/entities/daily_routine_item.dart';
import '../controllers/daily_routine_controller.dart';

class DailyRoutinePage extends StatefulWidget {
  const DailyRoutinePage({super.key});

  @override
  State<DailyRoutinePage> createState() => _DailyRoutinePageState();
}

class _DailyRoutinePageState extends State<DailyRoutinePage> {
  late final DailyRoutineController _controller;

  static const _sectionTitles = [
    'Morning meditation',
    'Afternoon breathing',
    'Evening relaxation',
  ];

  static const _sectionImages = [
    'assets/images/morning_meditation.png',
    'assets/images/daily_routine.svg',
    'assets/images/evening_meditation.png',
  ];

  @override
  void initState() {
    super.initState();
    _controller = getIt<DailyRoutineController>();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: const Text('ROUTINE'),
        centerTitle: true,
        actions: const [
          Icon(Icons.favorite_border),
          SizedBox(width: 12),
          Icon(Icons.autorenew),
          SizedBox(width: 16),
        ],
      ),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFFF6F7FB), Color(0xFFFFFFFF)],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(16, 16, 16, 24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Expanded(
                  child: ListView.separated(
                    physics: const BouncingScrollPhysics(),
                    padding: EdgeInsets.zero,
                    itemCount: _controller.routineItems.length,
                    separatorBuilder: (_, __) => const SizedBox(height: 18),
                    itemBuilder: (context, index) {
                      final item = _controller.routineItems[index];
                      final image = _sectionImages[index];
                      final title = _sectionTitles[index];
                      if (index == 1) {
                        return _BreathingCard(
                          item: item,
                          imageAsset: image,
                          color: const Color.fromRGBO(119, 201, 126, 0.16),
                          durationLabel: '${item.durationMinutes} min',
                        );
                      }
                      return _MeditationCard(
                        item: item,
                        imageAsset: image,
                        title: title,
                      );
                    },
                  ),
                ),
                const SizedBox(height: 16),
                SlideToStart(
                  label: 'START',
                  onComplete: () async {
                    await _controller.completeRoutine();
                    if (!mounted) return;
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('Daily routine saved to history'),
                      ),
                    );
                  },
                ),
                const SizedBox(height: 16),
                TextButton(
                  onPressed: () {},
                  child:  Text(
                    'Mark as done'.toUpperCase(),
                    style: GoogleFonts.funnelDisplay(
                      letterSpacing: -1,
                      fontWeight: FontWeight.w600,
                      color: Colors.black,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _MeditationCard extends StatelessWidget {
  const _MeditationCard({
    required this.item,
    required this.imageAsset,
    required this.title,
  });

  final DailyRoutineItem item;
  final String imageAsset;
  final String title;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Column(
      children: [
        _DailyRoutineHeader(title: title),
        const SizedBox(height: 12),
        Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(20),
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Stack(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(16),
                    child: Image.asset(
                      imageAsset,
                      width: 88,
                      height: 88,
                      fit: BoxFit.cover,
                    ),
                  ),
                  Positioned.fill(
                    child: Align(
                      alignment: Alignment.bottomCenter,
                      child: Padding(
                        padding: const EdgeInsets.only(bottom: 8),
                        child: Text(
                          '${item.durationMinutes} MIN'.toUpperCase(),
                          style: GoogleFonts.funnelDisplay(
                            fontSize: 14,
                            height: 20 / 14,
                            color: Colors.white,
                            letterSpacing: -0.5,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          '${item.durationMinutes} minutes'.toUpperCase(),
                          style: GoogleFonts.funnelDisplay(
                            fontSize: 16,
                            height: 24 / 16,
                            letterSpacing: -0.5,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 4),
                    Text(
                      item.description,
                      style: GoogleFonts.funnelDisplay(
                        fontSize: 14,
                        height: 20 / 14,
                        color: Color(0xffAAAEBA),
                        letterSpacing: -0.5,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class _BreathingCard extends StatelessWidget {
  const _BreathingCard({
    required this.item,
    required this.imageAsset,
    required this.color,
    required this.durationLabel,
  });

  final DailyRoutineItem item;
  final String imageAsset;
  final Color color;
  final String durationLabel;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final imageBackground = Container(
      width: 88,
      height: 88,
      decoration: BoxDecoration(
        color: Color.fromRGBO(119, 201, 126, 0.16),

        borderRadius: BorderRadius.circular(18),
      ),
      child: Center(child: SvgPicture.asset(imageAsset, width: 40)),
    );

    return Column(
      children: [
        _DailyRoutineHeader(title: item.title),
        const SizedBox(height: 12),
        Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(20),
          ),
          child: Row(
            children: [
              imageBackground,
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "RELAX",
                      style: theme.textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                    ),

                    const SizedBox(height: 4),

                    Text(
                      "Calm your mind and body",
                      style: GoogleFonts.funnelDisplay(
                        fontSize: 14,
                        height: 20 / 14,
                        color: Color(0xffAAAEBA),
                        letterSpacing: -0.5,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    const SizedBox(height: 4),
                    RichText(
                      text: TextSpan(
                        text: "Inhale ",
                        style: GoogleFonts.funnelDisplay(fontSize: 14,height: 20/14,color: Color(0xffAAAEBA),letterSpacing: -0.5,fontWeight: FontWeight.w400),
                        children: [
                          TextSpan(
                            text: "4 sec. ",
                            style: GoogleFonts.funnelDisplay(
                              fontSize: 14,
                              height: 20 / 14,
                              color: Colors.black,
                              letterSpacing: -0.5,
                              fontWeight: FontWeight.w400,
                            ),
                            children: [
                              TextSpan(
                                text: "Exhale",
                                style: GoogleFonts.funnelDisplay(
                                  fontSize: 14,
                                  height: 20 / 14,
                                  color: Color(0xffAAAEBA),
                                  letterSpacing: -0.5,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                              TextSpan(text: " 6 sec.",style: GoogleFonts.funnelDisplay(fontSize: 14,height: 20/14,color: Colors.black,letterSpacing: -0.5,fontWeight: FontWeight.w400),),
                            ],
                          
                         
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class _DailyRoutineHeader extends StatelessWidget {
  final String title;
  const _DailyRoutineHeader({required this.title});
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 40,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(100),
      ),
      child: Center(
        child: Text(
          title,
          style: GoogleFonts.funnelDisplay(
            fontSize: 16,
            height: 24 / 16,
            letterSpacing: -0.5,
            fontWeight: FontWeight.w700,
          ),
        ),
      ),
    );
  }
}
