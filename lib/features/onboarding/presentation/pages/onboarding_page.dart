import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:signals_flutter/signals_flutter.dart';

import '../../../../core/di/injection_container.dart';
import '../../../../core/router/app_router.dart';
import '../../domain/entities/onboarding_page_info.dart';
import '../controllers/onboarding_controller.dart';

class OnboardingPage extends StatefulWidget {
  const OnboardingPage({super.key});

  @override
  State<OnboardingPage> createState() => _OnboardingPageState();
}

class _OnboardingPageState extends State<OnboardingPage> {
  late final OnboardingController _controller;
  final _pageController = PageController();

  @override
  void initState() {
    super.initState();
    _controller = getIt<OnboardingController>();
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  Future<void> _finish() async {
    await _controller.complete();
    if (mounted) {
      context.go(AppRoutes.home);
    }
  }

  @override
  Widget build(BuildContext context) => Scaffold(
   
        body: Stack(
          children: [
            Positioned.fill(child: Image.asset("assets/images/onboarding_bg.png")),
            Positioned.fill(
              child: Column(
                children: [
                  Expanded(
                    child: PageView.builder(
                      controller: _pageController,
                      itemCount: _controller.pages.length,
                      onPageChanged: _controller.onPageChanged,
                      itemBuilder: (context, index) => _OnboardingCard(
                        info: _controller.pages[index],
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(0),
                    child: Column(
                      children: [
                        Watch(
                          (context) {
                            final value = _controller.pageIndex.value;
                            return Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: List.generate(
                                _controller.pages.length,
                                (index) => AnimatedContainer(
                                  duration: const Duration(milliseconds: 200),
                                  width: value == index ? 20 : 8,
                                  height: 8,
                                  margin: const EdgeInsets.symmetric(horizontal: 4),
                                  decoration: BoxDecoration(
                                    color: value == index
                                        ? Theme.of(context).colorScheme.primary
                                        : Theme.of(context)
                                            .colorScheme
                                            .primary
                                            .withValues(alpha: 0.2),
                                    borderRadius: BorderRadius.circular(4),
                                  ),
                                ),
                              ),
                            );
                          },
                        ),
                        const SizedBox(height: 16),
                        Watch(
                          (context) {
                            final value = _controller.pageIndex.value;
                            return FilledButton(
                              onPressed: value == _controller.pages.length - 1
                                  ? _finish
                                  : () => _pageController.nextPage(
                                        duration:
                                            const Duration(milliseconds: 300),
                                        curve: Curves.easeOut,
                                      ),
                              child: Text(
                                value == _controller.pages.length - 1
                                    ? 'Get Started'
                                    : 'Next',
                              ),
                            );
                          },
                        ),
                        const SizedBox(height: 8),
                        Watch(
                          (context) => _controller.isLoading.value
                              ? const LinearProgressIndicator()
                              : const SizedBox.shrink(),
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

class _OnboardingCard extends StatelessWidget {
  const _OnboardingCard({required this.info});

  final OnboardingPageInfo info;

  @override
  Widget build(BuildContext context) => Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24),
        child: SafeArea(
          child: Column(
            children: [
              SizedBox(height: 55,),
              Image.asset(info.imagePath,width: 256,),
              const SizedBox(height: 24),
              Text(
                info.title,
                style: TextStyle(fontFamily: 'Amstelvar',fontSize: 48,height: 52/48,letterSpacing: -1.5,fontStyle: FontStyle.italic),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 12),
              Text(
                info.description,
                style: GoogleFonts.funnelDisplay(fontSize: 48,height: 52/48,letterSpacing: -1.5,fontWeight: FontWeight.w700),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      );

  IconData _iconFromName(String name) => switch (name) {
        'self_improvement' => Icons.self_improvement,
        'tune' => Icons.tune,
        'calendar_today' => Icons.calendar_today,
        'air' => Icons.air,
        _ => Icons.spa,
      };
}
