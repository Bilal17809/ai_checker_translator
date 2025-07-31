import 'package:ai_checker_translator/ads_manager/banner_ads.dart';
import 'package:ai_checker_translator/ads_manager/native_ads.dart';
import 'package:ai_checker_translator/ads_manager/splash_interstitial.dart';
import 'package:ai_checker_translator/core/bindings/bindings.dart';
import 'package:ai_checker_translator/data/helper/storage_helper.dart';
import 'package:ai_checker_translator/presentations/word_game/contrl/contrl.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import '/core/theme/app_theme.dart';
import 'package:flutter/material.dart';
import 'ads_manager/appOpen_ads.dart';
import 'ads_manager/interstitial_ads.dart';
import 'ads_manager/onesignal.dart';
import 'core/routes/routes.dart';
import 'core/routes/routes_name.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  MobileAds.instance.initialize();
  Get.put(PuzzleController());
  Get.put(AppOpenAdController());
  Get.put(BannerAdController());
  Get.put(LargeBannerAdController());
  Get.put(InterstitialAdController());
  Get.put(SplashInterstitialAdController());
  Get.put(NativeAdController());
  initializeOneSignal();
  await SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  await SharedPrefService().init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: AppTheme.themeData,
      initialRoute: RoutesName.splashPage,
       getPages: Routes.routes(),
      initialBinding: AllBindins(), 
    );
  }
}
