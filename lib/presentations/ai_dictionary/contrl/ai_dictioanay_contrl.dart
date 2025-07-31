import 'dart:io';

import 'package:ai_checker_translator/core/common_widgets/fluttertaost_message.dart';
import 'package:ai_checker_translator/core/common_widgets/no_internet_dialog.dart';
import 'package:ai_checker_translator/gen/assets.gen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:get/get.dart';
import 'package:google_generative_ai/google_generative_ai.dart';
import '../../../ads_manager/splash_interstitial.dart';
import '../../../core/animation/animation_games.dart';
import '../../../domain/use_cases/get_mistral.dart';
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class GeminiAiCorrectionController extends GetxController {
  final textCheckPromptController = TextEditingController();
  final splashAd = Get.find<SplashInterstitialAdController>();
  final FlutterTts flutterTts = FlutterTts();
  final MistralUseCase useCase;

  GeminiAiCorrectionController(this.useCase);

  static const MethodChannel _speechChannel = MethodChannel(
    'com.modernschool.aigrammar.learnenglish/speech_Text',
  );

  late final GenerativeModel model;

  final pitch = 0.5.obs;
  final speed = 0.5.obs;
  final grammarResponseText = "".obs;
  final isLoading = false.obs;
  final isSpeaking = false.obs;
  final isTypingStarted = false.obs;

  final RxInt interactionCount = 0.obs;
  final int maxFreeInteractions = 2;
  RxBool isPostAdAllowed = false.obs;

  @override
  void onInit() {
    splashAd.loadInterstitialAd();
    loadInteractionCount();
    super.onInit();
  }

  Future<void> loadInteractionCount() async {
    final prefs = await SharedPreferences.getInstance();
    interactionCount.value = prefs.getInt('geminiInteractionCount') ?? 0;
  }

  Future<void> incrementInteractionCount() async {
    final prefs = await SharedPreferences.getInstance();
    interactionCount.value++;
    await prefs.setInt('geminiInteractionCount', interactionCount.value);
  }

  Future<void> resetInteractionCount() async {
    final prefs = await SharedPreferences.getInstance();
    interactionCount.value = 0;
    await prefs.setInt('geminiInteractionCount', 0);
  }

  // 🎤 Start mic input
  Future<void> startMicInput({String languageISO = 'en-US'}) async {
    final hasInternet = await Utils.checkAndShowNoInternetDialogIfOffline();
    if (!hasInternet) return;
    try {
      final result = await _speechChannel.invokeMethod('getTextFromSpeech', {
        'languageISO': languageISO,
      });

      if (result != null && result.isNotEmpty) {
        textCheckPromptController.text = result;
      }
    } on PlatformException catch (e) {
      print("Mic Error: ${e.message}");
    }
  }

  // 🗣️ Speak generated text
  Future<void> speakGeneratedText({String languageCode = 'en-US'}) async {
    try {
      if (isSpeaking.value) {
        await flutterTts.stop();
        isSpeaking.value = false;
        return;
      }

      final text = grammarResponseText.value.trim();
      if (text.isEmpty) return;

      await flutterTts.setLanguage(languageCode);
      await flutterTts.setPitch(pitch.value);
      await flutterTts.setSpeechRate(speed.value);

      isSpeaking.value = true;

      await flutterTts.speak(text);

      flutterTts.setCompletionHandler(() {
        isSpeaking.value = false;
      });
    } catch (e) {
      Utils().toastMessage("TTS Error: ${e.toString()}");
      isSpeaking.value = false;
    }
  }

  Future<void> generate(BuildContext context) async {
    if (interactionCount.value >= maxFreeInteractions && !isPostAdAllowed.value) {
      Get.dialog(
        CustomInfoDialog(
          title: "Limit Reached",
          message:Platform.isIOS?
          "You’ve used your 2 free messages. Please watch an ad to continue or go Premium."
          :"You've reached your daily limit. Please watch an ad",
          iconPath: Assets.premiumicon.path,
          type: DialogType.premium,
          onSecondaryPressed: () {
            Navigator.of(context).pop();
            if (!splashAd.isAdReady) {
              showAdNotReadyDialog(context);
              return;
            }
            splashAd.showInterstitialAdUser(onAdComplete: () async {
              await resetInteractionCount();
              isPostAdAllowed.value = true;
              if (textCheckPromptController.text.isNotEmpty) {
                await generate(context);
              }
            });
          },
        ),
        barrierDismissible: false,
      );
      return;
    } else if (isPostAdAllowed.value) {
      isPostAdAllowed.value = false;
    } else {
      await incrementInteractionCount();
    }

    final inputText = textCheckPromptController.text.trim();
    if (inputText.isEmpty) {
      Utils().toastMessage("Enter text to generate");
      return;
    }

    final hasInternet = await Utils.checkAndShowNoInternetDialogIfOffline();
    if (!hasInternet) return;

    isLoading.value = true;
    isTypingStarted.value = false;
    grammarResponseText.value = '';

    try {
      final correctedPrompt = _buildCorrectionPromptWithLimit(inputText);

      final result = await useCase(correctedPrompt, maxTokens: 150);
      final lineLimited = _limitResponseLines(result, 10);
      final charLimited = _limitResponseCharacters(lineLimited, 500);

      grammarResponseText.value = charLimited;
      isTypingStarted.value = true;
    } catch (e) {
      grammarResponseText.value = "Error: ${e.toString()}";
    } finally {
      isLoading.value = false;
    }
  }

  // 📋 Prompt building helpers
  String _buildCorrectionPromptWithLimit(String input) {
    final words = input.split(RegExp(r'\s+')).length;
    final lines = input.split('\n').length;
    final chars = input.length;

    if (words <= 3 && chars < 40) {
      return '''
Correct the following short word or phrase. 
Return only corrected version in 1 line without explanation:
"$input"
''';
    } else if (words <= 15 && lines <= 2) {
      return '''
Fix grammar/spelling of the following short sentence.
Return corrected sentence only. No explanation.
"$input"
''';
    } else {
      return '''
Correct grammar and spelling in the following paragraph.
Return only the corrected version without any explanation in max 5–10 lines.
"$input"
''';
    }
  }

  String _limitResponseLines(String text, int maxLines) {
    final lines = text.split('\n');
    if (lines.length <= maxLines) return text;
    return lines.take(maxLines).join('\n');
  }

  String _limitResponseCharacters(String text, int maxChars) {
    if (text.length <= maxChars) return text;
    return text.substring(0, maxChars).trim() + '...';
  }

  // 📋 Copy to clipboard
  void copyResponseText() {
    Utils.copyTextFrom(text: grammarResponseText.value);
  }

  void copyPromptText() {
    Utils.copyTextFrom(text: textCheckPromptController.text);
  }

  // 🔄 Reset state
  void resetController() {
    grammarResponseText.value = '';
    isTypingStarted.value = false;
    textCheckPromptController.clear();
    flutterTts.stop();
  }

  @override
  void onClose() {
    grammarResponseText.close();
    textCheckPromptController.dispose();
    super.onClose();
  }
}





