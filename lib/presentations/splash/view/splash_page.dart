
import 'package:ai_checker_translator/core/theme/app_colors.dart';
import 'package:ai_checker_translator/core/theme/app_theme.dart';
import 'package:ai_checker_translator/gen/assets.gen.dart';
import 'package:ai_checker_translator/presentations/ai_dictionary/contrl/animation_controller.dart';
import 'package:ai_checker_translator/presentations/splash/controller/splash_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

import '../../../ads_manager/splash_interstitial.dart';


class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {

  final SplashController controller = Get.put(SplashController());
  @override
  Widget build(BuildContext context) {
    final hiegt = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return SafeArea(
      child: Scaffold(
        body: Stack(
          fit: StackFit.expand,
          children: [
            Image.asset(Assets.splash.path, fit: BoxFit.fill),
            Align(
              alignment: Alignment.bottomCenter,
              child: Padding(
                padding: const EdgeInsets.only(bottom: 68),
                child: Obx(() {
                  return Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      SizedBox(height: 20),
                      AnimatedTypingText(
                        text: "Ai Grammar",
                        charDuration: Duration(milliseconds: 300),
                        style: context.textTheme.displayLarge!.copyWith(
                          color: kWhite,
                          fontSize: 34,
                          fontWeight: FontWeight.bold,
                          shadows: [BoxShadow(color: kBlack, blurRadius: 6)],
                        ),
                        direction: TypingDirection.leftToRight,
                        curve: Curves.easeOutCubic,
                      ),
                      AnimatedTypingText(
                        text: "Checker",
                        charDuration: Duration(milliseconds: 700),
                        style: context.textTheme.displayLarge!.copyWith(
                          color: kWhite,
                          fontSize: 34,
                          fontWeight: FontWeight.bold,
                          shadows: [BoxShadow(color: kBlack, blurRadius: 6)],
                        ),
                        direction: TypingDirection.leftToRight,
                        curve: Curves.easeOutCubic,
                      ),
                      SizedBox(height: 16),
                      AnimatedTypingText(
                        text: "Real-Time AI Grammar Correction Made Easy",
                        charDuration: Duration(milliseconds: 200),
                        style: context.textTheme.bodySmall!.copyWith(
                          color: kWhite,
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          shadows: [BoxShadow(color: kBlack, blurRadius: 6)],
                        ),
                        direction: TypingDirection.rightToLeft,
                        textAlign: TextAlign.right,
                        curve: Curves.easeOutCubic,
                      ),
                      SizedBox(height: 100),
                      if (controller.isLoading.value)
                        LoadingAnimationWidget.staggeredDotsWave(
                          color: kWhite,
                          size: 40,
                        ),
                      if (controller.showButton.value &&
                          !controller.initializingControllers.value)
                        SizedBox(
                          height: hiegt * 0.06,
                          width: width * 0.4,
                          child: ElevatedButton(
                            onPressed: () async{
                              controller.initializeAppControllers();
                            },
                            style: AppTheme.elevatedButtonStyle,
                            child: FittedBox(
                              fit: BoxFit.scaleDown,
                              child: Text(
                                "Let's Go",
                                style: const TextStyle(
                                  fontSize: 16,
                                  color: kBlack,
                                ),
                              ),
                            ),
                          ),
                        ),
                      // SizedBox(height: 20),
                      if (controller.initializingControllers.value)
                        CircularProgressIndicator(
                          valueColor: AlwaysStoppedAnimation<Color>(kWhite),
                        ),
                    ],
                  );
                }),
              ),
            ),
          ]
        ),
      ),
    );

  }
}
