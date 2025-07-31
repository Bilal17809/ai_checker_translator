import 'dart:io';
import 'package:ai_checker_translator/ads_manager/appOpen_ads.dart';
import 'package:ai_checker_translator/ads_manager/banner_ads.dart';
import 'package:ai_checker_translator/presentations/ai_dictionary/contrl/ai_dictioanay_contrl.dart';
import 'package:ai_checker_translator/presentations/ai_dictionary/view/ai_dictionary_page.dart';
import 'package:ai_checker_translator/presentations/aska/view/ask_ai_screen.dart';
import 'package:ai_checker_translator/presentations/paraphrase/view/paraphrase_view.dart';
import 'package:app_tracking_transparency/app_tracking_transparency.dart';
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
import '../controller/menu_controller.dart';
import '../widgets/feature_card_widget.dart';
import '../widgets/grammar_test_card_widget.dart';
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
  final TrackingController tracking = Get.put(TrackingController());

  bool isDrawerOpen=false;
  final GlobalKey<ScaffoldState> _globalKey=GlobalKey<ScaffoldState>();
  bool showAllFeatures = false;

  @override
  void initState() {
    tracking.requestTrackingPermission();
    super.initState();
  }

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
    final sHeight=MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;
    final itemWidth = (screenWidth - 14 * 2 - 12) / 2;
    final itemHeight = sHeight * 0.15;
    return FocusScope(
      node: _focusScopeNode,
      child: GestureDetector(
        onTap: () => _focusScopeNode.unfocus(),
        child: SafeArea(
          child: Scaffold(
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
                  padding:  EdgeInsets.symmetric(
                    horizontal: 14,
                    vertical:15,
                  ),
                  child: ConstrainedBox(
                    constraints: BoxConstraints(
                      minHeight: constraints.maxHeight,
                    ),
                    child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        if (!showAllFeatures) ...[
                     SingleChildScrollView(
                       physics: ScrollPhysics(),
                       scrollDirection: Axis.vertical,
                       child: Column(
                         children: [
                           GrammarTestCardWidget(
                             icon: Assets.topbannericon.path,
                             title: "Boost your vocabulary",
                             subtitle: "Learn Grammar by playing Games",
                             showActionButton: false,
                             onTap: () => Get.to(GameLevels()),
                           ),
                           SizedBox(height:sHeight*0.013),
                           GrammarTestCardWidget(
                             icon:'assets/icons/translation_ic.png',
                             title: "Speak Any Language",
                             subtitle:
                             "Translate text instantly between multiple languages.",
                             showActionButton: false,
                             onTap: () {
                               Get.toNamed(RoutesName.aiTranslatornavbar);
                             },
                           ),
                           SizedBox(height:sHeight*0.014),
                           if (!(Get.find<AppOpenAdController>().isShowingOpenAd.value || isDrawerOpen))
                             Get.find<LargeBannerAdController>().getBannerAdWidget('ad14'),
                           SizedBox(height:sHeight*0.014),
                           Row(
                             mainAxisAlignment: MainAxisAlignment.spaceBetween,
                             children: [
                               Text(
                                 "Features",
                                 style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                               ),
                               GestureDetector(
                                 onTap:(){
                                   setState(() {
                                     showAllFeatures = true;
                                   });
                                 },
                                 child:  Text("See all..",style: context.textTheme.labelMedium!.copyWith(
                                     color: Colors.blue
                                 ),),
                       
                               )
                             ],
                           ),
                           const SizedBox(height: 8),
                           FeaturePageView(),
                         ],
                       ),
                     )
                        ],

                        if (showAllFeatures) ...[
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "All Features",
                                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                              ),
                              GestureDetector(
                                onTap:(){
                                  setState(() {
                                    showAllFeatures = false;
                                  });
                                },
                                child:  Text("Back >>",style: context.textTheme.labelMedium!.copyWith(
                                    color: Colors.blue
                                ),),

                              )
                            ],
                          ),
                          SizedBox(height:sHeight*0.03),
                          GridView.count(
                            shrinkWrap: true,
                            physics: NeverScrollableScrollPhysics(),
                            crossAxisCount: 2,
                            mainAxisSpacing: 12,
                            crossAxisSpacing: 12,
                            childAspectRatio: itemWidth / itemHeight,
                            children: [
                              FeatureCardWidget(
                                OnTap: () {
                                  geminiAiCorrectionController.resetController();
                                  Get.to(() => AiDictionaryPage());
                                },
                                image:'assets/images/Group-2.png',
                                title: "Grammar Corrector",
                                subtitle: "",
                              ),
                              FeatureCardWidget(
                                OnTap: () => Get.to(() => ParaphraseView()),
                                image: 'assets/images/Group-1.png',
                                title: "Common Phrases",
                              ),
                              FeatureCardWidget(
                                OnTap: () => Get.toNamed(RoutesName.learngrammarscreen),
                                image: 'assets/images/education.png',
                                title: "Learn Grammar",
                              ),
                              FeatureCardWidget(
                                OnTap: () {
                                  geminicontroller.resetData();
                                  Get.to(() => AskAiScreen());
                                },
                                image: 'assets/images/Group-3.png',
                                title: "Ask Ai",
                                subtitle: "",
                              ),
                            ],
                          ),
                        ],
                        if (showAllFeatures)
                        const SizedBox(height: 16),
                        if (showAllFeatures)
                        Flexible(
                          child: GrammarTestCardWidget(
                            icon: Assets.topbannericon.path,
                            title: "Boost your vocabulary",
                            subtitle: "Learn Grammar by playing Games",
                            showActionButton: false,
                            onTap: () => Get.to(GameLevels()),
                          ),
                        ),
                        SizedBox(height:sHeight*0.02),
                        Flexible(
                          child: GrammarTestCardWidget(
                            icon: Assets.bottombannericon.path,
                            title: "English Grammar Test",
                            subtitle: "",
                            showActionButton: true,
                            actionButtonText: "Start now",
                            onActionPressed: () {
                              FocusScope.of(context).unfocus();
                              Get.toNamed(RoutesName.quizzesCategoryScreen);
                            },
                          ),
                        ),
                      ],
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
  const FeaturePageView({super.key});

  @override
  State<FeaturePageView> createState() => _FeaturePageViewState();
}

class _FeaturePageViewState extends State<FeaturePageView> {
  late final PageController _pageController;

  int currentPage = 1;

  final List<FeatureCardWidget> features = [
    FeatureCardWidget(
      OnTap: () {
        geminiAiCorrectionController.resetController();
        Get.to(() => AiDictionaryPage());
      },
      image: 'assets/images/Group-2.png',
      title: "Grammar Corrector",
    ),
    FeatureCardWidget(
      OnTap: () => Get.to(() => ParaphraseView()),
      image: 'assets/images/Group-1.png',
      title: "Common Phrases",
    ),
    FeatureCardWidget(
      OnTap: () => Get.toNamed(RoutesName.learngrammarscreen),
      image: 'assets/images/education.png',
      title: "Learn Grammar",
    ),
    FeatureCardWidget(
      OnTap: () {
        geminicontroller.resetData();
        Get.to(() => AskAiScreen());
      },
      image: 'assets/images/Group-3.png',
      title: "Ask Ai",
    ),
  ];

  @override
  void initState() {
    super.initState();
    _pageController = PageController(
      initialPage: 1,
      viewportFraction: 0.65,
    );
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final double cardWidth = MediaQuery.of(context).size.width * 0.90;
    final double cardHeight = MediaQuery.of(context).size.height;

    return Column(
      children: [
        SizedBox(
          height:cardHeight * 0.15,
          child: PageView.builder(
            controller: _pageController,
            itemCount: features.length,
            onPageChanged: (index) {
              setState(() {
                currentPage = index;
              });
            },
            itemBuilder: (context, index) {
              final feature = features[index];
              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8),
                child: FeatureCardWidget(
                  OnTap: feature.OnTap,
                  image: feature.image,
                  title: feature.title,
                  subtitle: feature.subtitle,
                ),
              );
            },
          ),
        ),
        const SizedBox(height: 12),
        Center(
          child: SmoothPageIndicator(
            controller: _pageController,
            count: features.length,
            effect: WormEffect(
              dotHeight: 8,
              dotWidth: 8,
              activeDotColor: Colors.blueAccent,
            ),
          ),
        ),
      ],
    );
  }
}




