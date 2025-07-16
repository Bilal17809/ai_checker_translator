import 'package:ai_checker_translator/core/common_widgets/common_appbar_widget.dart';
import 'package:ai_checker_translator/core/theme/app_colors.dart';
import 'package:ai_checker_translator/presentations/ai_translator/controller/translation_contrl.dart';
import 'package:ai_checker_translator/presentations/ai_translator/widgets/translation_history_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/route_manager.dart';

class AiTranslationHistoryScreen extends StatefulWidget {
  const AiTranslationHistoryScreen({super.key});

  @override
  State<AiTranslationHistoryScreen> createState() => _AiTranslationHistoryScreenState();
}

class _AiTranslationHistoryScreenState extends State<AiTranslationHistoryScreen> {


  final controller = Get.find<TranslationController>();

  @override
  void dispose() {
    controller.audioPlayer.stop();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: CommonAppBar(appBarTitle: "Favourite"),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
          child: SizedBox.expand(
            child: TranslationHistoryWidget(
              showFavouriteIcon: true,
              showOnlyFavourites: true,
              deleteFromFavouritesOnly: true,
              overrideSpeakAndCopy: false,
              showSourceText: true,
            ),
          ),
        ),
      ),
    );
  }
}
