import 'package:ai_checker_translator/gen/assets.gen.dart';
import 'package:ai_checker_translator/presentations/ai_dictionary/contrl/ai_dictioanay_contrl.dart';
import 'package:ai_checker_translator/presentations/ai_dictionary/view/ai_dictionary_page.dart';
import 'package:ai_checker_translator/presentations/ai_translator/view/curved_bottom_navbar.dart';
import 'package:ai_checker_translator/presentations/aska/view/ask_ai_screen.dart';
import 'package:ai_checker_translator/presentations/home/view/home_view.dart';
import 'package:ai_checker_translator/presentations/paraphrase/view/paraphrase_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:panara_dialogs/panara_dialogs.dart';
import '../../core/theme/app_colors.dart';
import '../aska/controller/gemini_controller.dart';

class BottomNavExample extends StatefulWidget {
  const BottomNavExample({super.key});
  static final GlobalKey<_BottomNavExampleState> bottomNavKey =
      GlobalKey<_BottomNavExampleState>();

  @override
  State<BottomNavExample> createState() => _BottomNavExampleState();
}

final geminicontroller = Get.find<GeminiController>();
final geminiAiCorrectionController = Get.find<GeminiAiCorrectionController>();

class _BottomNavExampleState extends State<BottomNavExample> {
  int selectedIndex = 2;
  int previousIndex = 3;
  Key animatedKey = UniqueKey();

  final List<String> images = [
    Assets.askai.path,
    Assets.paraphraser.path,
    Assets.home.path,
    Assets.correction.path,
    Assets.translator.path,
  ];

  final List<String> labels = [
    "Ask AI",
    "Learn Grammar",
    "Home",
    "AI Correction",
    "Translator",
  ];

  void goToHome() {
    setState(() {
      selectedIndex = 2;
    });
  }


  void hideKeyboardProperly() {
    FocusScope.of(context).unfocus();
    SystemChannels.textInput.invokeMethod('TextInput.hide');
  }

  @override
  Widget build(BuildContext context) {
    final bool isTranslatorPage = selectedIndex == 4;

    final List<Widget> screens = [
      AskAiScreen(key: animatedKey),
      ParaphraseView(),
      HomeView(),
      AiDictionaryPage(key: animatedKey),
      Container(),
    ];

    return WillPopScope(
      onWillPop: () async {
        if (selectedIndex != 2) {
          hideKeyboardProperly();
          geminiAiCorrectionController.resetController();
          geminicontroller.resetData();
          setState(() => selectedIndex = 2);
          return false;
        }
        hideKeyboardProperly();
        PanaraConfirmDialog.show(
          context,
          title: "Exit App",
          message: "Do you really want to exit the app?",
          confirmButtonText: "Exit",
          cancelButtonText: "No",
          onTapCancel: () => Navigator.of(context).pop(),
          onTapConfirm: () {
            Navigator.of(context).pop();
            SystemNavigator.pop();
          },
          panaraDialogType: PanaraDialogType.custom,
          color: kMintGreen,
          barrierDismissible: false,
        );
        return false;
      },
      child: SafeArea(
        child: Scaffold(
          body: IndexedStack(index: selectedIndex, children: screens),
          bottomNavigationBar:
              isTranslatorPage
                  ? null
                  : Container(
                    margin: const EdgeInsets.only(
                      left: 10,
                      right: 10,
                      bottom: 10,
                    ),
                    padding: const EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 10,
                    ),
                    decoration: BoxDecoration(
                      color: const Color(0xffF9DEDF),
                      borderRadius: BorderRadius.circular(20),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.2),
                          blurRadius: 6,
                          offset: const Offset(0, 6),
                        ),
                      ],
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: List.generate(images.length, (index) {
                        final isSelected = selectedIndex == index;
                        return GestureDetector(
                          onTap: () {
                            geminicontroller.resetData();
                            geminiAiCorrectionController.resetController();
                            hideKeyboardProperly();

                            final wasOnCorrection = selectedIndex == 3;

                            if (index == 4) {
                              Get.to(() => const AiTranslatorBottomNav())!.then(
                                (_) {
                                  hideKeyboardProperly();
                                  geminicontroller.resetData();
                                  setState(() {
                                    previousIndex = selectedIndex;
                                    selectedIndex = 2;

                                    if (selectedIndex == 3) {
                                      geminiAiCorrectionController
                                          .resetController();
                                    }

                                    if (previousIndex == 0 ||
                                        previousIndex == 3) {
                                      animatedKey = UniqueKey();
                                    }
                                  });
                                },
                              );
                            } else {
                              if (selectedIndex != index) {
                                setState(() {
                                  previousIndex = selectedIndex;
                                  selectedIndex = index;

                                  if (wasOnCorrection) {
                                    geminiAiCorrectionController
                                        .resetController();
                                  }

                                  if (previousIndex == 0) {
                                    geminiAiCorrectionController
                                        .resetController();
                                    geminicontroller.resetData();
                                  }

                                  if (index == 0 || index == 3) {
                                    animatedKey = UniqueKey();
                                  }

                                  if (previousIndex == 3) {
                                    geminiAiCorrectionController
                                        .resetController();
                                  }
                                });
                              }
                            }
                          },
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              isSelected
                                  ? ColorFiltered(
                                    colorFilter: const ColorFilter.mode(
                                      Color(0xFF006400),
                                      BlendMode.srcIn,
                                    ),
                                    child: Image.asset(
                                      images[index],
                                      height: 28,
                                      width: 28,
                                    ),
                                  )
                                  : Image.asset(
                                    images[index],
                                    height: 24,
                                    width: 24,
                                  ),
                              const SizedBox(height: 4),
                              SizedBox(
                                width: 60,
                                child: Text(
                                  labels[index],
                                  overflow: TextOverflow.ellipsis,
                                  maxLines: 1,
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    fontSize: 12,
                                    color:
                                        isSelected
                                            ? const Color(0xFF006400)
                                            : const Color(0xFF228B22),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        );
                      }),
                    ),
                ),
        ),
      ),
    );
  }
}
