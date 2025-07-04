import 'package:ai_checker_translator/core/common_widgets/common_appbar_widget.dart';
import 'package:ai_checker_translator/core/common_widgets/keyboard_dismiss_wrapper.dart';
import 'package:ai_checker_translator/core/routes/routes_name.dart';
import 'package:ai_checker_translator/gen/assets.gen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../widgets/feature_card_widget.dart';
import '../widgets/grammar_test_card_widget.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  @override
  Widget build(BuildContext context) {
    return KeyboardDismissWrapper(
      child: Scaffold(
      appBar: CommonAppbarWidget(),
      drawer: const Drawer(),
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
                              OnTap: () => Get.toNamed(RoutesName.aidictionary),
                              image: Assets.aicorrectionicon.path,
                              title: "Ai corrector",
                              subtitle: "Grammar Checker",
                            ),
                          ),
                          const SizedBox(width: 8),
                          Expanded(
                            child: FeatureCardWidget(
                              OnTap:
                                  () => Get.toNamed(RoutesName.paraphraseview),
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
                                  () => Get.toNamed(RoutesName.paraphraseview),
                              image: Assets.learngrammaricon.path,
                              title: "Learn Grammar",
                            ),
                          ),
                          const SizedBox(width: 8),
                          Expanded(
                            child: FeatureCardWidget(
                              OnTap: () => Get.toNamed(RoutesName.askaiscreen),
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
                            () => Get.toNamed(RoutesName.paraphraseview),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
      )
    );
  }
}
