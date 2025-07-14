import 'package:ai_checker_translator/presentations/ai_dictionary/view/ai_dictionary_page.dart';
import 'package:ai_checker_translator/presentations/aska/view/ask_ai_screen.dart';
import 'package:ai_checker_translator/presentations/bottom_nav_bar/bottom_nav_bar.dart';
import 'package:ai_checker_translator/presentations/paraphrase/view/paraphrase_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:ai_checker_translator/core/common_widgets/common_appbar_widget.dart';
import 'package:ai_checker_translator/core/common_widgets/custom_drawer.dart';
import 'package:ai_checker_translator/core/routes/routes_name.dart';
import 'package:ai_checker_translator/core/theme/app_colors.dart';
import 'package:ai_checker_translator/gen/assets.gen.dart';
import '../../aska/controller/gemini_controller.dart';
import '../widgets/feature_card_widget.dart';
import '../widgets/grammar_test_card_widget.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  final geminicontroller = Get.find<GeminiController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CommonAppbarWidget(),
      drawer: CustomDrawer(),
      body: LayoutBuilder(
        builder: (context, constraints) {
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 20),
            child: ConstrainedBox(
              constraints: BoxConstraints(minHeight: constraints.maxHeight),
              child: IntrinsicHeight(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    /// Top Grammar Test Card
                    GrammarTestCardWidget(
                      icon: Assets.topbannericon.path,
                      title: "Boost your learning",
                      subtitle: "Learn Grammar by playing Games",
                      showActionButton: false,
                    ),
                    const SizedBox(height: 16),

                    /// Row 1
                    Expanded(
                      child: Row(
                        children: [
                          Expanded(
                            child: FeatureCardWidget(
                              OnTap: () {
                                geminiAiCorrectionController.resetController();
                                Get.to(() => AiDictionaryPage());
                              },
                              image: Assets.aicorrectionicon.path,
                              title: "Ai corrector",
                              subtitle: "Grammar Checker",
                            ),
                          ),
                          const SizedBox(width: 8),
                          Expanded(
                            child: FeatureCardWidget(
                              OnTap:
                                  () => Get.to(() => ParaphraseView()),
                              image: Assets.paraphrasericon.path,
                              title: "Paraphraser",
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 16),

                    /// Row 2
                    Expanded(
                      child: Row(
                        children: [
                          Expanded(
                            child: FeatureCardWidget(
                              OnTap:
                                  () => Get.toNamed(
                                    RoutesName.learngrammarscreen,
                                  ),
                              image: Assets.learngrammaricon.path,
                              title: "Learn Grammar",
                            ),
                          ),
                          const SizedBox(width: 8),
                          Expanded(
                            child: FeatureCardWidget(
                              OnTap: () {
                                geminicontroller.resetData();
                                Get.to(() => AskAiScreen());
                              },
                              image: Assets.askaiicon.path,
                              title: "Ask Ai",
                              subtitle: "Assistant",
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 16),

                    /// Bottom Grammar Test
                    GrammarTestCardWidget(
                      icon: Assets.bottombannericon.path,
                      title: "English Grammar Test",
                      subtitle:
                          "Begins the English Grammar Test to improve your grammar skills.",
                      showActionButton: true,
                      actionButtonText: "Let’s Go",
                      onActionPressed:
                          () => Get.toNamed(RoutesName.quizzesCategoryScreen),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
