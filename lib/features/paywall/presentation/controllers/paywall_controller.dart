import 'package:injectable/injectable.dart';
import 'package:signals/signals.dart';

import '../../domain/entities/paywall_offer.dart';

@injectable
class PaywallController {
  final offers = [
    const PaywallOffer(
      title: 'Monthly',
      description: 'Unlimited meditations',
      price: '\$9.99',
    ),
    const PaywallOffer(
      title: 'Yearly',
      description: 'Best value for long-term',
      price: '\$59.99',
    ),
    const PaywallOffer(
      title: 'Lifetime',
      description: 'Pay once, keep forever',
      price: '\$149.99',
    ),
  ];

  final selectedIndex = signal(0);

  void select(int index) => selectedIndex.value = index;
}
