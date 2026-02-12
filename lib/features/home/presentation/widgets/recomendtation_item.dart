import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';

class RecomentationItem extends StatelessWidget {
  final int number;

  const RecomentationItem({super.key, required this.number});

  String get breathImg {
    switch (number) {
      case 1:
        return 'assets/images/breath1.jpg';
      case 2:
        return 'assets/images/breath2.jpg';
      case 3:
        return 'assets/images/breath3.jpg';
      default:
        return 'assets/images/breath1.jpg';
    }
  }

  int get breathTime {
    switch (number) {
      case 1:
        return 3;
      case 2:
        return 5;
      case 3:
        return 10;
      default:
        return 3;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 157,
      margin: EdgeInsets.only(right: 8),
      padding: EdgeInsets.all(4),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(24),
        color: Colors.white,
      ),
      child: Stack(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: Image.asset(
              breathImg,
              width: 149,
              height: 243,
              fit: BoxFit.cover,
            ),
          ),
          Positioned.fill(
            child: Align(
              alignment: Alignment.topCenter,
              child: Container(
                padding: EdgeInsets.symmetric(vertical: 3),
                margin: EdgeInsets.only(top: 8, left: 8, right: 8),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(100),
                  color: Color(0xff11111129).withOpacity(0.16),
                ),
                child: Row(
                  children: [
                    SizedBox(width: 22),
                    SvgPicture.asset("assets/images/breathing_icon.svg"),
                    SizedBox(width: 6),
                    Text(
                      "BREATHING",
                      style: GoogleFonts.funnelDisplay(
                        color: Colors.white,
                        fontSize: 12,
                        height: 15 / 12,
                        letterSpacing: -0.5,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          Positioned.fill(
            child: Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                height: 68,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  gradient: LinearGradient(
                    colors: [
                      Colors.black.withOpacity(0.5),
                      Colors.black.withOpacity(0.0),
                    ],
                    stops: [0.0, 1.0],
                    begin: Alignment.bottomCenter,
                    end: Alignment.topCenter,
                  ),
                ),
                child: ClipRRect(
                  child: BackdropFilter(
                    filter: ui.ImageFilter.blur(sigmaX: 1.0, sigmaY: 1.0),
                    child: Container(),
                  ),
                ),
              ),
            ),
          ),
          Positioned.fill(
            child: Align(
              alignment: Alignment.bottomLeft,
              child: Container(
                margin: EdgeInsets.only(bottom: 12, left: 16),
                child: Wrap(
                  direction: Axis.vertical,
                  children: [
                    Text(
                      "$breathTime MIN",
                      style: GoogleFonts.funnelDisplay(
                        fontWeight: FontWeight.w600,
                        fontSize: 12,
                        height: 20 / 12,
                        letterSpacing: -0.5,
                        color: Colors.white.withOpacity(0.64),
                      ),
                    ),
                    SizedBox(height: 4),
                    Text(
                      "SLEEP",
                      style: GoogleFonts.funnelDisplay(
                        fontWeight: FontWeight.w600,
                        fontSize: 12,
                        height: 20 / 12,
                        letterSpacing: -0.5,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
