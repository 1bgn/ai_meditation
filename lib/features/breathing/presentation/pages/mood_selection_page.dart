import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:signals_flutter/signals_flutter.dart';

import '../../../../core/di/injection_container.dart';
import '../../../../core/ui/concave_circle_button.dart';
import '../controllers/breathing_controller.dart';

class MoodSelectionPage extends StatelessWidget {
  const MoodSelectionPage({super.key});

  static const _moods = ['Calm', 'Neutral', 'Stressed', 'Anxious'];

  @override
  Widget build(BuildContext context) {
    final controller = getIt<BreathingController>();
    return Scaffold(
      body: Stack(
        children: [
          Positioned.fill(
            child: SizedBox(
              height: 60,
              child: Stack(
                children: [
                  Positioned(
                    top: 18,
                    left: 23,
                    child: ConcaveCircleButton(
                      size: 40,
                      svgAssetPath: 'assets/images/back-arrow.svg',
                      onPressed: () {
                        if (context.mounted) {
                          context.pop();
                        }
                      },
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
                          'Meditation Goal'.toUpperCase(),
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
          ),
          Positioned.fill(
            child: Watch(
              (context) => ListView.separated(
                hitTestBehavior: HitTestBehavior.translucent,
                padding: const EdgeInsets.only(
                  top: 172,
                  left: 17,
                  right: 17,
                  bottom: 24,
                ),
                itemCount: _moods.length,
                separatorBuilder: (context, index) => const SizedBox(height: 12),
                itemBuilder: (context, index) {
                  final mood = _moods[index];
                  final isSelected = controller.options.value.mood == mood;
                  return _SelectionOptionTile(
                    title: mood,
                    isSelected: isSelected,
                    onTap: () {
                      controller.updateMood(mood);
                      if (context.mounted) {
                        context.pop();
                      }
                    },
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _SelectionOptionTile extends StatelessWidget {
  const _SelectionOptionTile({
    required this.title,
    required this.isSelected,
    required this.onTap,
  });

  final String title;
  final bool isSelected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) => InkWell(
    onTap: onTap,
    borderRadius: BorderRadius.circular(100),
    child: Container(
      height: 56,
      padding: const EdgeInsets.symmetric(horizontal: 24),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(100),
      ),
      child: Row(
        children: [
          Expanded(
            child: Text(
              title,
              textAlign: TextAlign.center,
              style: GoogleFonts.funnelDisplay(
                fontSize: 16,
                height: 24 / 16,
                color: Colors.black,
                letterSpacing: -0.5,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          if (isSelected)
            const Icon(
              Icons.check,
              size: 18,
              color: Colors.black,
            ),
        ],
      ),
    ),
  );
}
