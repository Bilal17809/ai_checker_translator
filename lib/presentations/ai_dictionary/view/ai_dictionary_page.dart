import 'package:ai_checker_translator/core/common_widgets/assistent_input_box_widget.dart';
import 'package:ai_checker_translator/core/common_widgets/common_appbar_widget.dart';
import 'package:ai_checker_translator/core/common_widgets/keyboard_dismiss_wrapper.dart';
import 'package:ai_checker_translator/core/common_widgets/life_cycle_mixin.dart';
// import 'package:ai_checker_translator/core/routes/routes_name.dart';
import 'package:ai_checker_translator/core/theme/app_colors.dart';
import 'package:ai_checker_translator/core/theme/app_theme.dart';
import 'package:ai_checker_translator/presentations/ai_dictionary/contrl/ai_dictioanay_contrl.dart';
import 'package:ai_checker_translator/presentations/ai_dictionary/contrl/animation_controller.dart';
import 'package:ai_checker_translator/presentations/aska/view/widgets/text_generated_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:share_plus/share_plus.dart';

class AiDictionaryPage extends StatefulWidget {
  const AiDictionaryPage({super.key});

  @override
  State<AiDictionaryPage> createState() => _AiDictionaryPageState();
}

class _AiDictionaryPageState extends State<AiDictionaryPage>
    with AppLifecycleMixin {

  // final animatedController = Get.find<AnimatedTextController>();
  final GeminiAiCorrectionController controller =
      Get.find<GeminiAiCorrectionController>();
  
    
  @override
  void onAppPause() {
    controller.flutterTts.stop();
    controller.textCheckPromptController.clear();
    FocusScope.of(context).unfocus();
  }

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    final bottomInset = mediaQuery.viewInsets.bottom;
    final screenHeight = mediaQuery.size.height;
    
    return KeyboardDismissWrapper(
      child: Scaffold(
      appBar: CommonAppbarWidget(),
      body: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
            child: SingleChildScrollView(
              physics: NeverScrollableScrollPhysics(),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  const Text(
                    "Hi i'm Ai Corrector",
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  AnimatedTypingText(
                    key: widget.key,
                    text:
                        "I can correct your grammar, spelling, punctuation, and more",
                    charDuration: Duration(milliseconds: 50),
                      style: context.textTheme.bodySmall!.copyWith(
                        color: kBlue,
                      ),
                  ),

                  const SizedBox(height: 20),
                  AssistantInputBox(
                    hintText: "Type here or paste your content",
                    controller: controller.textCheckPromptController,
                    iconButtons: [],
                    showClearIcon: true,
                    footerButtons: [
                      IconButton(
                        onPressed: () {
                          controller.startMicInput(languageISO: 'en-US');
                        },
                        icon: Icon(Icons.mic, size: 20, color: kMintGreen),
                      ),
                      const Spacer(),
                      IconButton(
                        onPressed: () {
                            controller.copyPromptText();
                        },
                        icon: Icon(Icons.copy, size: 20, color: kMintGreen),
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                  Text.rich(
                    TextSpan(
                      text: "Daily Limits Remaining = 10 ",
                      style: const TextStyle(fontSize: 12),
                      children: [
                        TextSpan(
                          text: "Go Premium",
                          style: const TextStyle(
                            color: Colors.red,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 10),

                  Obx(
                    () => SizedBox(
                      height: 48,
                      // width: 100,
                      child: ElevatedButton(
                        onPressed: () {
                          controller.generate();
                          FocusScope.of(context).unfocus();
                        },
                        style: AppTheme.elevatedButtonStyle.copyWith(
                          backgroundColor: MaterialStateProperty.all(
                            kMintGreen,
                          ),
                        ),
                        child:
                            controller.isLoading.value
                                ? const Center(
                                  child: CircularProgressIndicator(
                                    color: kWhite,
                                  ),
                                )
                                : const Text('Generate'),
                      ),
                    ),
                  ),

                  const SizedBox(height: 300),
                ],
              ),
            ),
          ),
          Positioned(
            bottom: bottomInset,
            left: 0,
            right: 0,
              top: screenHeight * 0.52,
            child: Obx(
              () =>
                  controller.grammarResponseText.isEmpty
                      ? const SizedBox()
                      : Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: SingleChildScrollView(
                          child: GeneratedTextWidget(
                            onTapShare: () {
                              Share.share(controller.grammarResponseText.value);
                            },
                            onTapCopy: () {
                                controller.copyResponseText();
                            },
                            onTapstartSpeak: () {
                              controller.speakGeneratedText();
                            },
                            text: controller.grammarResponseText.value,
                          ),
                        ),
                      ),
            ),
          ),
        ],
      ),
      
      )
    );
  }
}
