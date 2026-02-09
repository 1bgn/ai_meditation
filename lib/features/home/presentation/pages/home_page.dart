import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:signals_flutter/signals_flutter.dart';

import '../../../../core/di/injection_container.dart';
import '../../../../core/router/app_router.dart';
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
              
                const SizedBox(height: 16),
                Watch((context) {
                  final value = _controller.lastMeditationTitle.value;
                  return Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: Theme.of(context).colorScheme.surfaceContainerHighest,
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: Text(
                      value == null
                          ? 'No meditation yet. Try generating one.'
                          : 'Last meditation: $value',
                    ),
                  );
                }),
                const SizedBox(height: 24),
                Text('Quick Actions', style: Theme.of(context).textTheme.titleMedium),
                const SizedBox(height: 12),
                _ActionButton(
                  title: 'Generate Meditation',
                  onPressed: () => context.push(AppRoutes.generation),
                ),
                const SizedBox(height: 12),
                _ActionButton(
                  title: 'Breathing Exercise',
                  onPressed: () => context.push(AppRoutes.breathing),
                ),
                const SizedBox(height: 12),
                _ActionButton(
                  title: 'Daily Routine',
                  onPressed: () => context.push(AppRoutes.dailyRoutine),
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
  );
}

class _ActionButton extends StatelessWidget {
  const _ActionButton({required this.title, required this.onPressed});

  final String title;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) => FilledButton(
    onPressed: onPressed,
    child: Align(alignment: Alignment.centerLeft, child: Text(title)),
  );
}
