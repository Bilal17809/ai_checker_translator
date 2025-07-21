import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../ads_manager/appOpen_ads.dart';
import '../../ads_manager/native_ads.dart';
import '../../core/animation/animation_games.dart';
import '../../core/common_widgets/icon_buttons.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_styles.dart';
import '../remove_ads_contrl/remove_ads_contrl.dart';
import '../word_game/view/word_game_view.dart';

class GameLevels extends StatelessWidget {
  const GameLevels({super.key});

  @override
  Widget build(BuildContext context) {
    final nativeAdController = Get.put(NativeAdMeduimController());
    final RemoveAds removeAds=Get.put(RemoveAds());
    final AppOpenAdController appOpenAdController=Get.put(AppOpenAdController());
    return Scaffold(
      appBar: AppBar(
          centerTitle: true,
          leading: Padding(
            padding: const EdgeInsets.all(12.0),
            child: BackIconButton(onTap: () {
              Navigator.of(context).pop();
            },),
          ),
          backgroundColor:kMintGreen,
          title:  Text("Levels",
            style: context.textTheme.titleLarge?.copyWith(
                color: kWhiteFA
            ),
          )),
      body: Container(
        decoration: roundedDecoration,
        padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 18),
        child: SingleChildScrollView(
          child: Column(
            children: [
              LevelCard(level: 1),
              const SizedBox(height: 16),
              LevelCard(level: 2),
              const SizedBox(height: 16),
              LevelCard(level: 3),
              SizedBox(height: MediaQuery.of(context).size.height * 0.02),

              if (!(appOpenAdController.isShowingOpenAd.value ||
                  removeAds.isSubscribedGet.value))
                nativeAdController.nativeAdWidget(),
            ],
          ),
        ),
      ),
    );
  }
}
class LevelCard extends StatelessWidget {
  final int level;

  const LevelCard({super.key, required this.level});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: roundedDecoration.copyWith(
          color:kMintGreen
      ),
      child: Padding(
        padding: const EdgeInsets.all(5.0),
        child: ListTile(
          leading: Image.asset(
            'assets/icons/level-up.png',
            key: const ValueKey('medal'),
            width:50,
            height:50,
          ),
          title: Text('Level $level',style:context.textTheme.titleMedium?.copyWith(
            color: Colors.white
          ),),
          subtitle: Text('Your Grammar Quest Begins Level $level',
              style:context.textTheme.labelSmall?.copyWith(
              color: Colors.white
          )),
          trailing:AnimatedForwardArrow2(color: Colors.orangeAccent,size:25,),
          onTap: () {
            Get.to(PuzzlePage(level: "$level"));
          },
        ),
      ),
    );
  }
}

