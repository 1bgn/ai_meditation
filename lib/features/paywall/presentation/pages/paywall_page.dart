import 'dart:math' as math;
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:signals/signals_flutter.dart';

import '../../../../core/di/injection_container.dart';
import '../../../../core/ui/slide_to_start.dart';
import '../../domain/entities/paywall_offer.dart';
import '../controllers/paywall_controller.dart';

class PaywallPage extends StatefulWidget {
  const PaywallPage({super.key});

  @override
  State<PaywallPage> createState() => _PaywallPageState();
}

class _PaywallPageState extends State<PaywallPage> {
  late final PaywallController c;

  @override
  void initState() {
    super.initState();
    c = getIt<PaywallController>();
    c.init();
  }

  Future<void> _buySelected() async {
    await c.buySelected();
    if (!mounted) return;
    if (c.hasPremium.value) Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Watch((context) {
      final ready = c.isReady.watch(context);
      final busy = c.isBusy.watch(context);
      final err = c.error.watch(context);

      final offers = c.offers.watch(context);
      final selected = c.selectedIndex.watch(context);

      final canBuy = ready && !busy && offers.isNotEmpty;

      return Scaffold(
        backgroundColor: const Color(0xFFF6F7FA),
        body: LayoutBuilder(
          builder: (context, box) {
            const designW = 375.0;
            const designH = 812.0;

            final s = math.min(
              box.maxWidth / designW,
              box.maxHeight / designH,
            );

            double sp(double v) => v * s;

            return Stack(
              clipBehavior: Clip.none,
              children: [
                Positioned.fill(child: Container(color: const Color(0xFFF6F7FA))),
                Positioned.fill(
                  child: Image.asset(
                    "assets/images/paywall_bg.png",
                    fit: BoxFit.cover,
                  ),
                ),

                Positioned.fill(
                  child: Padding(
                    padding: const EdgeInsets.only(top: 24),
                    child: Column(
                      children: [
                        SizedBox(height: sp(8)),

                        // Top block
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
                                    fontVariations: const [FontVariation('wght', 300)],
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
                            child: const Column(
                              children: [
                                _CheckRow(text: 'Personalized Sessions'),
                                _CheckRow(text: 'Sleep & Relaxation'),
                                _CheckRow(text: 'Focus & Energy'),
                                _CheckRow(text: 'Mindfulness Tracking'),
                                _CheckRow(text: 'Nature & Music Sounds'),
                              ],
                            ),
                          ),
                        ),

                        if (!ready || busy) const LinearProgressIndicator(),
                        if (err != null)
                          Padding(
                            padding: EdgeInsets.only(top: sp(8)),
                            child: Text(
                              err,
                              textAlign: TextAlign.center,
                              style: GoogleFonts.funnelDisplay(
                                fontWeight: FontWeight.w500,
                                fontSize: sp(14),
                                color: Colors.red,
                              ),
                            ),
                          ),

                        const Spacer(),

                        _BottomSheet(
                          scale: s,
                          offers: offers,
                          selectedIndex: selected,
                          enabled: canBuy,
                          onSelect: c.select,
                          onContinue: _buySelected,
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
    });
  }
}

class _BottomSheet extends StatelessWidget {
  const _BottomSheet({
    required this.scale,
    required this.offers,
    required this.selectedIndex,
    required this.onSelect,
    required this.onContinue,
    required this.enabled,
  });

  final double scale;
  final List<PaywallOffer> offers;
  final int selectedIndex;
  final ValueChanged<int> onSelect;
  final Future<void> Function() onContinue;
  final bool enabled;

  double sp(double v) => v * scale;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.48),
        borderRadius: BorderRadius.vertical(top: Radius.circular(sp(40))),
      ),
      child: Padding(
        padding: EdgeInsets.fromLTRB(sp(16), sp(16), sp(16), sp(16)),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            for (int i = 0; i < offers.length; i++) ...[
              _PlanTile(
                scale: scale,
                accent: _accentForIndex(i),
                label: offers[i].title,
                price: offers[i].price,
                badgeText: null,
                badgeBg: Colors.transparent,
                badgeFg: Colors.transparent,
                selected: selectedIndex == i,
                onTap: enabled ? () => onSelect(i) : () {},
                radioSelectedStyle: i == 1,
              ),
              if (i != offers.length - 1) SizedBox(height: sp(4)),
            ],

            SizedBox(height: sp(14)),

            SlideToStart(
              onComplete: enabled ? () async => onContinue() : () async {},
              enabled: enabled,
              label: "Start".toUpperCase(),
            ),

            SizedBox(height: sp(8)),
          ],
        ),
      ),
    );
  }

  Color _accentForIndex(int i) {
    if (i == 0) return const Color(0xFFCBA7FF);
    if (i == 1) return const Color(0xFF7ACBFF);
    if (i == 2) return const Color(0xFF77C97E);
    return const Color(0xFF111111);
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
                                    borderRadius: BorderRadius.circular(sp(100)),
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

                    Container(
                      width: sp(24),
                      height: sp(24),
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: selected ? Colors.white : Colors.transparent,
                        border: Border.all(
                          color: selected
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
