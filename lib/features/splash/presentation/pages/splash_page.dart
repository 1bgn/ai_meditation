import 'dart:async';

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

  // можно через setState, но раз у тебя signals — сделаем так
  final _showSecond = signal(false);

  Timer? _timer300ms;

  @override
  void initState() {
    super.initState();
    _controller = getIt<SplashController>();

    _timer300ms = Timer(const Duration(milliseconds: 300), () async {
      _showSecond.value = true;
      await Future.delayed(Duration(milliseconds: 300));
      final nextRoute = _controller.resolveNextRoute();
      if (mounted) context.go(nextRoute);
    });

    // Если хочешь навигацию сразу после build, но с задержкой —
    // лучше делать её после показа splash2 (см. выше) чтобы не было "дерганья". [web:93]
  }

  @override
  void dispose() {
    _timer300ms?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Positioned.fill(child: Image.asset("assets/images/splash_bg.png")),
          Positioned.fill(
            child: Watch(
              (context) => Image.asset(
                _showSecond.value
                    ? "assets/images/splash2.png"
                    : "assets/images/splash1.png",
              ),
            ),
          ),
        ],
      ),
    );
  }
}
