import 'dart:async';

import 'package:flutter/material.dart';

class ActionSlider extends StatefulWidget {
  const ActionSlider({
    super.key,
    required this.onCompleted,
    this.label = 'START',
  });

  final VoidCallback onCompleted;
  final String label;

  @override
  State<ActionSlider> createState() => _ActionSliderState();
}

class _ActionSliderState extends State<ActionSlider> {
  double _progress = 0;
  bool _isCompleted = false;

  void _onChanged(double value) {
    if (_isCompleted) return;

    setState(() {
      _progress = value;
    });

    if (value >= 0.96) {
      _isCompleted = true;
      widget.onCompleted();
      Timer(const Duration(milliseconds: 500), () {
        if (!mounted) return;
        setState(() {
          _progress = 0;
          _isCompleted = false;
        });
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 60,
      decoration: BoxDecoration(
        color: Colors.black,
        borderRadius: BorderRadius.circular(30),
      ),
      child: Stack(
        alignment: Alignment.center,
        children: [
          SliderTheme(
            data: SliderTheme.of(context).copyWith(
              trackHeight: 60,
              inactiveTrackColor: Colors.white30,
              activeTrackColor: Colors.transparent,
              thumbShape: const RoundSliderThumbShape(enabledThumbRadius: 26),
              thumbColor: Colors.white,
              overlayShape: const RoundSliderOverlayShape(overlayRadius: 0),
              trackShape: const RoundedRectSliderTrackShape(),
            ),
            child: Slider(
              min: 0,
              max: 1,
              value: _progress,
              onChanged: _onChanged,
            ),
          ),
          IgnorePointer(
            child: Text(
              widget.label,
              style: const TextStyle(
                color: Colors.white,
                letterSpacing: 1.4,
                fontWeight: FontWeight.bold,
                fontSize: 16,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
