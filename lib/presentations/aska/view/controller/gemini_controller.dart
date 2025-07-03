import 'dart:convert';

import 'package:ai_checker_translator/core/common_widgets/fluttertaost_message.dart';
import 'package:ai_checker_translator/misteral_api_data/api_services/use_casses/api_use_casses.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:google_generative_ai/google_generative_ai.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:share_plus/share_plus.dart';
// import 'package:share_plus_platform_interface/share_plus_platform_interface.dart';
import '../../../../core/globle_key/globle_key.dart';
import 'package:http/http.dart' as http;

class GeminiController extends GetxController {

  final TextEditingController promptController = TextEditingController();
  final TextEditingController textCheckPromptController =
      TextEditingController();

  final responseText = ''.obs;
  final isLoading = false.obs;
  final isSpeaking = false.obs;
    
  
  late final GenerativeModel model;
  final MistralUseCase useCase;

  final FlutterTts flutterTts = FlutterTts();
  static const MethodChannel _speechChannel = MethodChannel(
    'com.example.getx_practice_app/speech_Text',
  );

  final pitch = 0.5.obs;
  final speed = 0.5.obs;

  @override
  void onInit() {
    super.onInit();
    // useCase = Get.find<MistralUseCase>();
    // model = GenerativeModel(model: 'mistral-small-3.2', apiKey: apiKey);
    _initTts();
  }



  GeminiController(this.useCase);

  Future<void> generate() async {
    final prompt = promptController.text.trim();
    if (prompt.isEmpty) {
      Get.snackbar("Error", "Please enter a prompt");
      return;
    }

    isLoading.value = true;
    try {
      final result = await useCase(prompt);
      responseText.value = result;
    } catch (e) {
      responseText.value = e.toString();
    } finally {
      isLoading.value = false;
    }
  }




  void copyText() {
    if (responseText.isNotEmpty) {
      Clipboard.setData(ClipboardData(text: responseText.value));
      Utils().toastMessage("Copied\nResponse text copied to clipboard!");
    }
  }

  void copyTextwithassitantbox() {
    if (promptController.text.isNotEmpty) {
      Clipboard.setData(ClipboardData(text: promptController.text));
      Utils().toastMessage("Copied\n text copied to clipboard!");
    }
  }

  /// 🎙️ Start voice input using speech-to-text
  Future<void> startMicInput({String languageISO = 'en-US'}) async {
    try {
      final result = await _speechChannel.invokeMethod('getTextFromSpeech', {
        'languageISO': languageISO,
      });

      if (result != null && result.isNotEmpty) {
        promptController.text = result;
        // Optional: trigger generation
        // await generateText();
      }
    } on PlatformException catch (e) {
      print("Mic Error: ${e.message}");
    }
  }

  /// 🔊 Speak the generated response
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

      /// Listen for when speaking completes
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

  //
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

  
}
