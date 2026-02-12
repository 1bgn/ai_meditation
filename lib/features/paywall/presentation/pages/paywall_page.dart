import 'dart:ui';
import 'package:ai_meditation/core/ui/slide_to_start.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class PaywallPage extends StatefulWidget {
  const PaywallPage({super.key});

  @override
  State<PaywallPage> createState() => _PaywallPageState();
}

class _PaywallPageState extends State<PaywallPage> {
  int selectedPlan = 1; // 0 weekly, 1 monthly, 2 yearly

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF6F7FA),
      body: LayoutBuilder(
        builder: (context, c) {
          const designW = 375.0;
          final s = c.maxWidth / designW;

          double sp(double v) => v * s;

          return Stack(
            clipBehavior: Clip.none,
            children: [
              // Bg
              Positioned.fill(child: Container(color: const Color(0xFFF6F7FA))),
              Positioned.fill(
                child: Image.asset("assets/images/paywall_bg.png"),
              ),
              // Main content
              Positioned.fill(
                child: Padding(
                  padding: EdgeInsetsGeometry.only(top: 24),
                  child: Column(
                    children: [
                      SizedBox(height: sp(8)),

                      // Top block: image + titles
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: sp(16)),
                        child: Column(
                          children: [
                            SizedBox(height: sp(12)),
                            _ImageCard(
                              size: sp(96),
                              radius: sp(20.7568),
                              assetPath: 'assets/images/removal.png',
                            ),
                            SizedBox(height: sp(16)),
                            RichText(
                              textAlign: TextAlign.center,
                              text: TextSpan(
                                text: "Unlock Full\n",
                                children: [
                                  TextSpan(
                                    text: "AI Meditation Power",
                                    style: GoogleFonts.funnelDisplay(
                                      fontWeight: FontWeight.w600,
                                      fontStyle: FontStyle.normal,
                                    ),
                                  ),
                                ],
                                style: TextStyle(
                                  fontFamily: 'Amstelvar',
                                  fontStyle: FontStyle.italic,
                                  fontWeight: FontWeight.w400,
                                  fontVariations: [FontVariation('wght', 300)],
                                  fontSize: sp(32),
                                  height: 40 / 32,
                                  letterSpacing: sp(-1.5),
                                  color: const Color(0xFF111111),
                                ),
                              ),
                            ),
                            SizedBox(height: sp(8)),
                            Text(
                              'Unlimited guided sessions, personalized AI meditations, track your mindfulness..',
                              textAlign: TextAlign.center,
                              style: GoogleFonts.funnelDisplay(
                                fontWeight: FontWeight.w400,
                                fontSize: sp(16),
                                height: 24 / 16,
                                letterSpacing: sp(-0.5),
                                color: const Color(0xFF7B7E89),
                              ),
                            ),
                          ],
                        ),
                      ),

                      SizedBox(height: sp(16)),

                      // Glass checklist card
                      Padding(
                        padding: EdgeInsets.fromLTRB(sp(16), 0, sp(16), sp(12)),
                        child: Container(
                          width: double.infinity,
                          padding: EdgeInsets.symmetric(
                            horizontal: sp(12),
                            vertical: sp(8),
                          ),
                          decoration: BoxDecoration(
                            color: Colors.white.withOpacity(0.48),
                            borderRadius: BorderRadius.circular(sp(24)),
                          ),
                          child: Column(
                            children: const [
                              _CheckRow(text: 'Personalized Sessions'),
                              _CheckRow(text: 'Sleep & Relaxation'),
                              _CheckRow(text: 'Focus & Energy'),
                              _CheckRow(text: 'Mindfulness Tracking'),
                              _CheckRow(text: 'Nature & Music Sounds'),
                            ],
                          ),
                        ),
                      ),

                      // Bottom sheet (Frame 3 + Frame 79)
                      _BottomSheet(
                        scale: s,
                        selectedPlan: selectedPlan,
                        onSelect: (i) => setState(() => selectedPlan = i),
                        onContinue: () {},
                      ),
                    ],
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}

class _ImageCard extends StatelessWidget {
  const _ImageCard({
    required this.size,
    required this.radius,
    required this.assetPath,
  });

  final double size;
  final double radius;
  final String assetPath;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(radius)),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(radius),
        child: Stack(
          children: [
            Center(child: Image.asset(assetPath, fit: BoxFit.contain)),
          ],
        ),
      ),
    );
  }
}

class _CheckRow extends StatelessWidget {
  const _CheckRow({required this.text});
  final String text;

  @override
  Widget build(BuildContext context) {
    // Размеры “как в макете”, но без внешнего scale — наследуем от текущего текста.
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Row(
        children: [
          Container(
            width: 24,
            height: 24,
            decoration: const BoxDecoration(
              color: Color(0xFF0A0A0A),
              shape: BoxShape.circle,
            ),
            child: const Center(
              child: Icon(Icons.check, size: 16, color: Colors.white),
            ),
          ),
          const SizedBox(width: 12),
          Text(
            text,
            style: GoogleFonts.funnelDisplay(
              fontWeight: FontWeight.w500,
              fontSize: 16,
              height: 24 / 16,
              letterSpacing: -0.5,
              color: Color(0xFF111111),
            ),
          ),
        ],
      ),
    );
  }
}

class _BottomSheet extends StatelessWidget {
  const _BottomSheet({
    required this.scale,
    required this.selectedPlan,
    required this.onSelect,
    required this.onContinue,
  });

  final double scale;
  final int selectedPlan;
  final ValueChanged<int> onSelect;
  final VoidCallback onContinue;

  double sp(double v) => v * scale;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      // высота из макета: 337 + 130 примерно, но тут делаем “как есть”
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.48),
        borderRadius: BorderRadius.vertical(top: Radius.circular(sp(40))),
      ),
      child: Padding(
        padding: EdgeInsets.fromLTRB(sp(16), sp(16), sp(16), sp(16)),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            _PlanTile(
              scale: scale,
              accent: const Color(0xFFCBA7FF),
              label: 'Weekly',
              price: r'$3.99 / week',
              badgeText: '3-day trial',
              badgeBg: const Color(0xFFCBA7FF).withOpacity(0.10),
              badgeFg: const Color(0xFFCBA7FF),
              selected: selectedPlan == 0,
              onTap: () => onSelect(0),
              radioSelectedStyle: false,
            ),
            SizedBox(height: sp(4)),
            _PlanTile(
              scale: scale,
              accent: const Color(0xFF7ACBFF),
              label: 'Monthly',
              price: r'$11.99 / month',
              badgeText: null,
              badgeBg: Colors.transparent,
              badgeFg: Colors.transparent,
              selected: selectedPlan == 1,
              onTap: () => onSelect(1),
              radioSelectedStyle: true, // как в макете: чёрная толстая обводка
            ),
            SizedBox(height: sp(4)),
            _PlanTile(
              scale: scale,
              accent: const Color(0xFF77C97E),
              label: 'Yearly',
              price: r'$49.99 / year',
              badgeText: 'Save 75%',
              badgeBg: const Color(0xFF77C97E),
              badgeFg: Colors.white,
              selected: selectedPlan == 2,
              onTap: () => onSelect(2),
              radioSelectedStyle: false,
            ),
            SizedBox(height: sp(14)),
            SlideToStart(
              onComplete: () async {},
              enabled: true,
              label: "Start".toUpperCase(),
            ),
            SizedBox(height: sp(8)),
          ],
        ),
      ),
    );
  }
}

class _PlanTile extends StatelessWidget {
  const _PlanTile({
    required this.scale,
    required this.accent,
    required this.label,
    required this.price,
    required this.badgeText,
    required this.badgeBg,
    required this.badgeFg,
    required this.selected,
    required this.onTap,
    required this.radioSelectedStyle,
  });

  final double scale;
  final Color accent;
  final String label;
  final String price;
  final String? badgeText;
  final Color badgeBg;
  final Color badgeFg;
  final bool selected;
  final VoidCallback onTap;
  final bool radioSelectedStyle;

  double sp(double v) => v * scale;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: sp(60),
      child: Material(
        color: Colors.white,
        borderRadius: BorderRadius.circular(sp(20)),
        child: InkWell(
          borderRadius: BorderRadius.circular(sp(20)),
          onTap: onTap,
          child: Stack(
            children: [
              // left accent bar
              Positioned(
                left: 0,
                top: 16,
                bottom: 16,
                child: Container(
                  width: sp(4),
                  decoration: BoxDecoration(
                    color: accent,
                    borderRadius: BorderRadius.circular(sp(20)),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.fromLTRB(sp(20), sp(6), sp(16), sp(6)),
                child: Row(
                  children: [
                    // text
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            label,
                            style: GoogleFonts.funnelDisplay(
                              fontWeight: FontWeight.w400,
                              fontSize: sp(13),
                              height: 18 / 13,
                              letterSpacing: sp(-0.5),
                              color: const Color(0xFFAAAEBA),
                            ),
                          ),
                          SizedBox(height: sp(2)),
                          Row(
                            children: [
                              Text(
                                price,
                                style: GoogleFonts.funnelDisplay(
                                  fontWeight: FontWeight.w600,
                                  fontSize: sp(18),
                                  height: 28 / 18,
                                  letterSpacing: sp(-0.5),
                                  color: const Color(0xFF111111),
                                ),
                              ),
                              if (badgeText != null) ...[
                                SizedBox(width: sp(12)),
                                Container(
                                  padding: EdgeInsets.symmetric(
                                    horizontal: sp(8),
                                    vertical: sp(4),
                                  ),
                                  decoration: BoxDecoration(
                                    color: badgeBg,
                                    borderRadius: BorderRadius.circular(
                                      sp(100),
                                    ),
                                  ),
                                  child: Text(
                                    badgeText!,
                                    style: GoogleFonts.funnelDisplay(
                                      fontWeight: FontWeight.w500,
                                      fontSize: sp(14),
                                      height: 20 / 14,
                                      letterSpacing: sp(-0.5),
                                      color: badgeFg,
                                    ),
                                  ),
                                ),
                              ],
                            ],
                          ),
                        ],
                      ),
                    ),

                    // radio
                    Container(
                      width: sp(24),
                      height: sp(24),
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: selected ? Colors.white : Colors.transparent,
                        border: Border.all(
                          color: (selected)
                              ? const Color(0xFF111111)
                              : const Color(0xFF111111).withOpacity(0.04),
                          width: selected ? sp(8) : sp(3),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
