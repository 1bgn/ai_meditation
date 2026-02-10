import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class SlideToStart extends StatefulWidget {
  const SlideToStart({
    super.key,
    required this.onComplete,
    required this.label,
  });

  final Future<void> Function() onComplete;
  final String label;

  @override
  State<SlideToStart> createState() => _SlideToStartState();
}

class _SlideToStartState extends State<SlideToStart> {
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
                    style: GoogleFonts.funnelDisplay(
                      fontSize: 16,
                      height: 24 / 16,
                      fontWeight: FontWeight.w700,
                      color: Colors.white,
                    ),
                  ),
                  Positioned(
                    left: padding + clampedDrag,
                    child: Container(
                      width: thumbSize,
                      height: thumbSize,
                      decoration: BoxDecoration(
                        color: Color(0xFFF6F7FA).withAlpha(92),
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(
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
