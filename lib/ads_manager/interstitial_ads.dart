import 'dart:io';
import 'package:firebase_remote_config/firebase_remote_config.dart';
import 'package:get/get.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

import '../presentations/remove_ads_contrl/remove_ads_contrl.dart';
import 'appOpen_ads.dart';

class InterstitialAdController extends GetxController {
  InterstitialAd? _interstitialAd;
  bool isAdReady = false;
  int screenVisitCount = 0;
  int adTriggerCount = 3;
  bool _interstitialAdShown = false;
  final RemoveAds removeAdsController = Get.put(RemoveAds());



  @override
  void onInit() {
    super.onInit();
    initializeRemoteConfig();
    loadInterstitialAd();
  }

  Future<void> initializeRemoteConfig() async {
    final remoteConfig = FirebaseRemoteConfig.instance;
    try {
      await remoteConfig.setConfigSettings(
        RemoteConfigSettings(
          fetchTimeout: const Duration(seconds: 10),
          minimumFetchInterval: const Duration(seconds: 1),
        ),
      );
      await remoteConfig.fetchAndActivate();
      String interstitialKey;
      if (Platform.isAndroid) {
        interstitialKey = 'InterstitialAd';
      } else if (Platform.isIOS) {
        interstitialKey = 'InterstitialAd';
      } else {
        throw UnsupportedError('Unsupported platform');
      }
      if (remoteConfig.getValue(interstitialKey).source !=
          ValueSource.valueStatic) {
        adTriggerCount = remoteConfig.getInt(interstitialKey);
      } else {
        print("### Remote Config: Using default value.");
      }
      update();
    } catch (e) {
      adTriggerCount = 3;
    }
  }

  String get interstitialAdUnitId {
    if (Platform.isAndroid) {
      return
      'ca-app-pub-8331781061822056/8952728454';
    } else if (Platform.isIOS) {
      return 'ca-app-pub-5405847310750111/5482093593';
    } else {
      throw UnsupportedError('Unsupported platform');
    }
  }

  void loadInterstitialAd() {
    InterstitialAd.load(
      adUnitId: interstitialAdUnitId,
      request: const AdRequest(),
      adLoadCallback: InterstitialAdLoadCallback(
        onAdLoaded: (ad) {
          _interstitialAd = ad;
          isAdReady = true;
          update();
        },
        onAdFailedToLoad: (error) {
          isAdReady = false;
        },
      ),
    );
  }

  void showInterstitialAd() {
    if (Platform.isIOS && removeAdsController.isSubscribedGet.value) {
      return;
    }
    if (_interstitialAd != null) {
      _interstitialAdShown = true;
      _interstitialAd!.fullScreenContentCallback = FullScreenContentCallback(
        onAdDismissedFullScreenContent: (ad) {
          Get.find<AppOpenAdController>().setInterstitialAdDismissed();
          _interstitialAdShown = false;
          ad.dispose();
          isAdReady = false;
          screenVisitCount = 0;
          loadInterstitialAd();
          update();
        },
        onAdFailedToShowFullScreenContent: (ad, error) {
          _interstitialAdShown = false;
          screenVisitCount = 0;
          ad.dispose();
          isAdReady = false;
          loadInterstitialAd();
          update();
        },
      );
      _interstitialAd!.show();
      _interstitialAd = null;
    } else {
      print("### Interstitial Ad not ready.");
    }
  }

  void checkAndShowAd() {
    if (Platform.isIOS && removeAdsController.isSubscribedGet.value) {
      return;
    }
    screenVisitCount++;
    if (screenVisitCount >= adTriggerCount) {
      if (isAdReady) {
        showInterstitialAd();
      } else {
        screenVisitCount = 0;
      }
    }
  }

  @override
  void onClose() {
    _interstitialAd?.dispose();
    super.onClose();
  }
}
