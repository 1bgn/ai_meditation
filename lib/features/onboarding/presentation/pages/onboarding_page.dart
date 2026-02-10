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
                  SafeArea(
                    top: true,
                    bottom: true,
                    child: Padding(
                      padding: const EdgeInsets.only(
                        left: 16,
                        right: 16,
                        bottom: 16,
                      ),
                      child: Column(
                        children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Watch(
                              (context) {
                                final value = _controller.pageIndex.value;
                                return Container(
                                  padding: const EdgeInsets.all(8),
                                  decoration: BoxDecoration(color: Colors.white,borderRadius: BorderRadius.circular(100)),
                                  child: Row(
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
                                              ? Colors.black
                                              : Color(0xffF6F7FA),
                                          borderRadius: BorderRadius.circular(4),
                                        ),
                                      ),
                                    ),
                                  ),
                                );
                              },
                            ),
                          ],
                        ),
                        const SizedBox(height: 12),
                        Watch(
                          (context) {
                            final value = _controller.pageIndex.value;
                            return _SlideToStart(
                              label: value == _controller.pages.length - 1
                                  ? 'Start now'.toUpperCase()
                                  : 'Next'.toUpperCase(),
                              onComplete: value == _controller.pages.length - 1
                                  ? _finish
                                  : () => _pageController.nextPage(
                                        duration:
                                            const Duration(milliseconds: 300),
                                        curve: Curves.easeOut,
                                      ),
                            );
                          },
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

class _OnboardingCard extends StatelessWidget {
  const _OnboardingCard({required this.info});

  final OnboardingPageInfo info;

  @override
  Widget build(BuildContext context) => Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24),
        child: SafeArea(
          bottom: true,
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

}

class _SlideToStart extends StatefulWidget {
  const _SlideToStart({
    required this.onComplete,
    required this.label,
  });

  final Future<void> Function() onComplete;
  final String label;

  @override
  State<_SlideToStart> createState() => _SlideToStartState();
}

class _SlideToStartState extends State<_SlideToStart> {
  double _dragX = 0;

  @override
  Widget build(BuildContext context) => LayoutBuilder(
        builder: (context, constraints) {
          const height = 64.0;
          const thumbSize = 56.0;
          const padding = 4.0;
          final maxDrag = (constraints.maxWidth - thumbSize - padding * 2)
              .clamp(0, double.infinity)
              .toDouble();
          final clampedDrag = _dragX.clamp(0, maxDrag);
          return GestureDetector(
            onHorizontalDragUpdate: (details) {
              setState(() {
                _dragX = (_dragX + details.delta.dx).clamp(0, maxDrag);
              });
            },
            onHorizontalDragEnd: (_) async {
              final shouldComplete = clampedDrag >= maxDrag * 0.85;
              if (shouldComplete) {
                await widget.onComplete();
              }
              if (!mounted) {
                return;
              }
              setState(() => _dragX = 0);
            },
            child: Container(
              height: height,
              width: double.infinity,
              decoration: BoxDecoration(
                color: Colors.black,
                borderRadius: BorderRadius.circular(height / 2),
              ),
              child: Stack(
                alignment: Alignment.center,
                children: [
                  Text(
                    widget.label,
                    style:  GoogleFonts.funnelDisplay(fontSize: 16,height: 24/16,fontWeight: FontWeight.w700,color: Colors.white),
                  ),
                  Positioned(
                    left: padding + clampedDrag,
                    child: Container(
                      width: thumbSize,
                      height: thumbSize,
                      decoration:  BoxDecoration(
                        color: Color(0xFFF6F7FA).withAlpha(92),
                        shape: BoxShape.circle,
                      ),
                      child:  Icon(
                        Icons.arrow_forward,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      );
}
