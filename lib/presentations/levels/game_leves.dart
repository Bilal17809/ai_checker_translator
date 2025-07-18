import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../core/animation/animation_games.dart';
import '../../core/theme/app_styles.dart';
import '../word_game/view/word_game_view.dart';

class GameLevels extends StatelessWidget {
  const GameLevels({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Positioned(
        top: 95,
        left: 0,
        right: 0,
        bottom: 0,
        child: Container(
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
                // if (!(appOpenAdController.isShowingOpenAd.value ||
                //     removeAds.isSubscribedGet.value))
                //   nativeAdController.nativeAdWidget('key2'),
              ],
            ),
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
          color:Colors.blue.withAlpha(255),
      ),
      child: Padding(
        padding: const EdgeInsets.all(5.0),
        child: ListTile(
          leading: const AnimatedMedalIcon(),
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

