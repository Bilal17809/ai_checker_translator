import 'package:ai_checker_translator/core/routes/routes_name.dart';
import 'package:ai_checker_translator/core/theme/app_colors.dart';
import 'package:ai_checker_translator/gen/assets.gen.dart';
import 'package:ai_checker_translator/presentations/ai_dictionary/contrl/animation_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'dart:async';

import 'package:get/utils.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';


class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  void initState() {
    super.initState();
    // Timer(const Duration(seconds: 3), () {
    //   Get.offNamed(RoutesName.bottomNevBar);
    // });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: [
          // 🖼️ Background Image
          Image.asset(Assets.splash.path, fit: BoxFit.fill),

          // ✨ Centered Animated Text
          Align(
            alignment: Alignment.bottomCenter,
            child: Padding(
              padding: const EdgeInsets.only(bottom: 62),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  SizedBox(height: 20),
                  Text(
                    "Ai Grammar\n    Checker",
                    style: TextStyle(
                      color: kWhite,
                      fontSize: 34,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 08),
                  AnimatedTypingText(
                    text: "Real-Time AI Grammar Correction Made Easy",
                    style: TextStyle(
                      color: kWhite,
                      fontWeight: FontWeight.bold,
                      fontSize: 14,
                      // textBaseline: TextBaseline.ideographic,
                    ),
                    charDuration: Duration(milliseconds: 80),
                  ),
                  SizedBox(height: 100),
                  LoadingAnimationWidget.staggeredDotsWave(
                    color: kWhite,
                    size: 40,
                  ),
                ],
              ),
            ),
          ),
        ]
      ),
    );

  }
}
