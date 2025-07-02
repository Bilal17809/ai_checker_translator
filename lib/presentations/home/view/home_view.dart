
import 'package:ai_checker_translator/core/common_widgets/common_appbar_widget.dart';
import 'package:ai_checker_translator/core/routes/routes_name.dart';
import 'package:ai_checker_translator/gen/assets.gen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../widgets/feature_card_widget.dart';
import '../widgets/grammar_test_card_widget.dart';

class HomeView extends StatefulWidget {
  // final HomeController controller = Get.put(HomeController());

  HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
@override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CommonAppbarWidget(),
      drawer: Drawer(),
      body: SafeArea(
        child: LayoutBuilder(
          builder: (context, constraints) {
            return constraints.maxHeight < 700
                ? SingleChildScrollView(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 14,
                    vertical: 20,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: _buildHomeContent(), // 👇 common layout
                  ),
                )
                : Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 14,
                    vertical: 20,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: _buildHomeContent(), // 👇 common layout
                  ),
                );
          },
        ),
      ),
    );
  }
}

List<Widget> _buildHomeContent() {
  return [
    GrammarTestCardWidget(
      icon: Assets.topbannericon.path,
      title: "Boost your learning",
      subtitle: "Learn Grammar by playing Games",
      showActionButton: false,
    ),
    const SizedBox(height: 16),
    Row(
      children: [
        Expanded(
          child: FeatureCardWidget(
            OnTap: () {
              Get.toNamed(RoutesName.aidictionary);
            },
            image: Assets.aicorrectionicon.path,
            title: "Ai corrector",
            subtitle: "Grammar Checker",
          ),
        ),
        const SizedBox(width: 8),
        Expanded(
          child: FeatureCardWidget(
            OnTap: () {
              Get.toNamed(RoutesName.paraphraseview);
            },
            image: Assets.paraphrasericon.path,
            title: "Pharaphraser",
          ),
        ),
      ],
    ),
    const SizedBox(height: 16),
    Row(
      children: [
        Expanded(
          child: FeatureCardWidget(
            OnTap: () {
              Get.toNamed(RoutesName.paraphraseview);
            },
            image: Assets.learngrammaricon.path,
            title: "Learn Grammar",
          ),
        ),
        const SizedBox(width: 8),
        Expanded(
          child: FeatureCardWidget(
            OnTap: () {},
            image: Assets.askaiicon.path,
            title: "Ask Ai",
            subtitle: "Assistant",
          ),
        ),
      ],
    ),
    const SizedBox(height: 16),
    GrammarTestCardWidget(
      icon: Assets.bottombannericon.path,
      title: "English Grammar Test",
      subtitle:
          "Begins the English Grammar Test to improve your grammar skills.",
      showActionButton: true,
      actionButtonText: "Let’s Go",
      onActionPressed: () {
        print("Let's Go pressed!");
      },
    ),
  ];
}

