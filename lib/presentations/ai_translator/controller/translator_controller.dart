import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:speech_to_text_google_dialog/speech_to_text_google_dialog.dart';
import 'package:translator/translator.dart';
import 'languages_controller.dart'; // ensure this path is correct

class TranslatorController extends GetxController {

  final textController = TextEditingController();
  final translator = GoogleTranslator();

  final LanguageController langController = Get.find();

  var isListening = false.obs;
  var sourceText = ''.obs;
  var translatedText = ''.obs;

Future<void> startGoogleSpeechDialog(BuildContext context) async {
  try {
    isListening.value = true;

    final sourceLangCode = langController.getLanguageCode(
      langController.selectedSource.value.countryCode,
    );
    final targetLangCode = langController.getLanguageCode(
      langController.selectedTarget.value.countryCode,
    );

    bool isServiceAvailable = await SpeechToTextGoogleDialog.getInstance()
        .showGoogleDialog(
      onTextReceived: (data) async {
        final spokenText = data.toString();
        sourceText.value = spokenText;
        await translateText(spokenText, targetLangCode);
      },
      locale: sourceLangCode,
    );

    if (!isServiceAvailable) {
      Get.snackbar(
        'Error',
        'Google Speech Dialog is not available.',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    }
  } catch (e, stackTrace) {
    debugPrint(" Error in startGoogleSpeechDialog: $e");
    debugPrint("StackTrace: $stackTrace");
    Get.snackbar(
      'Speech Error',
      e.toString(),
      snackPosition: SnackPosition.BOTTOM,
      backgroundColor: Colors.red,
      colorText: Colors.white,
    );
  } finally {
    isListening.value = false;
  }
}


  Future<void> translateText(String text, String targetLangCode) async {
    final translation = await translator.translate(text, to: targetLangCode);
    translatedText.value = translation.text;
    textController.text = translation.text;
  }

  void resetVoiceTranslation() {
    sourceText.value = '';
    translatedText.value = '';
    isListening.value = false;
  }

  @override
  void onClose() {
    textController.dispose();
    super.onClose();
  }
}
