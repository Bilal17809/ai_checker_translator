import 'package:ai_checker_translator/core/theme/app_colors.dart';
import 'package:ai_checker_translator/presentations/ai_translator/view/ai_translator_page.dart';
import 'package:ai_checker_translator/presentations/bottom_nav_bar/bottom_nav_bar.dart';
import 'package:ai_checker_translator/translations/translation_contrl.dart';
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
    const Center(child: Text("Refresh Page")),
  ];
  final controller = Get.put(TranslationController());

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        FocusScope.of(context).unfocus();
        Get.back();
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
          color: kMediumGreen2,
          buttonBackgroundColor: kMediumGreen2,
          items: const <Widget>[
            Text("Share", style: TextStyle(color: kWhite)),
            Icon(Icons.mic, size: 46, color: Colors.white),
            Icon(Icons.refresh, size: 30, color: Colors.white),
          ],
          onTap: (index) async {
            if (index == 1) {
              final translationController = Get.put(TranslationController());
              translationController.clearData();
              final selectedLanguageCode =
                  '${translationController.languageCodes[translationController.selectedLanguage1.value]}-US';
              translationController.startSpeechToText(selectedLanguageCode);
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
