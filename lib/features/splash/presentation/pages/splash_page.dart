import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:signals_flutter/signals_flutter.dart';

import '../../../../core/di/injection_container.dart';
import '../../../../shared/widgets/feature_error_widget.dart';
import '../controllers/splash_controller.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  late final SplashController _controller;

  @override
  void initState() {
    super.initState();
    _controller = getIt<SplashController>();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final nextRoute = _controller.resolveNextRoute();
      if (mounted) {
        context.go(nextRoute);
      }
    });
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        body: Center(
          child: Padding(
            padding: const EdgeInsets.all(24),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.spa,
                  size: 72,
                  color: Theme.of(context).colorScheme.primary,
                ),
                const SizedBox(height: 16),
                Text(
                  'AI Meditation',
                  style: Theme.of(context).textTheme.titleLarge,
                ),
                const SizedBox(height: 24),
                SignalBuilder(
                  signal: _controller.isLoading,
                  builder: (context, value, child) => value
                      ? const CircularProgressIndicator()
                      : const SizedBox.shrink(),
                ),
                const SizedBox(height: 16),
                SignalBuilder(
                  signal: _controller.error,
                  builder: (context, value, child) => value == null
                      ? const SizedBox.shrink()
                      : FeatureErrorWidget(
                          error: value,
                        ),
                ),
              ],
            ),
          ),
        ),
      );
}
