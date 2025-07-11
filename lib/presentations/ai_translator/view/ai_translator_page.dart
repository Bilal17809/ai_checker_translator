import 'package:ai_checker_translator/core/common_widgets/fluttertaost_message.dart';
import 'package:ai_checker_translator/core/common_widgets/life_cycle_mixin.dart';
import 'package:ai_checker_translator/presentations/ai_translator/controller/translation_contrl.dart';
import 'package:ai_checker_translator/presentations/ai_translator/widgets/translator_button.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ai_checker_translator/core/theme/app_colors.dart';
import 'package:ai_checker_translator/presentations/ai_translator/widgets/Languages_show_widgets.dart';
import 'package:ai_checker_translator/presentations/ai_translator/widgets/translation_history_widget.dart';
import 'package:ai_checker_translator/core/common_widgets/assistent_input_box_widget.dart';
import 'package:ai_checker_translator/core/common_widgets/common_widgets.dart';

// import '../controller/translator_controller.dart';

class AiTranslatorPage extends StatefulWidget {
  AiTranslatorPage({super.key});

  @override
  State<AiTranslatorPage> createState() => _AiTranslatorPageState();
}

class _AiTranslatorPageState extends State<AiTranslatorPage>
    with AppLifecycleMixin {
  final TranslationController controller = Get.put(TranslationController());

  @override
  void onAppPause() {
    controller.flutterTts.stop();
    controller.controller.clear();
    FocusScope.of(context).unfocus();
  }

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    final bottomInset = mediaQuery.viewInsets.bottom;
    final screenHeight = mediaQuery.size.height;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: kMintGreen,
        iconTheme: IconThemeData(color: kWhite),
        title: Text("Translator", style: TextStyle(color: Colors.white)),
        centerTitle: true,
      ),
      // drawer: Drawer(),
      resizeToAvoidBottomInset: true,
      body: SafeArea(
        child: Stack(
          children: [
            SingleChildScrollView(
              physics: NeverScrollableScrollPhysics(),
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const LanguageWidget(),
                  const SizedBox(height: 20),
                  Container(
                    height: 36,
                    decoration: BoxDecoration(
                      color: kMintGreen,
                      borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(10),
                        topRight: Radius.circular(10),
                      ),
                    ),
                    child: KeyValueText(
                      title: "Write Message",
                      value: "",
                      textColor: Colors.teal,
                      icons: [Icons.copy, Icons.close],
                      onIconTaps: [
                        () => controller.copyTextEditingControllerText(),
                        () => controller.clearData(),
                      ],
                    ),
                  ),
                  Obx(() {
                    final isSourceRTL = controller.isRTLLanguage(
                      controller.selectedLanguage1.value,
                    );
                    return AssistantInputBox(
                      hintText: "Tap on Below Mic to start Typing...",
                      textalign: isSourceRTL ? TextAlign.right : TextAlign.left,
                      textDirection:
                          isSourceRTL ? TextDirection.rtl : TextDirection.ltr,
                      borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(0),
                        topRight: Radius.circular(0),
                        bottomLeft: Radius.circular(16),
                        bottomRight: Radius.circular(16),
                      ),
                      controller: controller.controller,
                      footerButtons: [
                        TranslatorButton(
                          onTap: () {
                            final inputText = controller.controller.text;
                            if (inputText.isNotEmpty) {
                              controller.translate(inputText);
                              controller.onTranslateButtonPressed();
                              controller.speakText();
                              FocusScope.of(context).unfocus();
                              print("Translated");
                            } else {
                              FocusScope.of(context).unfocus();
                              Utils().toastMessage(
                                "Please enter text to translate.",
                              );
                              print("Empty input. Nothing to translate.");
                            }
                          },
                        ),
                      ],

                      iconButtons: [
                        // IconButton(
                        //   onPressed: controller.copyText,
                        //   icon: Icon(Icons.copy, color: kMediumGreen2),
                        // ),
                        // IconButton(
                        //   onPressed: controller.clearData,
                        //   icon: Icon(Icons.delete, color: kMediumGreen2),
                        // ),
                        // IconButton(
                        //   onPressed: controller.speakText,
                        //   icon: Icon(
                        //     Icons.volume_up_rounded,
                        //     color: kMediumGreen2,
                        //   ),
                        // ),
                      ],
                      showFooter: true,
                    );
                  }),
                  const SizedBox(height: 300),
                ],
              ),
            ),

            /// Scrollable Translation History at bottom
            Positioned(
              bottom: bottomInset,
              left: 0,
              right: 0,
              top: screenHeight * 0.46,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: TranslationHistoryWidget(
                  showFavouriteIcon: true,
                  showOnlyFavourites: false,
                  deleteFromFavouritesOnly: false,
                  overrideSpeakAndCopy: false,
                )
              ),
            ),
          ],
        ),
      ),
    );
  }
}

