import 'package:ai_checker_translator/ads_manager/splash_interstitial.dart';
import 'package:ai_checker_translator/core/common_widgets/common_appbar_widget.dart';
import 'package:ai_checker_translator/core/routes/routes_name.dart';
import 'package:ai_checker_translator/core/theme/app_colors.dart';
import 'package:ai_checker_translator/presentations/quizzes_category_screen/model/grammarcategory_model.dart';
import 'package:ai_checker_translator/presentations/quizdetail/controller/quiz_detail_controller.dart';
import 'package:ai_checker_translator/presentations/quizzes_result/controller/result_screen_controller.dart';
import 'package:ai_checker_translator/presentations/quizzes_result/result_arguments_model/result_argument_model.dart';
import 'package:ai_checker_translator/presentations/quizzes_result/widgets/button.dart';
// import 'package:ai_checker_translator/presentations/quizzes_result/widgets/score_circle.dart';
import 'package:ai_checker_translator/presentations/quizzes_result/widgets/progress_bar.dart';
import 'package:ai_checker_translator/presentations/quizzes_result/widgets/score_circle_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../ads_manager/banner_ads.dart';
import '../../ads_manager/interstitial_ads.dart';

class QuizResultScreen extends StatefulWidget {
  QuizResultScreen({super.key});

  @override
  State<QuizResultScreen> createState() => _QuizResultScreenState();
}

class _QuizResultScreenState extends State<QuizResultScreen> {
  final detailcontroller = Get.find<QuizDetailController>();
  final ResultController resultController = Get.put(ResultController());


  late final ResultArguments args;

  @override
  void initState() {
    super.initState();
    args = ResultArguments.fromMap(Get.arguments ?? {});
  }


  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: CommonAppBar(appBarTitle: "Result"),
        backgroundColor: const Color(0xFFF4EDFB),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 38),
          child: Column(
            // mainAxisAlignment: MainAxisAlignment.center,
            children: [
              /// 📦 Score Card
              Center(
                child: Container(
                  width: 300,
                  padding: const EdgeInsets.all(24),

                  // decoration: BoxDecoration(
                  //   borderRadius: BorderRadius.circular(24),
                  //   color: colors
                  //   // gradient: const LinearGradient(
                  //   //   colors: [Color(0xFFF7F4FD), Color(0xFFE7E0F7)],
                  //   //   begin: Alignment.topLeft,
                  //   //   end: Alignment.bottomRight,
                  //   // ),
                  // ),
                  child: Column(
                    children: [
                      ScoreCircle(score: args.score),
                      // const SizedBox(height: 24),
                      if (args.score >= 50) ...[
                        const SizedBox(height: 28),
                        const Text(
                          "Congratulations!",
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: kMintGreen,
                          ),
                        ),
                        const SizedBox(height: 8),
                        const Text(
                          "You have successfully\npassed the quiz.",
                          textAlign: TextAlign.center,
                          style: TextStyle(fontSize: 16, color: Colors.black54),
                        ),
                      ],
                    ],
                  ),
                ),
              ),

              const SizedBox(height: 38),

              ProgressBar(
                label: 'Correct',
                count: args.correct,
                total: args.total,
                color: Colors.green,
                isCorrect: true,
              ),
              SizedBox(height: 10),
              ProgressBar(
                label: 'Wrong',
                count: args.wrong,
                total: args.total,
                color: Colors.red,
                isCorrect: false,
              ),
              const SizedBox(height: 38),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Button(
                    buttonTitle: "Exit",
                    onPressed: () {
                      detailcontroller.resetQuiz();
                      Get.back();
                    },
                    buttonColor: Colors.red,
                  ),
                  SizedBox(width: 08),
                  Button(
                    buttonTitle: "Retake",
                    onPressed: () async {
                      Get.find<SplashInterstitialAdController>().showInterstitialAd();
                      detailcontroller.resetQuiz();
                      resultController.retakeQuiz(
                        catId: args.catId,
                        title: args.title,
                        category: args.category,
                      );
                    },
                  ),

                  SizedBox(width: 08),
                  Button(
                    buttonTitle: "Preview",
                    onPressed: () async {
                      Get.find<SplashInterstitialAdController>().showInterstitialAd();
                      detailcontroller.isResultMode.value = true;
                      resultController.retakeQuiz(
                        catId: args.catId,
                        title: args.title,
                        category: args.category,
                      );
                    },
                  ),
                ],
              ),
            ],
          ),
        ),
        bottomNavigationBar:
        Get.find<InterstitialAdController>().isAdReady ||
            Get.find<SplashInterstitialAdController>().isAdReady
            ? SizedBox()
            : Obx(() {
          return Get.find<BannerAdController>().getBannerAdWidget('ad9');
        }),
      ),
    );
  }
}
