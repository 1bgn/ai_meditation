import 'package:freezed_annotation/freezed_annotation.dart';

part 'paywall_offer.freezed.dart';

@freezed
class PaywallOffer with _$PaywallOffer {
  const factory PaywallOffer({
    required String title,
    required String description,
    required String price,
  }) = _PaywallOffer;
}
