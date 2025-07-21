import 'package:ai_checker_translator/ads_manager/appOpen_ads.dart';
import 'package:ai_checker_translator/ads_manager/banner_ads.dart';
import 'package:ai_checker_translator/ads_manager/native_ads.dart';
import 'package:ai_checker_translator/presentations/ai_dictionary/contrl/ai_dictioanay_contrl.dart';
import 'package:ai_checker_translator/presentations/ai_dictionary/view/ai_dictionary_page.dart';
import 'package:ai_checker_translator/presentations/aska/view/ask_ai_screen.dart';
import 'package:ai_checker_translator/presentations/paraphrase/view/paraphrase_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:ai_checker_translator/core/common_widgets/common_appbar_widget.dart';
import 'package:ai_checker_translator/core/common_widgets/custom_drawer.dart';
import 'package:ai_checker_translator/core/routes/routes_name.dart';
import 'package:ai_checker_translator/gen/assets.gen.dart';
import '../../aska/controller/gemini_controller.dart';
import '../../bottom_nav_bar/bottom_nav_bar.dart';
import '../../levels/game_leves.dart';
import '../widgets/feature_card_widget.dart';
import '../widgets/grammar_test_card_widget.dart';
import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  final geminicontroller = Get.find<GeminiController>();
  final FocusScopeNode _focusScopeNode = FocusScopeNode();
  GeminiAiCorrectionController geminiAiCorrectionController =
      Get.find<GeminiAiCorrectionController>();
  bool isDrawerOpen=false;
  final GlobalKey<ScaffoldState> _globalKey=GlobalKey<ScaffoldState>();
  bool showAllFeatures = false;

  @override
  void dispose() {
    FocusManager.instance.primaryFocus?.unfocus();
    Future.delayed(Duration(milliseconds: 10), () {
      SystemChannels.textInput.invokeMethod('TextInput.hide');
    });
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {
    return FocusScope(
      node: _focusScopeNode,
      child: GestureDetector(
        onTap: () => _focusScopeNode.unfocus(),
        child: SafeArea(
          child: Scaffold(
            backgroundColor: kWhiteF7,
            key: _globalKey,
            onDrawerChanged: (isOpen) {
              setState(() {
                isDrawerOpen = isOpen;
              });
            },
            appBar: CommonAppbarWidget(),
            drawer: CustomDrawer(),
            body: LayoutBuilder(
              builder: (context, constraints) {
                return Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 14,
                    vertical: 20,
                  ),
                  child: ConstrainedBox(
                    constraints: BoxConstraints(
                      minHeight: constraints.maxHeight,
                    ),
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
                          const SizedBox(height:8),
                          if (!(Get.find<AppOpenAdController>().isShowingOpenAd.value
                              || isDrawerOpen))
                            Get.find<LargeBannerAdController>().getBannerAdWidget('ad14'),
                          SizedBox(height:12),
                          /// Row 1
                          Expanded(
                            child: Row(
                              children: [
                                Expanded(
                                  child: FeatureCardWidget(
                                    OnTap: () {
                                      geminiAiCorrectionController
                                          .resetController();
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
                                    OnTap: () => Get.to(() => ParaphraseView()),
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
                            onActionPressed: () {
                              FocusScope.of(context).unfocus();
                              Get.toNamed(RoutesName.quizzesCategoryScreen);
                            },
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}

class FeaturePageView extends StatefulWidget {
  @override
  _FeaturePageViewState createState() => _FeaturePageViewState();
}

class _FeaturePageViewState extends State<FeaturePageView> {
  final PageController _controller = PageController(viewportFraction: 0.55);

  final List<FeatureCardWidget> features = [
    FeatureCardWidget(
      OnTap: () {
        geminiAiCorrectionController.resetController();
        Get.to(() => AiDictionaryPage());
      },
      image: Assets.aicorrectionicon.path,
      title: "Ai corrector",
      subtitle: "Grammar Checker",
    ),
    FeatureCardWidget(
      OnTap: () => Get.to(() => ParaphraseView()),
      image: Assets.paraphrasericon.path,
      title: "Paraphraser",
    ),
    FeatureCardWidget(
      OnTap: () => Get.toNamed(RoutesName.learngrammarscreen),
      image: Assets.learngrammaricon.path,
      title: "Learn Grammar",
    ),
    FeatureCardWidget(
      OnTap: () {
        geminicontroller.resetData();
        Get.to(() => AskAiScreen());
      },
      image: Assets.askaiicon.path,
      title: "Ask Ai",
      subtitle: "Assistant",
    ),
  ];

  @override
  Widget build(BuildContext context) {
    final double cardWidth = MediaQuery.of(context).size.width * 0.90;
    final double cardHeight = 140;

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        SizedBox(
          height: cardHeight,
          child: PageView.builder(
            controller: _controller,
            itemCount: features.length,
            physics: const BouncingScrollPhysics(),
            itemBuilder: (context, index) {
              final feature = features[index];
              return Padding(
                padding: const EdgeInsets.symmetric(horizontal:10),
                child: SizedBox(
                  width: cardWidth,
                  height: cardHeight,
                  child: FeatureCardWidget(
                    OnTap: feature.OnTap,
                    image: feature.image,
                    title: feature.title,
                    subtitle: feature.subtitle,
                  ),
                ),
              );
            },
          ),
        ),
        const SizedBox(height: 10),
        SmoothPageIndicator(
          controller: _controller,
          count: features.length,
          effect: const WormEffect(
            dotHeight: 8,
            dotWidth: 8,
            activeDotColor: Colors.blueAccent,
          ),
        ),
      ],
    );
  }
}

