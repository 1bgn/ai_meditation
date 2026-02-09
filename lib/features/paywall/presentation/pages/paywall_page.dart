import 'package:flutter/material.dart';
import 'package:signals_flutter/signals_flutter.dart';

import '../../../../core/di/injection_container.dart';
import '../../domain/entities/paywall_offer.dart';
import '../controllers/paywall_controller.dart';

class PaywallPage extends StatefulWidget {
  const PaywallPage({super.key});

  @override
  State<PaywallPage> createState() => _PaywallPageState();
}

class _PaywallPageState extends State<PaywallPage> {
  late final PaywallController _controller;

  @override
  void initState() {
    super.initState();
    _controller = getIt<PaywallController>();
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(title: const Text('Upgrade')),
        body: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            children: [
              Text(
                'Unlock personalized meditations',
                style: Theme.of(context).textTheme.titleLarge,
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 24),
              Expanded(
                child: Watch(
                  (context) => ListView.separated(
                    itemCount: _controller.offers.length,
                    separatorBuilder: (context, index) =>
                        const SizedBox(height: 12),
                    itemBuilder: (context, index) => _OfferCard(
                      offer: _controller.offers[index],
                      isSelected: _controller.selectedIndex.value == index,
                      onTap: () => _controller.select(index),
                    ),
                  ),
                ),
              ),
              FilledButton(
                onPressed: () {},
                child: const Text('Continue'),
              ),
            ],
          ),
        ),
      );
}

class _OfferCard extends StatelessWidget {
  const _OfferCard({
    required this.offer,
    required this.isSelected,
    required this.onTap,
  });

  final PaywallOffer offer;
  final bool isSelected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) => InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(16),
        child: Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: isSelected
                ? Theme.of(context).colorScheme.primaryContainer
                : Theme.of(context).colorScheme.surfaceContainerHighest,
            borderRadius: BorderRadius.circular(16),
            border: Border.all(
              color: isSelected
                  ? Theme.of(context).colorScheme.primary
                  : Colors.transparent,
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                offer.title,
                style: Theme.of(context).textTheme.titleMedium,
              ),
              const SizedBox(height: 6),
              Text(offer.description),
              const SizedBox(height: 12),
              Text(
                offer.price,
                style: Theme.of(context).textTheme.titleLarge,
              ),
            ],
          ),
        ),
      );
}
