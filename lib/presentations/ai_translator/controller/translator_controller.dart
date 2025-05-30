import 'dart:async';
import 'dart:io';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:speech_to_text/speech_to_text.dart' as stt;
import 'package:translator/translator.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'languages_controller.dart';

class TranslatorController extends GetxController {

  final textController = TextEditingController();

  final stt.SpeechToText speech = stt.SpeechToText();
  final translator = GoogleTranslator();

  final isClickVolume = false.obs;

  final isListening = false.obs;
  final sourceText = ''.obs;
  final translatedText = ''.obs;
  late StreamSubscription<List<ConnectivityResult>> _connectivitySubscription;
  final showMidDialog = false.obs;
  final showNoInternetDialog = false.obs;

  final LanguageController langController = Get.find();

  Timer? silenceTimer;

  @override
  void onInit() {
    super.onInit();
  }

  Future<void> startListening() async {
    stopListening();

    isListening.value = false;
    showMidDialog.value = false;
    showNoInternetDialog.value = false;
    sourceText.value = '';
    translatedText.value = '';

    final hasInternet = await checkInternetConnection();
    if (!hasInternet) {
      showNoInternetDialog.value = true;
      return;
    }

    final sourceLangCode = langController.getLanguageCode(
      langController.selectedSource.value.countryCode,
    );
    final targetLangCode = langController.getLanguageCode(
      langController.selectedTarget.value.countryCode,
    );

    final available = await speech.initialize(
      onStatus: (status) {
        if (status == 'done' && sourceText.value.isEmpty) {
          showMidDialog.value = true;
        }
      },
      onError: (error) {
        showMidDialog.value = true;
        stopListening();
      },
    );

    if (!available) {
      showMidDialog.value = true;
      return;
    }

    isListening.value = true;

    silenceTimer = Timer(const Duration(seconds: 3), () {
      if (sourceText.value.isEmpty) {
        showMidDialog.value = true;
        stopListening();
      }
    });

    speech.listen(
      localeId: sourceLangCode,
      onResult: (result) {
        if (result.recognizedWords.isNotEmpty) {
          silenceTimer?.cancel();
          sourceText.value = result.recognizedWords;
          translateText(result.recognizedWords, targetLangCode);
        }
      },
    );
  }

  void stopListening() {
    if (isListening.value) {
      isListening.value = false;
      speech.stop();
      silenceTimer?.cancel();
    }
  }

  Future<void> translateText(String text, String targetLangCode) async {
    try {
      final translation = await translator.translate(text, to: targetLangCode);
      translatedText.value = translation.text;
    } catch (e) {
      translatedText.value = "Translation failed.";
    }
  }

  Future<bool> checkInternetConnection() async {
    final connectivityResult = await Connectivity().checkConnectivity();
    if (connectivityResult == ConnectivityResult.none) return false;
    try {
      final result = await InternetAddress.lookup('google.com');
      return result.isNotEmpty && result[0].rawAddress.isNotEmpty;
    } catch (_) {
      return false;
    }
  }


  void resetVoiceTranslation() {
    stopListening();
    sourceText.value = '';
    translatedText.value = '';
    showMidDialog.value = false;
    showNoInternetDialog.value = false;
  }

  void monitorInternetConnection() {
    _connectivitySubscription = Connectivity().onConnectivityChanged.listen((
      result,
    ) async {
      final hasRealInternet = await checkInternetConnection();
      if (hasRealInternet && showNoInternetDialog.value) {
        showNoInternetDialog.value = false;
        // Get.snackbar(
        //   "Internet Restored",
        //   "Retrying translation...",
        //   snackPosition: SnackPosition.BOTTOM,
        //   duration: Duration(seconds: 2),
        // );

        await startListening();
      } else if (!hasRealInternet && !showNoInternetDialog.value) {
        showNoInternetDialog.value = true;
        stopListening();
      }
    });
  }




  @override
  void onClose() {
    textController.dispose();
    silenceTimer?.cancel();
    _connectivitySubscription.cancel(); 
    super.onClose();
  }
}
