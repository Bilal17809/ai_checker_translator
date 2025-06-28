import 'package:ai_checker_translator/core/common_widgets/fluttertaost_message.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:google_generative_ai/google_generative_ai.dart';
import 'package:flutter_tts/flutter_tts.dart';

import '../../../../core/globle_key/globle_key.dart';

class GeminiController extends GetxController {
  final TextEditingController promptController = TextEditingController();

  final responseText = ''.obs;
  final isLoading = false.obs;

  late final GenerativeModel model;

  final FlutterTts flutterTts = FlutterTts();
  static const MethodChannel _speechChannel =
      MethodChannel('com.example.getx_practice_app/speech_Text');

  final pitch = 0.5.obs;
  final speed = 0.5.obs;

  @override
  void onInit() {
    super.onInit();
    model = GenerativeModel(
      model: 'gemini-1.5-flash',
      apiKey: apiKey,
    );
  }

  Future<void> generateText() async {
  final prompt = promptController.text.trim();
  if (prompt.isEmpty) {
    return Utils().toastMessage("Enter text to generate");
  }

  isLoading.value = true;
  try {
    final content = [Content.text(prompt)];
    final response = await model.generateContent(content);
    responseText.value = response.text ?? "No response from model.";
  } catch (e) {
  
    if (e.toString().contains("quota") || e.toString().contains("429")) {
      responseText.value =
          "Quota exceeded.\nPlease check your API key and billing plan.\n\nVisit: https://ai.google.dev/gemini-api/docs/rate-limits";
    } else {
      responseText.value = " Error: ${e.toString()}";
    }
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
      Clipboard.setData(ClipboardData(text:promptController.text));
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
      await flutterTts.stop();
      await flutterTts.setLanguage(languageCode);
      await flutterTts.setPitch(pitch.value);
      await flutterTts.setSpeechRate(speed.value);

      if (promptController.text.trim().isNotEmpty) {
        await flutterTts.speak(promptController.text.trim());
      }
    } catch (e) {
      Utils().toastMessage("TTS Error: ${e.toString()}");
    }
  }

  @override
  void onClose() {
    promptController.dispose();
    flutterTts.stop();
    super.onClose();
  }
}
