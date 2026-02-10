import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';

class SlideToStart extends StatefulWidget {
  const SlideToStart({
    super.key,
    required this.onComplete,
    required this.label,
    this.enabled = false,
  });

  final Future<void> Function() onComplete;
  final String label;
  final bool enabled;

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

          final bool isDisabled = !widget.enabled;

          double thumbLeft;
          if (!widget.enabled) {
            thumbLeft = constraints.maxWidth - thumbSize - padding;
          } else {
            thumbLeft = padding + clampedDrag;
          }

          return GestureDetector(
            onHorizontalDragUpdate: isDisabled
                ? null
                : (details) {
                    setState(() {
                      _dragX = (_dragX + details.delta.dx).clamp(0, maxDrag);
                    });
                  },
            onHorizontalDragEnd: isDisabled
                ? null
                : (_) async {
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
                color: isDisabled ? Colors.white : Colors.black,
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
                      color: widget.enabled
                          ? Colors.white
                          : const Color(0xFF90939F), // серый
                    ),
                  ),
                  Positioned(
                    left: thumbLeft,
                    child: Container(
                      width: thumbSize,
                      height: thumbSize,
                      decoration: BoxDecoration(
                        color: widget.enabled ?Color(0xFFF6F7FA)
                            .withAlpha( 92 ):Color(0xffF6F7FA),
                        shape: BoxShape.circle,
                      ),
                      child: Center(
                        child: SizedBox(
                          height: 13,
                          width: 13,
                          child: SvgPicture.asset(
                            "assets/images/right-arrow2.svg",
                        
                            color: widget.enabled
                                ? Colors.white
                                : Colors.black.withOpacity(0.6),
                          ),
                        ),
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
