import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
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
        appBar: AppBar(
          actions: [
            TextButton(
              onPressed: _finish,
              child: const Text('Skip'),
            ),
          ],
        ),
        body: Column(
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
              padding: const EdgeInsets.all(24),
              child: Column(
                children: [
                  SignalBuilder(
                    signal: _controller.pageIndex,
                    builder: (context, value, child) => Row(
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
                                    .withOpacity(0.2),
                            borderRadius: BorderRadius.circular(4),
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                  SignalBuilder(
                    signal: _controller.pageIndex,
                    builder: (context, value, child) => FilledButton(
                      onPressed: value == _controller.pages.length - 1
                          ? _finish
                          : () => _pageController.nextPage(
                                duration: const Duration(milliseconds: 300),
                                curve: Curves.easeOut,
                              ),
                      child: Text(
                        value == _controller.pages.length - 1
                            ? 'Get Started'
                            : 'Next',
                      ),
                    ),
                  ),
                  const SizedBox(height: 8),
                  SignalBuilder(
                    signal: _controller.isLoading,
                    builder: (context, value, child) => value
                        ? const LinearProgressIndicator()
                        : const SizedBox.shrink(),
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
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              _iconFromName(info.iconName),
              size: 72,
              color: Theme.of(context).colorScheme.primary,
            ),
            const SizedBox(height: 24),
            Text(
              info.title,
              style: Theme.of(context).textTheme.titleLarge,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 12),
            Text(
              info.description,
              style: Theme.of(context).textTheme.bodyMedium,
              textAlign: TextAlign.center,
            ),
          ],
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
