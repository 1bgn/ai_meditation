import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:signals_flutter/signals_flutter.dart';

import '../../../../core/di/injection_container.dart';
import '../../../breathing/presentation/pages/breathing_page.dart';
import '../../../generation/presentation/pages/generation_page.dart';
import '../../../daily_routine/presentation/pages/daily_routine_page.dart';
import '../controllers/home_controller.dart';
import '../widgets/recommendation_card.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late final HomeController _controller;

  @override
  void initState() {
    super.initState();
    _controller = getIt<HomeController>()..load();
  }

  @override
  Widget build(BuildContext context) => Scaffold(
    body: SafeArea(
      child: Stack(
        children: [
          Positioned.fill(child: Image.asset("assets/images/home_bg.png",fit: BoxFit.cover,)),
          Positioned.fill(
            child: ListView(
              children: [
                SizedBox(height: 32),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    RichText(
                      text: TextSpan(
                        text: "Hello, ",
                        style: TextStyle(
                          fontFamily: "Amstelvar",
                          fontSize: 24,
                          height: 32 / 24,
                          letterSpacing: -1.5,
                          fontStyle: FontStyle.italic,
                          color: Colors.black,
                        ),
                        children: [
                          TextSpan(
                            text: "Vitalii",
                            style: GoogleFonts.funnelDisplay(
                              fontSize: 24,
                              height: 32 / 24,
                              letterSpacing: -1.5,
                              fontWeight: FontWeight.w600,
                              color: Colors.black,
                              fontStyle: FontStyle.normal,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 32),
                        child: RichText(
                          textAlign: TextAlign.center,
                          text: TextSpan(
                            text: "How are you ",
                            style: TextStyle(
                              fontFamily: "Amstelvar",
                              fontSize: 48,
                              height: 52 / 48,
                              letterSpacing: -1.5,
                              fontWeight: FontWeight.w400,
                              fontStyle: FontStyle.italic,
                              color: Colors.black,
                               fontVariations: [FontVariation('wght', 300)],
                            ),
                            children: [
                              TextSpan(
                                text: "feeling ",
                                style: GoogleFonts.funnelDisplay(
                                  fontSize:48,
                                  height: 52 / 48,
                                  letterSpacing: -1.5,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.black,
                                  fontStyle: FontStyle.normal,
                                  
                                ),
                                children: [
                                   TextSpan(
                            text: "today?",
                            style: TextStyle(
                              fontFamily: "Amstelvar",
                              fontSize: 48,
                              fontWeight: FontWeight.w400,
                              height: 52 / 48,
                              letterSpacing: -1.5,
                              fontStyle: FontStyle.italic,
                              color: Colors.black,
                                   fontVariations: [FontVariation('wght', 300)],
                            ))
                                ]
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              
                const SizedBox(height:32),
       
                Container(
                  padding: EdgeInsets.only(left: 16,right: 16,top: 16),
                  decoration: BoxDecoration(
                    color: const Color.fromRGBO(255, 255, 255, 0.48),
                    borderRadius: BorderRadius.circular(40),
                  ),
                  child: ClipRRect(
                    child: Container(
                      decoration:  BoxDecoration(
                            borderRadius: BorderRadius.circular(40),
                        gradient: LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: [
                            Color.fromRGBO(255, 255, 255, 0),
                            Color.fromRGBO(255, 255, 255, 1),
                          ],
                        ),
                      ),
                      child: Stack(
                        children: [
                          Stack(children: [Padding(
                            padding: const EdgeInsets.all(2),
                            child: Image.asset("assets/images/home_bg.png",opacity: const AlwaysStoppedAnimation(.68,),
                          ))],),
                          Positioned.fill(
                            child: Column(
                              children: [
                                Row(
                                  children: [
                                    Expanded(
                                      child: _ActionButton(
                                        title: 'Generate Meditation'.toUpperCase(),
                                        position: _ActionButtonPosition.top,
                                        iconAsset: 'assets/images/generate_mediation.svg',
                                        onPressed: () => _showGenerationSheet(context),
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 4),
                                Row(
                                  children: [
                                    Expanded(
                                      child: _ActionButton(
                                        title: 'Breathing Exercise'.toUpperCase(),
                                        position: _ActionButtonPosition.middle,
                                        iconAsset: 'assets/images/breathing_exercise.svg',
                                        onPressed: () => _showBreathingSheet(context),
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 4),
                                Row(
                                  children: [
                                    Expanded(
                                      child: _ActionButton(
                                        title: 'Daily Routine'.toUpperCase(),
                                        position: _ActionButtonPosition.bottom,
                                        iconAsset: 'assets/images/daily_routine.svg',
                                        onPressed: () => _showRoutineSheet(context),
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 24),
                                Text(
                                  'Recommendations',
                                  style: Theme.of(context).textTheme.titleMedium,
                                ),
                                const SizedBox(height: 12),
                                SizedBox(
                                  height: 160,
                                  child: Watch((context) {
                                    final value = _controller.recommendations.value;
                                    return ListView.builder(
                                      scrollDirection: Axis.horizontal,
                                      itemCount: value.length,
                                      itemBuilder: (context, index) =>
                                          RecommendationCard(recommendation: value[index]),
                                    );
                                  }),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    ),
  );
}

enum _ActionButtonPosition { top, middle, bottom }

class _ActionButton extends StatelessWidget {
  const _ActionButton({
    required this.title,
    required this.position,
    required this.onPressed,
    required this.iconAsset,
  });

  final String title;
  final _ActionButtonPosition position;
  final VoidCallback onPressed;
  final String iconAsset;

  @override
  Widget build(BuildContext context) {
    final borderRadius = switch (position) {
      _ActionButtonPosition.top => BorderRadius.only(
        topLeft: const Radius.circular(32),
        topRight: const Radius.circular(32),
        bottomLeft: const Radius.circular(12),
        bottomRight: const Radius.circular(12),
      ),
      _ActionButtonPosition.middle => BorderRadius.circular(12),
      _ActionButtonPosition.bottom => BorderRadius.only(
        bottomLeft: const Radius.circular(32),
        bottomRight: const Radius.circular(32),
        topLeft: const Radius.circular(12),
        topRight: const Radius.circular(12),
      ),
    };

    return FilledButton(
      onPressed: onPressed,
      style: FilledButton.styleFrom(
        shape: RoundedRectangleBorder(borderRadius: borderRadius),
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 26),
      ),
      child: Row(
        children: [
          SvgPicture.asset(
            iconAsset,
            width: 24,
            height: 24,
          ),
          const SizedBox(width: 36.5),
          Expanded(child: Text(title)),
        ],
      ),
    );
  }

}

void _showGenerationSheet(BuildContext context) {
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
        height: MediaQuery.of(context).size.height * 0.9,
        child: const GenerationPage(),
      ),
    ),
  );
}

void _showBreathingSheet(BuildContext context) {
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
        height: MediaQuery.of(context).size.height * 0.9,
        child: const BreathingPage(),
      ),
    ),
  );
}

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
        height: MediaQuery.of(context).size.height * 0.9,
        child: const DailyRoutinePage(),
      ),
    ),
  );
}
