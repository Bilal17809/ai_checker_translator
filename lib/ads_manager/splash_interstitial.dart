import 'dart:io';
import 'package:get/get.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:firebase_remote_config/firebase_remote_config.dart';
import 'appOpen_ads.dart';
/*
Bundle Identifier:  com.aat.aigrammar

Apple Id: 6748681683

Remove Ad Product id:  com.aigrammar.removeads

OneSignal Key:  0a861af3-75dc-41f2-896e-cf8220fdd94a

Admob App Id:   ca-app-pub-5405847310750111~9421338603

Banner Ad id:  ca-app-pub-5405847310750111/4925853534

Native Adv Ad id:   ca-app-pub-5405847310750111/9743065943

AppOpen Ad id:  ca-app-pub-5405847310750111/6686707517

Interstitial Ad id:   ca-app-pub-5405847310750111/5482093593

Splash Interstitial Ad id: ca-app-pub-5405847310750111/5720060451
*/
class SplashInterstitialAdController extends GetxController {
  InterstitialAd? _interstitialAd;
  bool isAdReady = false;
  bool showSplashAd = true;

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
      String interstitialKey;
      if (Platform.isAndroid) {
        interstitialKey = 'SplashInterstitial';
      } else if (Platform.isIOS) {
        interstitialKey = 'SplashInterstitialAd';
      } else {
        throw UnsupportedError('Unsupported platform');
      }
      await remoteConfig.fetchAndActivate();
      showSplashAd = remoteConfig.getBool(interstitialKey);
      print(
        "#################### Remote Config: Show Splash Ad = $showSplashAd",
      );
      update();
    } catch (e) {
      print('Error fetching Remote Config: $e');
      showSplashAd = false;
    }
  }

  String get spInterstitialAdUnitId {
    if (Platform.isAndroid) {
      return 'ca-app-pub-8331781061822056/3601379175';
    } else if (Platform.isIOS) {
      return 'ca-app-pub-5405847310750111/5720060451';
    } else {
      throw UnsupportedError('Unsupported platform');
    }
  }

  void loadInterstitialAd() {
    InterstitialAd.load(
      adUnitId: spInterstitialAdUnitId,
      request: const AdRequest(),
      adLoadCallback: InterstitialAdLoadCallback(
        onAdLoaded: (ad) {
          _interstitialAd = ad;
          isAdReady = true;
          update();
        },
        onAdFailedToLoad: (error) {
          print("Interstitial Ad failed to load: $error");
          isAdReady = false;
        },
      ),
    );
  }

  Future<void> showInterstitialAd() async {
    if (!showSplashAd) {
      print("### Splash Ad Disabled via Remote Config");
      return;
    }
    if (_interstitialAd != null) {
      _interstitialAd!.fullScreenContentCallback = FullScreenContentCallback(
        onAdDismissedFullScreenContent: (ad) {
          Get.find<AppOpenAdController>().setInterstitialAdDismissed();
          ad.dispose();
          isAdReady = false;
          loadInterstitialAd();
          update();
        },
        onAdFailedToShowFullScreenContent: (ad, error) {
          print("### Ad failed to show: $error");
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

  @override
  void onClose() {
    _interstitialAd?.dispose();
    super.onClose();
  }
}
