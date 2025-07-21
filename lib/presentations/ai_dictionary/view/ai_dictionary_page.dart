import 'dart:io';

import 'package:ai_checker_translator/core/common_widgets/assistent_input_box_widget.dart';
import 'package:ai_checker_translator/core/common_widgets/back_to_home_wrapper.dart';
import 'package:ai_checker_translator/core/common_widgets/common_appbar_widget.dart';
import 'package:ai_checker_translator/core/common_widgets/keyboard_dismiss_wrapper.dart';
import 'package:ai_checker_translator/core/common_widgets/life_cycle_mixin.dart';
import 'package:ai_checker_translator/core/common_widgets/voicedialog_for_ios.dart';
import 'package:ai_checker_translator/core/theme/app_colors.dart';
import 'package:ai_checker_translator/core/theme/app_theme.dart';
import 'package:ai_checker_translator/presentations/ai_dictionary/contrl/ai_dictioanay_contrl.dart';
import 'package:ai_checker_translator/presentations/ai_dictionary/contrl/animation_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:share_plus/share_plus.dart';

import '../../../ads_manager/banner_ads.dart';
import '../../../ads_manager/interstitial_ads.dart';
import '../../aska/widgets/text_generated_widget.dart';

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
  void initState() {
        Get.find<InterstitialAdController>().checkAndShowAd();
        super.initState();
  }

  @override
  void onAppPause() {
    controller.flutterTts.stop();
    controller.textCheckPromptController.clear();
    FocusScope.of(context).unfocus();
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
    final mediaQuery = MediaQuery.of(context);
    final bottomInset = mediaQuery.viewInsets.bottom;
    final screenHeight = mediaQuery.size.height;

    return BackToHomeWrapper(
      child: KeyboardDismissWrapper(
        child: SafeArea(
          child: Scaffold(
            appBar: CommonAppbarWidget(),
            body: Stack(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 20,
                    vertical: 20,
                  ),
                  child: SingleChildScrollView(
                    physics: NeverScrollableScrollPhysics(),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        const Text(
                          "Hi i'm Ai Corrector",
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
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

                        const SizedBox(height: 14),
                        ValueListenableBuilder<TextEditingValue>(
                          valueListenable: controller.textCheckPromptController,
                          builder: (context, value, _) {
                            return AssistantInputBox(
                              contentPadding: const EdgeInsets.fromLTRB(
                                6,
                                0,
                                22,
                                0,
                              ),
                              hintText: "Type here or paste your content",
                              controller: controller.textCheckPromptController,
                              iconButtons: [],
                              showClearIcon: value.text.isNotEmpty,
                              footerButtons: [
                                IconButton(
                                  onPressed: () {
                                    if (Platform.isAndroid) {
                                      controller.startMicInput(
                                        languageISO: 'en-US',
                                      );
                                    } else {
                                      VoiceDialogHelper().showVoiceInputDialog(
                                        context: context,
                                        languageCode: 'en-US',
                                        onResult: (detectedText) {
                                          controller
                                              .textCheckPromptController
                                              .value = TextEditingValue(
                                            text: detectedText,
                                          );
                                        },
                                      );
                                    }
                                  },
                                  icon: const Icon(
                                    Icons.mic,
                                    size: 20,
                                    color: kMintGreen,
                                  ),
                                ),
                                const Spacer(),
                                IconButton(
                                  onPressed: controller.copyPromptText,
                                  icon: const Icon(
                                    Icons.copy,
                                    size: 20,
                                    color: kMintGreen,
                                  ),
                                ),
                              ],
                            );
                          },
                        ),

                        const SizedBox(height: 10),
                        Obx(() => Text.rich(
                          TextSpan(
                            text:
                            "Daily Limits Remaining = ${controller.maxFreeInteractions - controller.interactionCount.value} ",
                            style: const TextStyle(fontSize: 12),
                            children: [
                              const TextSpan(
                                text: "Go Premium",
                                style: TextStyle(
                                  color: Colors.red,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                        )),

                        const SizedBox(height: 10),

                        Obx(
                          () => SizedBox(
                            height: 48,
                            // width: 100,
                            child: ElevatedButton(
                              onPressed: () {
                                controller.generate(context);
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
                  top: screenHeight * 0.48,
                  child: Obx(
                    () =>
                        controller.grammarResponseText.isEmpty
                            ? const SizedBox()
                            : Padding(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 20,
                              ),
                              child: SingleChildScrollView(
                                child: GeneratedTextWidget(
                                  onTapShare: () {
                                    Share.share(
                                      controller.grammarResponseText.value,
                                    );
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
            bottomNavigationBar:
            Get.find<InterstitialAdController>().isAdReady
                ? SizedBox()
                : Obx(() {
              return Get.find<BannerAdController>().getBannerAdWidget('ad1');
            }),
          ),
        ),
      ),

    );
  }
}
