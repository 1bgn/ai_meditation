import 'dart:io';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'app.dart';
import 'core/di/injection_container.dart';
import 'package:appsflyer_sdk/appsflyer_sdk.dart';
import 'package:appmetrica_plugin/appmetrica_plugin.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:apphud/models/apphud_models/apphud_debug_level.dart';

import 'package:android_id/android_id.dart';
import 'package:app_tracking_transparency/app_tracking_transparency.dart';
import 'package:apphud/apphud.dart';
Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await configureDependencies();

  await getATT();
  await Firebase.initializeApp(
  );

  await initAppsFlyer();
  await initApphud();
  await MobileAds.instance.initialize();
  await initAppmetrica();
  configureDependencies();
  const _androidIdPlugin = AndroidId();
  final String? androidId = await _androidIdPlugin.getId();
  runApp(AiMeditationApp());
}
Future<void> initApphud() async {
  try{
    await Apphud.enableDebugLogs(level: ApphudDebugLevel.high);
  }catch(e){
    print(e);
  }

}
Future<void> getATT() async {
  if(Platform.isIOS){
    final status = await AppTrackingTransparency.requestTrackingAuthorization();

  }
}
Future<void> initAppsFlyer()async {
  print("initAppsFlyer");

  final AppsFlyerOptions options = AppsFlyerOptions(
      afDevKey: "wWnc2go5ZMLf9xRNFtwAj3",
      appId: "6757518897",
      showDebug: true,
      timeToWaitForATTUserAuthorization: 30,
      manualStart: true);
  AppsflyerSdk _appsflyerSdk = AppsflyerSdk(options);
  await _appsflyerSdk.initSdk(
      registerConversionDataCallback: true,
      registerOnAppOpenAttributionCallback: true,
      registerOnDeepLinkingCallback: true);
  _appsflyerSdk.startSDK(
    onSuccess: () {
      print("AppsFlyer SDK initialized successfully.");
    },
    onError: (int errorCode, String errorMessage) {
      print("Error initializing AppsFlyer SDK: Code $errorCode - $errorMessage");
    },
  );
}
Future<void> initAppmetrica() async {
  await AppMetrica.activate(AppMetricaConfig("01fb5cf7-c9be-4e3d-9472-79d889903750"));
}