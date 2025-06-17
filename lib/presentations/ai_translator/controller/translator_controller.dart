import 'dart:async';
import 'dart:io';
import 'package:ai_checker_translator/presentations/aska/view/ask_ai_screen.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:get/get.dart';
import 'package:speech_to_text/speech_to_text.dart' as stt;
import 'package:translator/translator.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'languages_controller.dart';

class TranslatorController extends GetxController {

  final textController = TextEditingController();

  // final stt.SpeechToText speech = stt.SpeechToText();
  final translator = GoogleTranslator();
  FlutterTts flutterTts = FlutterTts();


  final isListening = false.obs;
  final isLoading = false.obs;
  final sourceText = ''.obs;
  final translatedText = ''.obs;
  // late StreamSubscription<List<ConnectivityResult>> _connectivitySubscription;
  // final showMidDialog = false.obs;
  // final showNoInternetDialog = false.obs;
  final pitch = 0.5.obs;
  final speed = 0.5.obs;
  final isSpeechPlaying = false.obs;

  final LanguageController langController = Get.find();

  Timer? silenceTimer;

  @override
  void onInit() {
    super.onInit();
  }
     
  final List<String> _rtlLanguages = ['ar', 'he', 'ur', 'fa'];
  bool isRTLLanguage(String language) {
    final languageCode = langController.languageCodes[language] ?? "en";
    return _rtlLanguages.contains(languageCode);
  }

  static const MethodChannel _methodChannel = MethodChannel(
    'com.example.getx_practice_app/speech_Text',
  );

  Future<void> startSpeechToText(String languageISO) async {
    print(
      "Translation Screen selected language Code ------------${languageISO} ----------",
    );

    try {
      isListening.value = true;
      print("Starting speech recognition for language: $languageISO");
      final result = await _methodChannel.invokeMethod('getTextFromSpeech', {
        'languageISO': languageISO,
      });

      if (result != null && result.isNotEmpty) {
        textController.text = result;
        await handleUserActionTranslate(result);
      }
    } on PlatformException catch (e) {
      print("####################### Error in Speech-to-Text: ${e.message}");
    } finally {
      isListening.value = false;
    }
  }

  Future<void> speakText() async {
    try {
      // Set the TTS engine (optional for Android)
      await flutterTts.setEngine('com.google.android.tts');

      // Language map with corresponding locales
      // final Map<String, String> languageCodes = {
      //   'Urdu': 'ur-PK',
      //   'Hindi': 'hi-IN',
      //   'Punjabi': 'pa-IN',
      //   'Marathi': 'mr-IN',
      //   'Arabic': 'ar',
      //   'English': 'en-US',
      // };

      // Get the selected language code, default to English if not found
      String selectedLanguageCode = sourceText.value ?? 'en-US';

      // Set the selected language
      await flutterTts.setLanguage(selectedLanguageCode);

      // Set pitch and speech rate
      await flutterTts.setPitch(pitch.value);
      await flutterTts.setSpeechRate(speed.value);

      // Speak the translated text
      if (translatedText.value.isNotEmpty) {
        await flutterTts.speak(translatedText.value);
        print(
          "############# Speaking in $selectedLanguageCode: ${translatedText.value}",
        );
      } else {
        Get.snackbar("Error", "No text available to speak.");
      }
    } catch (e) {
      print("########## Error in TTS: ${e.toString()}");
      Get.snackbar("############# Error", "TTS failed: ${e.toString()}");
    }
  }

  static const MethodChannel _channel = MethodChannel(
    'com.example.getx_practice_app/tts',
  );

  Future<void> speakUsingNative(String text, String languageCode) async {
    try {
      await _channel.invokeMethod('speakText', {
        'text': text,
        'language': languageCode,
      });
    } on PlatformException catch (e) {
      print("Error: ${e.message}");
    }
  }

  Future<void> handleUserActionTranslate(String text) async {
    await translate(text);
    await speakText();
  }

  void onTranslateButtonPressed() async {
    final textToTranslate = textController.text;
    if (textToTranslate.isEmpty) {
      Get.snackbar("Error", "Please enter text to translate.");
      return;
    }
  }

  Future<void> translate(String text) async {
    if (text.isEmpty) {
      translatedText.value = "Please enter text to translate.";
      return;
    }

    isLoading.value = true; // Show loading indicator
    try {
      final sourceLang = sourceText.value ?? 'en';
      final targetLang = translatedText.value ?? 'es';

      final result = await translator.translate(
        text,
        from: sourceLang,
        to: targetLang,
      );

      translatedText.value = result.text;
      // await speakText();

    } catch (e) {
      translatedText.value = "Translation failed: ${e.toString()}";
    } finally {
      isLoading.value = false;
    }
  }

  // Method to clear the input and output text
  void clearData() {
    controller.clear();
    translatedText.value = "";
    speakText();
  }

  // New function to copy text to clipboard
  void copyText() {
    if (translatedText.isNotEmpty) {
      Clipboard.setData(ClipboardData(text: translatedText.value));
      Get.snackbar("Copied", "Translated text copied to clipboard!");
    }
  }


  // Reset the language and clear data
  void resetData() {
    sourceText.value = 'English';
    translatedText.value = 'French';
    clearData();
    speakText();
  }



  // Future<void> startListening() async {
  //   stopListening();

  //   isListening.value = false;
  //   showMidDialog.value = false;
  //   showNoInternetDialog.value = false;
  //   sourceText.value = '';
  //   translatedText.value = '';

  //   final hasInternet = await checkInternetConnection();
  //   if (!hasInternet) {
  //     showNoInternetDialog.value = true;
  //     return;
  //   }

  //   final sourceLangCode = langController.getLanguageCode(
  //     langController.selectedSource.value.countryCode,
  //   );
  //   final targetLangCode = langController.getLanguageCode(
  //     langController.selectedTarget.value.countryCode,
  //   );

  //   final available = await speech.initialize(
  //     onStatus: (status) {
  //       if (status == 'done' && sourceText.value.isEmpty) {
  //         showMidDialog.value = true;
  //       }
  //     },
  //     onError: (error) {
  //       showMidDialog.value = true;
  //       stopListening();
  //     },
  //   );

  //   if (!available) {
  //     showMidDialog.value = true;
  //     return;
  //   }

  //   isListening.value = true;

  //   silenceTimer = Timer(const Duration(seconds: 3), () {
  //     if (sourceText.value.isEmpty) {
  //       showMidDialog.value = true;
  //       stopListening();
  //     }
  //   });

  //   speech.listen(
  //     localeId: sourceLangCode,
  //     onResult: (result) {
  //       if (result.recognizedWords.isNotEmpty) {
  //         silenceTimer?.cancel();
  //         sourceText.value = result.recognizedWords;
  //         translateText(result.recognizedWords, targetLangCode);
  //       }
  //     },
  //   );
  // }

  // void stopListening() {
  //   if (isListening.value) {
  //     isListening.value = false;
  //     speech.stop();
  //     silenceTimer?.cancel();
  //   }
  // }

  // Future<void> translate(String text) async {
  //   if (text.isEmpty) {
  //     translatedText.value = "Please enter text to translate.";
  //     return;
  //   }

  //   isLoading.value = true; // Show loading indicator
  //   try {

  //     final result = await translator.translate(
  //       text,
  //       from: sourceText.value,
  //       to: translatedText.value,
  //     );

  //     translatedText.value = result.text;
  //     // await speakText();

  //   } catch (e) {
  //     translatedText.value = "Translation failed: ${e.toString()}";
  //   } finally {
  //     isLoading.value = false;
  //   }
  // }

  // Future<bool> checkInternetConnection() async {
  //   final connectivityResult = await Connectivity().checkConnectivity();
  //   if (connectivityResult == ConnectivityResult.none) return false;
  //   try {
  //     final result = await InternetAddress.lookup('google.com');
  //     return result.isNotEmpty && result[0].rawAddress.isNotEmpty;
  //   } catch (_) {
  //     return false;
  //   }
  // }

  // void resetVoiceTranslation() {
  //   stopListening();
  //   sourceText.value = '';
  //   translatedText.value = '';
  //   showMidDialog.value = false;
  //   showNoInternetDialog.value = false;
  // }

  // void monitorInternetConnection() {
  //   _connectivitySubscription = Connectivity().onConnectivityChanged.listen((
  //     result,
  //   ) async {
  //     final hasRealInternet = await checkInternetConnection();
  //     if (hasRealInternet && showNoInternetDialog.value) {
  //       showNoInternetDialog.value = false;
  //       // Get.snackbar(
  //       //   "Internet Restored",
  //       //   "Retrying translation...",
  //       //   snackPosition: SnackPosition.BOTTOM,
  //       //   duration: Duration(seconds: 2),
  //       // );

  //       await startListening();
  //     } else if (!hasRealInternet && !showNoInternetDialog.value) {
  //       showNoInternetDialog.value = true;
  //       stopListening();
  //     }
  //   });
  // }

  // @override
  // void onClose() {
  //   textController.dispose();
  //   silenceTimer?.cancel();
  //   _connectivitySubscription.cancel();
  //   super.onClose();
  // }
}
