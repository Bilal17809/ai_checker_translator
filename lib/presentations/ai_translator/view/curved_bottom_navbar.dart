
import 'package:ai_checker_translator/core/common_widgets/fluttertaost_message.dart';
import 'package:ai_checker_translator/core/common_widgets/no_internet_dialog.dart';
import 'package:ai_checker_translator/core/theme/app_colors.dart';
import 'package:ai_checker_translator/gen/assets.gen.dart';
import 'package:ai_checker_translator/presentations/ai_translator/controller/translation_contrl.dart';
import 'package:ai_checker_translator/presentations/ai_translator/view/ai_translation_History_screen.dart';
import 'package:ai_checker_translator/presentations/ai_translator/view/ai_translator_page.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';


class AiTranslatorBottomNav extends StatefulWidget {
  const AiTranslatorBottomNav({super.key});

  @override
  State<AiTranslatorBottomNav> createState() => _AiTranslatorBottomNavState();
}

class _AiTranslatorBottomNavState extends State<AiTranslatorBottomNav> {
  int _page = 1;

  final List<Widget> _pages = [
    const Center(child: Text("Share Page")),
    AiTranslatorPage(),
    AiTranslationHistoryScreen()
  ];
  final controller = Get.put(TranslationController());

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
       
        Get.back();
        FocusScope.of(context).unfocus();
        controller.controller.clear();

        return false;
      },
      child: Scaffold(
        body: _pages[_page],
        bottomNavigationBar: CurvedNavigationBar(
          animationDuration: const Duration(milliseconds: 200),
          index: _page,
          height: 60,
          backgroundColor: Colors.transparent,
          color: kMintGreen,
          buttonBackgroundColor: kMintGreen,
          items: <Widget>[
            Icon(Icons.clear, color: Colors.white),
            Icon(Icons.mic, size: 46, color: Colors.white),
            Image.asset(
              Assets.aitranslationhistoryicon.path,
              color: kWhite,
              height: 30,
            ),
          ],
          onTap: (index) async {
            if (index == 0) {
              controller.translationHistory.clear();
              controller.flutterTts.stop();
              // Utils().toastMessage("History cleared!");
              return;
            }
            if (index == 1) {
              final hasInternet = await Utils.isConnectedToInternet();

              if (!hasInternet) {
                showDialog(
                  context: context,
                  barrierDismissible: false,
                  builder: (_) => const NoInternetDialog(),
                );
                return;
              }

              controller.clearData();

              final selectedLanguageCode =
                  '${controller.languageCodes[controller.selectedLanguage1.value]}-US';

              controller.startSpeechToText(selectedLanguageCode);
            }
            setState(() {
              _page = index;
            });
          },

        ),
      ),
    );
  }
}
