import 'dart:io';

import 'package:ai_checker_translator/core/common_widgets/fluttertaost_message.dart';
import 'package:ai_checker_translator/presentations/ai_translator/widgets/VoiceTranslatorDialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:just_audio/just_audio.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:speech_to_text/speech_to_text.dart';
import 'package:translator/translator.dart';

class TranslationController extends GetxController {


  final SpeechToText _speech = SpeechToText();

  final RxString recognizedText = ''.obs;

  RxString selectedLanguage1 = "English".obs;
  RxString selectedLanguage2 = "Spanish".obs;
  RxString translatedText = "".obs;
  RxBool isListening = false.obs;
  RxBool isLoading = false.obs;
  final pitch = 1.0.obs; // Default to a higher pitch
  final speed = 1.0.obs; // Default to a slightly faster speed
  // final pitch = 0.3.obs;
  // final speed = 0.3.obs;
  final isSpeechPlaying = false.obs;
  RxBool hasInternet = true.obs;

  final RxList<Map<String, dynamic>> favouriteTranslations =
      <Map<String, dynamic>>[].obs;
  static const _favouritesKey = 'favourite_translations';

  final RxList<Map<String, dynamic>> translationHistory =
      <Map<String, dynamic>>[].obs;
  static const _historyKey = 'translation_history';

  @override
  void onInit() {
    super.onInit();
    Utils.monitorInternet();
    Utils.isConnectedToInternet();
    loadHistory();
    loadFavourites();
  }

  TextEditingController controller = TextEditingController();
  final translator = GoogleTranslator();
  FlutterTts flutterTts = FlutterTts();

  final Map<String, String> languageCodes = {
    'English': 'en',
    'French': 'fr',
    'Spanish': 'es',
    'German': 'de',
    'Italian': 'it',
    'Portuguese': 'pt',
    'Dutch': 'nl',
    'Russian': 'ru',
    'Chinese (Simplified)': 'zh-cn',
    'Japanese': 'ja',
    'Korean': 'ko',
    'Arabic': 'ar',
    'Hindi': 'hi',
    'Urdu': 'ur',
    'Bengali': 'bn',
    'Punjabi': 'pa',
    'Turkish': 'tr',
    'Vietnamese': 'vi',
    'Thai': 'th',
    'Indonesian': 'id',
    'Tagalog': 'tl',
    'Swedish': 'sv',
    'Norwegian': 'no',
    'Danish': 'da',
    'Finnish': 'fi',
    'Polish': 'pl',
    'Greek': 'el',
    'Czech': 'cs',
    'Hungarian': 'hu',
    'Romanian': 'ro',
    'Ukrainian': 'uk',
    'Malay': 'ms',
    'Tamil': 'ta',
    'Telugu': 'te',
    'Kannada': 'kn',
    'Marathi': 'mr',
    'Gujarati': 'gu',
    'Swahili': 'sw',
    'Zulu': 'zu',
  };
  final languageFlags = {
    'Afrikaans': 'ZA',
    'Albanian': 'AL',
    'Amharic': 'ET',
    'Arabic': 'AE',
    'Armenian': 'AM',
    'Azerbaijani': 'AZ',
    'Basque': 'ES',
    'Belarusian': 'BY',
    'Bengali': 'BD',
    'Bosnian': 'BA',
    'Bulgarian': 'BG',
    'Catalan': 'ES',
    'Chinese (Simplified)': 'CN',
    'Chinese (Traditional)': 'TW',
    'Croatian': 'HR',
    'Czech': 'CZ',
    'Danish': 'DK',
    'Dutch': 'NL',
    'English': 'US',
    'Estonian': 'EE',
    'Filipino': 'PH',
    'Finnish': 'FI',
    'French': 'FR',
    'Georgian': 'GE',
    'German': 'DE',
    'Greek': 'GR',
    'Gujarati': 'IN',
    'Haitian Creole': 'HT',
    'Hindi': 'IN',
    'Hungarian': 'HU',
    'Icelandic': 'IS',
    'Indonesian': 'ID',
    'Irish': 'IE',
    'Italian': 'IT',
    'Japanese': 'JP',
    'Kannada': 'IN',
    'Kazakh': 'KZ',
    'Khmer': 'KH',
    'Korean': 'KR',
    'Kurdish': 'IQ',
    'Latvian': 'LV',
    'Lithuanian': 'LT',
    'Macedonian': 'MK',
    'Malay': 'MY',
    'Maltese': 'MT',
    'Marathi': 'IN',
    'Mongolian': 'MN',
    'Nepali': 'NP',
    'Norwegian': 'NO',
    'Persian': 'IR',
    'Polish': 'PL',
    'Portuguese (Brazil)': 'BR',
    'Portuguese (Portugal)': 'PT',
    'Punjabi': 'PK',
    'Romanian': 'RO',
    'Russian': 'RU',
    'Serbian': 'RS',
    'Slovak': 'SK',
    'Slovenian': 'SI',
    'Spanish': 'ES',
    'Swahili': 'KE',
    'Swedish': 'SE',
    'Tamil': 'LK',
    'Telugu': 'IN',
    'Thai': 'TH',
    'Turkish': 'TR',
    'Ukrainian': 'UA',
    'Urdu': 'PK',
    'Vietnamese': 'VN',
    'Welsh': 'GB',
    'Yiddish': 'IL',
  
  };

  final List<String> _rtlLanguages = ['ar', 'he', 'ur', 'fa'];
  bool isRTLLanguage(String language) {
    final languageCode = languageCodes[language] ?? 'en';
    return _rtlLanguages.contains(languageCode);
  }

  static const MethodChannel _methodChannel =
  MethodChannel('com.example.getx_practice_app/speech_Text');

  Future<void> startSpeechToText(String languageISO) async {
    try {
      isListening.value = true;
      final result = await _methodChannel.invokeMethod('getTextFromSpeech', {'languageISO': languageISO});

      if (result != null && result.isNotEmpty) {
        controller.text = result;
        await handleUserActionTranslate(result);
      }
    } on PlatformException catch (e) {
      print("Error in Speech-to-Text: ${e.message}");
    } finally {
      isListening.value = false;
    }
  }



  //for ios
  Future<void> startSpeechToTex(String languageISO) async {
    try {
      recognizedText.value = '';

      // ✅ Show custom dialog (you can conditionally restrict to iOS later)
      showDialog(
        context: Get.context!,
        barrierDismissible: false,
        builder:
            (_) => IOSVoiceDialog(
              isListening: isListening,
              recognizedText: recognizedText,
              onCancel: () {
                _speech.stop();
                isListening.value = false;
                Navigator.of(Get.context!).pop();
              },
              onRetry: () async {
                if (_speech.isListening) {
                  await _speech.stop();
                }
                isListening.value = false;
                await Future.delayed(const Duration(milliseconds: 300));
                startSpeechToTex(languageISO); // 🔁 retry mic
              },
            ),
      );

      final isAvailable = await _speech.initialize(
        onStatus: (status) {
          print("Speech status: $status");
          if (status == 'done' || status == 'notListening') {
            isListening.value = false;
          }
        },
        onError: (error) {
          print("Speech error: ${error.errorMsg}");
          isListening.value = false;
        },
      );

      if (isAvailable) {
        isListening.value = true;

        await _speech.listen(
          localeId: languageISO, // e.g. 'en_US', 'ur_PK'
          listenMode: ListenMode.confirmation,
          partialResults: false,
          onResult: (result) async {
            final spoken = result.recognizedWords.trim();
            if (spoken.isNotEmpty) {
              recognizedText.value = spoken;
              controller.text = spoken;
              await handleUserActionTranslate(spoken);
              isListening.value = false;
            }
          },
        );
      } else {
        print("Speech not available");
        isListening.value = false;
      }
    } catch (e) {
      print("Speech exception: $e");
      isListening.value = false;
    }
  }

  //...................................
  void stopTTS() {
    audioPlayer.stop();
  }

  final AudioPlayer audioPlayer = AudioPlayer();

Future<void> speakText({String? langCodeOverride}) async {
    final text = translatedText.value.trim();
    if (text.isEmpty) return;

    final langCode =
        langCodeOverride ?? languageCodes[selectedLanguage2.value] ?? 'es'; 

    final encodedText = Uri.encodeComponent(text);

    final url =
        'https://translate.google.com/translate_tts?ie=UTF-8'
        '&client=tw-ob'
        '&q=$encodedText'
        '&tl=$langCode'
        '&ttsspeed=${speed.value}'
        '&pitch=${pitch.value}';

    try {
      await audioPlayer.stop();
      await audioPlayer.setAudioSource(AudioSource.uri(Uri.parse(url)));
      await audioPlayer.play();
    } catch (e) {
      print('❌ Error in fetching TTS audio: $e');
    }
  }



  // Future<void> speakText() async {
  //   try {
  //     await flutterTts.stop();
  //     await flutterTts.setEngine('com.google.android.tts');
  //     String selectedLanguageCode =
  //         languageCodes[selectedLanguage2.value] ?? 'en-US';
  //     await flutterTts.setLanguage(selectedLanguageCode);
  //     await flutterTts.setPitch(pitch.value);
  //     await flutterTts.setSpeechRate(speed.value);
  //
  //     if (translatedText.value.isNotEmpty) {
  //       await flutterTts.speak(translatedText.value);
  //     }
  //   } catch (e) {
  //     Utils().toastMessage("Error: ${e.toString()}");
  //   }
  // }

  Future<void> handleUserActionTranslate(String text) async {

    final hasInternet = await Utils.checkAndShowNoInternetDialogIfOffline();
    if (!hasInternet) return;
      await translate(text);
      await speakText();
  }

  void onTranslateButtonPressed() async {
    final textToTranslate = controller.text;
    if (textToTranslate.isEmpty) {
      Utils().toastMessage("Please enter text to translate.");
      return;
    }
  }
Future<void> translate(String text) async {
    if (text.isEmpty) {
      translatedText.value = "Please enter text to translate.";
      return;
    }

    final hasInternet = await Utils.checkAndShowNoInternetDialogIfOffline();
    if (!hasInternet) return;

    isLoading.value = true;
    try {
      final sourceLang = languageCodes[selectedLanguage1.value] ?? 'en';
      final targetLang = languageCodes[selectedLanguage2.value] ?? 'es';

      final result = await translator.translate(
        text,
        from: sourceLang,
        to: targetLang,
      );

      translatedText.value = result.text;
      addToHistory(text, result.text);


      Future.delayed(const Duration(milliseconds: 20), () {
        speakText();
      });

    } catch (e) {
      translatedText.value = "Translation failed: ${e.toString()}";
    } finally {
      isLoading.value = false;
    }
  }


  void clearData() {
    audioPlayer.stop();
    controller.clear();
    translatedText.value = "";
    speakText();
  }

  void copyTranslatedText() {
    Utils.copyTextFrom(text: translatedText.value);
  }

  void copyTextEditingControllerText() {
    Utils.copyTextFrom(text: controller.text);
  }

  void resetData() {
    selectedLanguage1.value = 'English';
    selectedLanguage2.value = 'French';
    clearData();
    speakText();
    clearPrefs();
  }

  String getFlagEmoji(String countryCode) {
    return countryCode.toUpperCase().codeUnits.map((char) {
      return String.fromCharCode(char + 127397);
    }).join();
  }

  void swapLanguages() {
    final tempLang = selectedLanguage1.value;
    selectedLanguage1.value = selectedLanguage2.value;
    selectedLanguage2.value = tempLang;

    final tempText = controller.text;
    controller.text = translatedText.value;
    translatedText.value = tempText;
    audioPlayer.stop();
    clearData();
  }

  Future<void> saveToPrefs() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('inputText', controller.text);
    await prefs.setString('translatedText', translatedText.value);
  }

  Future<void> loadFromPrefs() async {
    final prefs = await SharedPreferences.getInstance();
    controller.text = prefs.getString('inputText') ?? '';
    translatedText.value = prefs.getString('translatedText') ?? '';
  }

  Future<void> clearPrefs() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('inputText');
    await prefs.remove('translatedText');
  }

  void addToHistory(String original, String translated) async {
    final sourceLang = selectedLanguage1.value;
    final targetLang = selectedLanguage2.value;
    final sourceFlag = getFlagEmoji(languageFlags[sourceLang] ?? 'US');
    final targetFlag = getFlagEmoji(languageFlags[targetLang] ?? 'ES');

    final entry = {
      'id': DateTime.now().millisecondsSinceEpoch.toString(),
      'source': "$sourceFlag $sourceLang\n$original",
      'target': "$targetFlag $targetLang\n$translated",
      'targetLang': targetLang, 
    };

    translationHistory.insert(0, entry);
    saveHistory();
  }

  Future<void> saveHistory() async {
    final prefs = await SharedPreferences.getInstance();
    final historyList =
        translationHistory
            .map((e) => "${e['id']}|${e['source']}||${e['target']}")
            .toList();
    await prefs.setStringList(_historyKey, historyList);
  }

  Future<void> loadHistory() async {
    final prefs = await SharedPreferences.getInstance();
    final historyList = prefs.getStringList(_historyKey) ?? [];

    translationHistory.value =
        historyList.map((entry) {
          final parts = entry.split('|');
          final id = parts[0];
          final content = parts.sublist(1).join('|');
          final contentParts = content.split('||');

          return {
            'id': id,
            'source': contentParts[0],
            'target': contentParts.length > 1 ? contentParts[1] : "",
          };
        }).toList();
  }

  void clearHistory() async {
    translationHistory.clear();
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_historyKey);
  }

void deleteHistoryItem(int index) async {
    if (index >= 0 && index < translationHistory.length) {
    translationHistory.removeAt(index);
    saveHistory();
    }
    flutterTts.stop();
  }

  Future<void> speakTranslatedTextOnly(String text) async {
    try {
      await flutterTts.stop();
      await flutterTts.setPitch(pitch.value);
      await flutterTts.setSpeechRate(speed.value);
      final langCode = languageCodes[selectedLanguage2.value] ?? 'en-US';
      await flutterTts.setLanguage(langCode);

      if (text.trim().isNotEmpty) {
        await flutterTts.speak(text.trim());
      }
    } catch (e) {
      Utils().toastMessage("Error: ${e.toString()}");
    }
  }

  // Save Favourite
  void addToFavourites(Map<String, dynamic> item) {
    if (!favouriteTranslations.any((fav) => fav['id'] == item['id'])) {
      favouriteTranslations.insert(0, item);
      saveFavourites();
    }
  }

  // Remove Favourite
  void removeFromFavourites(Map<String, dynamic> item) async {
    favouriteTranslations.removeWhere((fav) => fav['id'] == item['id']);
    await saveFavourites();
  }

  // Check if favourite
  bool isFavourite(Map<String, dynamic> item) {
    return favouriteTranslations.any((fav) => fav['id'] == item['id']);
  }

  // Save to SharedPreferences
  Future<void> saveFavourites() async {
    final prefs = await SharedPreferences.getInstance();
    final favList =
        favouriteTranslations
            .map((e) => "${e['id']}|${e['source']}||${e['target']}")
            .toList();
    await prefs.setStringList(_favouritesKey, favList);
  }

  // Load from SharedPreferences
  Future<void> loadFavourites() async {
    final prefs = await SharedPreferences.getInstance();
    final favList = prefs.getStringList(_favouritesKey) ?? [];

    favouriteTranslations.value =
        favList.map((entry) {
          final parts = entry.split('|');
          final id = parts[0];
          final content = parts.sublist(1).join('|');
          final contentParts = content.split('||');

          return {
            'id': id,
            'source': contentParts[0],
            'target': contentParts.length > 1 ? contentParts[1] : "",
          };
        }).toList();
  }

  void deleteFromFavouritesOnly(Map<String, dynamic> item) async {
    favouriteTranslations.removeWhere((fav) => fav['id'] == item['id']);
    await saveFavourites();
  }

  @override
  void onClose() {
    audioPlayer.stop();
    super.onClose();
  }

  @override
  void dispose() {
    audioPlayer.stop();
    audioPlayer.dispose();
    super.dispose();
  }

  void speakFromHistoryCard(String targetText) {
    final lines = targetText.split('\n');
    final langLine = lines.isNotEmpty ? lines.first : '';
    final actualText =
        lines.length > 1 ? lines.sublist(1).join('\n').trim() : targetText;
    final languageName =
        langLine.replaceAll(RegExp(r'[^\u0600-\u06FF\w\s]'), '').trim();
    final langCode =
        languageCodes[languageName] ?? languageCodes[selectedLanguage2.value]!;
    translatedText.value = actualText;
    if (actualText.isNotEmpty) {
      speakText(langCodeOverride: langCode);
    }
  }


}
