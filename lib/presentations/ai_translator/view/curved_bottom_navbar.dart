import 'package:ai_checker_translator/core/theme/app_colors.dart';
import 'package:ai_checker_translator/presentations/ai_translator/controller/translator_controller.dart';
import 'package:ai_checker_translator/presentations/ai_translator/view/ai_translator_page.dart';
import 'package:ai_checker_translator/presentations/ai_translator/widgets/VoiceTranslatorDialog.dart';
import 'package:ai_checker_translator/presentations/ai_translator/widgets/speach_to_text_google_dialog.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

class AiTranslatorBottomNav extends StatefulWidget {
  const AiTranslatorBottomNav({super.key});

  @override
  State<AiTranslatorBottomNav> createState() => _AiTranslatorBottomNavState();
}

class _AiTranslatorBottomNavState extends State<AiTranslatorBottomNav> {
  int _page = 1; 

  final List<Widget> _pages = [
    Center(child: Text("Share Page")),
    AiTranslatorPage(), 
    Center(child: Text("Refresh Page")),
  ];
  final controller = Get.find<TranslatorController>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_page],
      bottomNavigationBar: CurvedNavigationBar(
        animationDuration: const Duration(milliseconds: 200), 
        index: _page,
        height: 60,
        backgroundColor: Colors.transparent,
        color: kMediumGreen2,
        buttonBackgroundColor: kMediumGreen2,
        items: const <Widget>[
         Text("Share",style: TextStyle(color: kWhite),),
          Icon(Icons.mic, size: 46, color: Colors.white),
          Icon(Icons.refresh, size: 30, color: Colors.white),
        ],
        onTap: (index) async {
          if (index == 1) {
            final controller = Get.put(TranslatorController());

            // Clear previous state
            controller.textController.clear();
            controller.resetVoiceTranslation();

            // Start Google speech dialog and translation
            await controller.startGoogleSpeechDialog(context);

            // If translation was successful, assign it to the text controller
            if (controller.translatedText.value.isNotEmpty) {
              controller.textController.text = controller.translatedText.value;
            } else {
              // Get.snackbar(
              //   "No speech detected",
              //   "Please try again.",
              //   snackPosition: SnackPosition.BOTTOM,
              // );
            }
          }


          setState(() {
            _page = index;
          });
        },

      ),
    );
  }
}
