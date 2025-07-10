import 'dart:convert';
import 'package:ai_checker_translator/core/common_widgets/fluttertaost_message.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:google_generative_ai/google_generative_ai.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:share_plus/share_plus.dart';
import '../../../../domain/use_cases/get_mistral.dart';

class GeminiController extends GetxController {
  final TextEditingController promptController = TextEditingController();
  final responseText = ''.obs;
  final isLoading = false.obs;
  final isSpeaking = false.obs;
  final isTypingStarted = false.obs;
  final isResponseReady = false.obs; // Track if response is fully generated
  
  late final GenerativeModel model;
  final MistralUseCase useCase;
  final FlutterTts flutterTts = FlutterTts();
  
  static const MethodChannel _speechChannel = MethodChannel(
    'com.example.getx_practice_app/speech_Text',
  );

  final pitch = 0.5.obs;
  final speed = 0.5.obs;

  GeminiController(this.useCase);

  @override
  void onInit() {
    super.onInit();
    _initTts();
  }

  Future<void> generate() async {
    final prompt = promptController.text.trim();
    if (prompt.isEmpty) {
      Utils().toastMessage("Enter text to generate");
      return;
    }

    isLoading.value = true;
    isTypingStarted.value = false;
    isResponseReady.value = false;
    responseText.value = '';

    try {
      final result = await useCase(prompt);
      responseText.value = result;
      isResponseReady.value = true; // Response is ready
    } catch (e) {
      responseText.value = "Error: ${e.toString()}";
      isResponseReady.value = true;
    } finally {
      isLoading.value = false;
    }
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
