// import 'dart:convert';
import 'package:ai_checker_translator/core/common_widgets/fluttertaost_message.dart';
import 'package:ai_checker_translator/core/common_widgets/no_internet_dialog.dart';
import 'package:ai_checker_translator/gen/assets.gen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:google_generative_ai/google_generative_ai.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:path/path.dart';
import 'package:share_plus/share_plus.dart';
import '../../../../domain/use_cases/get_mistral.dart';

// class GeminiController extends GetxController {
//   final TextEditingController promptController = TextEditingController();
//   final responseText = ''.obs;
//   final isLoading = false.obs;
//   final isSpeaking = false.obs;
//   final isTypingStarted = false.obs;
//   final isResponseReady = false.obs;
//   final RxInt generateCount = 3.obs;
//   final detectedText = ''.obs;
//
//   late final GenerativeModel model;
//   final MistralUseCase useCase;
//   final FlutterTts flutterTts = FlutterTts();
//
//   static const MethodChannel _speechChannel = MethodChannel(
//     'com.example.getx_practice_app/speech_Text',
//   );
//
//   final pitch = 0.5.obs;
//   final speed = 0.5.obs;
//
//   GeminiController(this.useCase);
//
//   @override
//   void onInit() {
//     super.onInit();
//     _initTts();
//   }
// Future<void> generate() async {
//     if (generateCount.value <= 0) {
//       Get.dialog(
//         CustomInfoDialog(
//           title: "Daily Limit Reached",
//           message: "You've reached your daily limit. Go Premium to continue.",
//           iconPath: Assets.premiumicon.path,
//           type: DialogType.premium,
//         ),
//         barrierDismissible: false,
//       );
//       return;
//     }
//
//     final prompt = promptController.text.trim();
//     if (prompt.isEmpty) {
//       Utils().toastMessage("Enter text to generate");
//       return;
//     }
//
//     final hasInternet = await Utils.checkAndShowNoInternetDialogIfOffline();
//     if (!hasInternet) return;
//
//     isLoading.value = true;
//     isTypingStarted.value = false;
//     isResponseReady.value = false;
//     responseText.value = '';
//
//     try {
//
//       generateCount.value--;
//
//       final limitedPrompt = _generatePromptWithLimit(prompt);
//
//       final result = await useCase(limitedPrompt, maxTokens: 200);
//
//       final lineLimited = _limitResponseLines(result, 20);
//       final finalLimited = _limitResponseCharacters(lineLimited, 800);
//
//       responseText.value = finalLimited;
//       isResponseReady.value = true;
//     } catch (e) {
//       responseText.value = "Error: ${e.toString()}";
//       isResponseReady.value = true;
//     } finally {
//       isLoading.value = false;
//     }
//   }
//
//
//   String _generatePromptWithLimit(String prompt) {
//     final lines = prompt.split('\n').length;
//     final words = prompt.split(RegExp(r'\s+')).length;
//     final chars = prompt.length;
//
//     if (words <= 3 && chars < 40) {
//       return "$prompt\n\nReply in 1-2 lines only.";
//     } else if (words <= 10 && chars < 100) {
//       return "$prompt\n\nKeep answer short (max 4-5 lines).";
//     } else if (words <= 30 || lines <= 3) {
//       return "$prompt\n\nAnswer briefly in 6-10 lines.";
//     } else if (words <= 60 || lines <= 6) {
//       return "$prompt\n\nGive a detailed but concise answer in 10-15 lines.";
//     } else {
//       return "$prompt\n\nSummarize and answer clearly in max 15-20 lines only.";
//     }
//   }
//
//   String _limitResponseLines(String text, int maxLines) {
//     final lines = text.split('\n');
//     if (lines.length <= maxLines) return text;
//     return lines.take(maxLines).join('\n');
//   }
//
//   String _limitResponseCharacters(String text, int maxChars) {
//     if (text.length <= maxChars) return text;
//     return text.substring(0, maxChars).trim() + '...';
//   }
//
//   void startAnimation() {
//     isTypingStarted.value = true;
//   }
//
//   void copyPromptText() {
//     Utils.copyTextFrom(text: promptController.text);
//   }
//
//   void copyResponseText() {
//     Utils.copyTextFrom(text: responseText.value);
//   }
//
//   Future<void> startMicInput({String languageISO = 'en-US'}) async {
//
//     final hasInternet = await Utils.checkAndShowNoInternetDialogIfOffline();
//     if (!hasInternet) return;
//
//     try {
//       final result = await _speechChannel.invokeMethod('getTextFromSpeech', {
//         'languageISO': languageISO,
//       });
//
//       if (result != null && result.isNotEmpty) {
//         promptController.text = result;
//       }
//     } on PlatformException catch (e) {
//       print("Mic Error: ${e.message}");
//     }
//   }
//
//   Future<void> speakGeneratedText({String languageCode = 'en-US'}) async {
//     try {
//       if (isSpeaking.value) {
//         await flutterTts.stop();
//         isSpeaking.value = false;
//         return;
//       }
//
//       final text = responseText.value.trim();
//       if (text.isEmpty) return;
//
//       await flutterTts.setLanguage(languageCode);
//       await flutterTts.setPitch(pitch.value);
//       await flutterTts.setSpeechRate(speed.value);
//
//       isSpeaking.value = true;
//       await flutterTts.speak(text);
//
//       flutterTts.setCompletionHandler(() {
//         isSpeaking.value = false;
//       });
//     } catch (e) {
//       Utils().toastMessage("TTS Error: ${e.toString()}");
//       isSpeaking.value = false;
//     }
//   }
//
//   Future<void> shareGeneratedText() async {
//     try {
//       final text = responseText.value.trim();
//       if (text.isEmpty) {
//         Utils().toastMessage("No content to share.");
//         return;
//       }
//       await SharePlus.instance.share(ShareParams(text: text));
//     } catch (e) {
//       Utils().toastMessage("Sharing failed: ${e.toString()}");
//       debugPrint('Sharing error: $e');
//     }
//   }
//
//   Future<void> _initTts() async {
//     await flutterTts.setSharedInstance(true);
//     await flutterTts.setLanguage('en-US');
//     await flutterTts.setPitch(pitch.value);
//     await flutterTts.setSpeechRate(speed.value);
//   }
//
//   @override
//   void onClose() {
//     responseText.close();
//     promptController.dispose();
//     flutterTts.stop();
//     super.onClose();
//   }
//
//   void resetData() {
//     responseText.value = '';
//     promptController.clear();
//     isTypingStarted.value = false;
//     isResponseReady.value = false;
//     flutterTts.stop();
//   }
// }
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../ads_manager/splash_interstitial.dart';
import '../../../core/animation/animation_games.dart';

class GeminiController extends GetxController {
  final TextEditingController promptController = TextEditingController();
  final responseText = ''.obs;
  final isLoading = false.obs;
  final isSpeaking = false.obs;
  final isTypingStarted = false.obs;
  final isResponseReady = false.obs;

  final detectedText = ''.obs;
  final pitch = 0.5.obs;
  final speed = 0.5.obs;

  late final GenerativeModel model;
  final MistralUseCase useCase;
  final FlutterTts flutterTts = FlutterTts();

  static const MethodChannel _speechChannel = MethodChannel(
    'com.example.getx_practice_app/speech_Text',
  );

  final splashAd = Get.find<SplashInterstitialAdController>();

  final RxInt interactionCount = 0.obs;
  final int maxFreeInteractions = 2;
  RxBool isPostAdAllowed = false.obs;

  GeminiController(this.useCase);

  @override
  void onInit() {
    super.onInit();
    _initTts();
    loadInteractionCount();
    splashAd.loadInterstitialAd();
  }

  Future<void> loadInteractionCount() async {
    final prefs = await SharedPreferences.getInstance();
    interactionCount.value = prefs.getInt('gemini2InteractionCount') ?? 0;
  }

  Future<void> incrementInteractionCount() async {
    final prefs = await SharedPreferences.getInstance();
    interactionCount.value++;
    await prefs.setInt('gemini2InteractionCount', interactionCount.value);
  }

  Future<void> resetInteractionCount() async {
    final prefs = await SharedPreferences.getInstance();
    interactionCount.value = 0;
    await prefs.setInt('gemini2InteractionCount', 0);
  }

  Future<void> generate(BuildContext context) async {
    if (interactionCount.value >= maxFreeInteractions && !isPostAdAllowed.value) {
      Get.dialog(
        CustomInfoDialog(
          title: "Limit Reached",
          message: "You've reached your daily limit. Please watch an ad to continue or go Premium.",
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
              if (promptController.text.isNotEmpty) {
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

    final prompt = promptController.text.trim();
    if (prompt.isEmpty) {
      Utils().toastMessage("Enter text to generate");
      return;
    }

    final hasInternet = await Utils.checkAndShowNoInternetDialogIfOffline();
    if (!hasInternet) return;

    isLoading.value = true;
    isTypingStarted.value = false;
    isResponseReady.value = false;
    responseText.value = '';

    try {
      final limitedPrompt = _generatePromptWithLimit(prompt);
      final result = await useCase(limitedPrompt, maxTokens: 200);

      final lineLimited = _limitResponseLines(result, 20);
      final finalLimited = _limitResponseCharacters(lineLimited, 800);

      responseText.value = finalLimited;
      isResponseReady.value = true;
    } catch (e) {
      responseText.value = "Error: ${e.toString()}";
      isResponseReady.value = true;
    } finally {
      isLoading.value = false;
    }
  }

  String _generatePromptWithLimit(String prompt) {
    final lines = prompt.split('\n').length;
    final words = prompt.split(RegExp(r'\s+')).length;
    final chars = prompt.length;

    if (words <= 3 && chars < 40) {
      return "$prompt\n\nReply in 1-2 lines only.";
    } else if (words <= 10 && chars < 100) {
      return "$prompt\n\nKeep answer short (max 4-5 lines).";
    } else if (words <= 30 || lines <= 3) {
      return "$prompt\n\nAnswer briefly in 6-10 lines.";
    } else if (words <= 60 || lines <= 6) {
      return "$prompt\n\nGive a detailed but concise answer in 10-15 lines.";
    } else {
      return "$prompt\n\nSummarize and answer clearly in max 15-20 lines only.";
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

  void startAnimation() {
    isTypingStarted.value = true;
  }

  void copyPromptText() {
    Utils.copyTextFrom(text: promptController.text);
  }

  void copyResponseText() {
    Utils.copyTextFrom(text: responseText.value);
  }

  Future<void> startMicInput({String languageISO = 'en-US'}) async {
    final hasInternet = await Utils.checkAndShowNoInternetDialogIfOffline();
    if (!hasInternet) return;

    try {
      final result = await _speechChannel.invokeMethod('getTextFromSpeech', {
        'languageISO': languageISO,
      });

      if (result != null && result.isNotEmpty) {
        promptController.text = result;
      }
    } on PlatformException catch (e) {
      print("Mic Error: ${e.message}");
    }
  }

  Future<void> speakGeneratedText({String languageCode = 'en-US'}) async {
    try {
      if (isSpeaking.value) {
        await flutterTts.stop();
        isSpeaking.value = false;
        return;
      }

      final text = responseText.value.trim();
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

  Future<void> shareGeneratedText() async {
    try {
      final text = responseText.value.trim();
      if (text.isEmpty) {
        Utils().toastMessage("No content to share.");
        return;
      }
      await SharePlus.instance.share(ShareParams(text: text));
    } catch (e) {
      Utils().toastMessage("Sharing failed: ${e.toString()}");
      debugPrint('Sharing error: $e');
    }
  }

  Future<void> _initTts() async {
    await flutterTts.setSharedInstance(true);
    await flutterTts.setLanguage('en-US');
    await flutterTts.setPitch(pitch.value);
    await flutterTts.setSpeechRate(speed.value);
  }

  @override
  void onClose() {
    responseText.close();
    promptController.dispose();
    flutterTts.stop();
    super.onClose();
  }

  void resetData() {
    responseText.value = '';
    promptController.clear();
    isTypingStarted.value = false;
    isResponseReady.value = false;
    flutterTts.stop();
  }
}

