import 'dart:io';

import 'package:apphud/models/apphud_models/apphud_paywall.dart';
import 'package:apphud/models/apphud_models/apphud_product.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:injectable/injectable.dart';
import 'package:signals/signals.dart';

import '../../data/apphud_monetization_service.dart';
import '../../domain/entities/paywall_offer.dart';
import '../../domain/monetization_service.dart';

@injectable
class PaywallController {
  PaywallController(this._service);

  final MonetizationService _service;

  // state
  final isReady = signal(false);
  final isBusy = signal(false);
  final error = signal<String?>(null);

  final hasPremium = signal<bool>(false);
  final hasSubcription = signal<bool>(false);

  final paywall = signal<ApphudPaywall?>(null);

  // UI data built from Apphud
  final offers = signal<List<PaywallOffer>>(const []);
  final productIds = signal<List<String>>(const []);
  final bannerAd = signal<BannerAd?>(null);

  final selectedIndex = signal(0);
  void select(int index) => selectedIndex.value = index;
  Future<void> initBanner()async{
    if (hasPremium.value) return;

    BannerAd(
      adUnitId: 'ca-app-pub-3940256099942544/6300978111',
      size: AdSize.banner,
      request: AdRequest(),
      listener: BannerAdListener(
        onAdLoaded: (ad) {

          bannerAd.value = ad as BannerAd;
          print("banner loaded");
        },
        onAdFailedToLoad: (ad, error) {
          print('Ошибка загрузки: ${error.message}');
          ad.dispose();
        },
      ),
    ).load();
  }
  Future<void> init() async {
    if (isReady.value || Platform.isAndroid) return;

    try {
      isBusy.value = true;
      error.value = null;

      await _service.init();
      await refreshStatus();

      paywall.value = await _service.getPaywall('main_paywall');
      _rebuildOffersFromPaywall();

      isReady.value = true;
    } catch (e) {
      error.value = '$e';
    } finally {
      isBusy.value = false;
    }
  }

  void _rebuildOffersFromPaywall() {
    final pw = paywall.value;
    final products = pw?.products ?? const <ApphudProduct>[];

    productIds.value = products.map((p) => p.productId).toList();

    offers.value = products.map((p) {
      final id = p.productId;
      return PaywallOffer(
        title: _titleFor(id),
        description: _descriptionFor(id),
        price: _priceLabel(p),
      );
    }).toList();

    if (selectedIndex.value >= offers.value.length) {
      selectedIndex.value = 0;
    }
  }

  // Маппинг под твои productId. При желании можно читать это из paywall.customJson.
  String _titleFor(String productId) {
    if (productId.contains('weekly')) return 'Weekly';
    if (productId.contains('monthly')) return 'Monthly';
    if (productId.contains('year')) return 'Yearly';
    if (productId.contains('lifetime')) return 'Lifetime';
    return productId;
  }

  String _descriptionFor(String productId) {
    if (productId.contains('weekly')) return 'Short-term access';
    if (productId.contains('monthly')) return 'Unlimited meditations';
    if (productId.contains('year')) return 'Best value for long-term';
    if (productId.contains('lifetime')) return 'Pay once, keep forever';
    return '';
  }

  // как в MainPaywallSheet
  String _priceLabel(ApphudProduct p) {
    final sk = p.skProduct;
    if (sk != null && sk.price != null) {
      final price = sk.price!;
      final symbol = sk.priceLocale.currencySymbol;
      final code = sk.priceLocale.currencyCode;
      final v = price.toStringAsFixed(2);

      if (symbol != null && symbol.isNotEmpty) return '$symbol$v';
      if (code != null && code.isNotEmpty) return '$v $code';
      return v;
    }

    // Если нужно Android-цены — добавь сюда ветку под поля Android-модели
    // (в разных версиях SDK они отличаются).
    return '—';
  }

  Future<void> refreshStatus() async {
    hasPremium.value = await _service.hasPremiumAccess();
  }

  Future<bool> hasActiveSubscription() async {
    final sub = await _service.hasActiveSubscription();
    hasSubcription.value = sub;
    return sub;
  }

  Future<void> checkSubscriptionStatus({bool forceSync = true}) async {
    try {
      isBusy.value = true;
      error.value = null;

      await _service.init();

      if (forceSync && _service is ApphudMonetizationService) {
        await (_service as ApphudMonetizationService).sync(force: true);
      }

      hasSubcription.value = await _service.hasActiveSubscription();
      hasPremium.value = await _service.hasPremiumAccess();
    } catch (e) {
      error.value = '$e';
    } finally {
      isBusy.value = false;
    }
  }

  Future<void> buySelected() async {
    final ids = productIds.value;
    if (ids.isEmpty) {
      error.value = 'Paywall/products not loaded';
      return;
    }

    final i = selectedIndex.value.clamp(0, ids.length - 1);
    await _buyByProductId(ids[i]);
  }

  Future<void> _buyByProductId(String id) async {
    final pw = paywall.value;
    final products = pw?.products;
    if (products == null || products.isEmpty) {
      error.value = 'Paywall/products not loaded';
      return;
    }

    final product = products.firstWhere(
          (p) => p.productId == id,
      orElse: () => throw StateError('Product $id not found in paywall'),
    );

    try {
      isBusy.value = true;
      error.value = null;

      final result = await _service.purchase(product: product);
      if (result.error != null) {
        error.value = result.error!.message ?? 'Purchase failed';
        return;
      }

      await refreshStatus();
      await hasActiveSubscription();
    } catch (e) {
      error.value = '$e';
    } finally {
      isBusy.value = false;
    }
  }

  Future<void> restore() async {
    try {
      isBusy.value = true;
      error.value = null;

      await _service.restorePurchases();
      await refreshStatus();
      await hasActiveSubscription();
    } catch (e) {
      error.value = '$e';
    } finally {
      isBusy.value = false;
    }
  }
}
