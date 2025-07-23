
import 'package:ai_checker_translator/core/common_widgets/fluttertaost_message.dart';
import 'package:ai_checker_translator/data/helper/storage_helper.dart';
import 'package:ai_checker_translator/data/helper/storage_keys.dart';
import 'package:ai_checker_translator/data/models/language_model.dart';
import 'package:ai_checker_translator/data/services/languages_services.dart';
import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:get/get.dart';
import 'package:just_audio/just_audio.dart';
import 'package:speech_to_text/speech_to_text.dart';
import 'package:translator/translator.dart';

class TranslationController extends GetxController {
  final SpeechToText _speech = SpeechToText();

  late final AudioPlayer audioPlayer;
  final LanguageService _languageService = LanguageService();

  // final RxString recognizedText = ''.obs;

  RxString selectedLanguage1 = "English".obs;
  RxString selectedLanguage2 = "Spanish".obs;
  RxString translatedText = "".obs;
  RxBool isListening = false.obs;
  RxBool isLoading = false.obs;
  final pitch = 1.0.obs;
  final speed = 1.0.obs;
  final isSpeechPlaying = false.obs;
  RxBool hasInternet = true.obs;

  var languages = <LanguageModel>[].obs;

  final RxList<Map<String, dynamic>> favouriteTranslations =
      <Map<String, dynamic>>[].obs;

  final RxList<Map<String, dynamic>> translationHistory =
      <Map<String, dynamic>>[].obs;

  final prefs = SharedPrefService();
  @override
  void onInit() {
    super.onInit();
    loadLanguagesFromJson();
    audioPlayer = AudioPlayer();
    Utils.monitorInternet();
    Utils.isConnectedToInternet();
    loadHistory();
    loadFavourites();
  }

  TextEditingController controller = TextEditingController();
  final translator = GoogleTranslator();
  FlutterTts flutterTts = FlutterTts();



Future<void> loadLanguagesFromJson() async {
    final langList = await _languageService.loadLanguages();
    languages.value = langList;
  }

  final List<String> _rtlLanguages = ['ar', 'he', 'ur', 'fa'];
  bool isRTLLanguage(String languageName) {
    final matchedLanguage = languages.firstWhereOrNull(
      (lang) => lang.name == languageName,
    );
    final languageCode = matchedLanguage?.code ?? 'en';
    return _rtlLanguages.contains(languageCode);
  }

  Future<void> startSpeechToText(String languageISO) async {
    final result = await Utils.startListening(
      languageISO: languageISO,
      isListening: isListening,
    );
    if (result != null && result.isNotEmpty) {
      controller.text = result;
      await handleUserActionTranslate(result);
    }
}

  Future<void> speakText({String? langCodeOverride}) async {
    final text = translatedText.value.trim();
    if (text.isEmpty) return;

    final langCode =
        langCodeOverride ??
        languages
            .firstWhereOrNull((lang) => lang.name == selectedLanguage2.value)
            ?.code ??
        'en';

    const maxLength = 200;

    try {
      if (audioPlayer.playing) {
        await audioPlayer.stop();
        await Future.delayed(const Duration(milliseconds: 100));
      }
      final chunks =
          text.length <= maxLength ? [text] : Utils.splitText(text, maxLength);

      for (final chunk in chunks) {
        final url = Utils.buildTTSUrl(
          text: chunk,
          langCode: langCode,
          speed: speed.value,
          pitch: pitch.value,
        );

        try {
          await audioPlayer.setAudioSource(AudioSource.uri(Uri.parse(url)));
          await audioPlayer.play();

          await audioPlayer.playerStateStream.firstWhere(
            (state) => state.processingState == ProcessingState.completed,
          );
          await Future.delayed(const Duration(milliseconds: 200));
        } catch (e) {
          print('❌ Error while playing chunk: $e');
          break;
        }
      }
      await audioPlayer.stop();
    } catch (e) {
      print('❌ Error in fetching TTS audio: $e');
    }
  }

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
      final sourceLang =
          languages
              .firstWhereOrNull((lang) => lang.name == selectedLanguage1.value)
              ?.code ??
          'en';

      final targetLang =
          languages
              .firstWhereOrNull((lang) => lang.name == selectedLanguage2.value)
              ?.code ??
          'es';

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
    prefs.text = controller.text;
    prefs.translatedText = translatedText.value;
  }

  Future<void> loadFromPrefs() async {
    controller.text = prefs.text;
    translatedText.value = prefs.translatedText;
  }

  Future<void> clearPrefs() async {
    prefs.removeText();
    prefs.removeTranslatedText();
  }

  void addToHistory(String original, String translated) async {
    final sourceLangName = selectedLanguage1.value;
    final targetLangName = selectedLanguage2.value;

    final sourceLang = languages.firstWhereOrNull(
      (lang) => lang.name == sourceLangName,
    );
    final targetLang = languages.firstWhereOrNull(
      (lang) => lang.name == targetLangName,
    );

    final sourceFlag = Utils.getFlagEmoji(sourceLang?.countryCode ?? 'US');
    final targetFlag = Utils.getFlagEmoji(targetLang?.countryCode ?? 'ES');

    final entry = {
      'id': DateTime.now().millisecondsSinceEpoch.toString(),
      'source': "$sourceFlag $sourceLangName\n$original",
      'target': "$targetFlag $targetLangName\n$translated",
      'targetLang': targetLangName,
    };

    translationHistory.insert(0, entry);
    saveHistory();
  }

  Future<void> saveHistory() async {
    final historyList =
        translationHistory
            .map((e) => "${e['id']}|${e['source']}||${e['target']}")
            .toList();
    final prefs = SharedPrefService();
    prefs.translationHistory = historyList;
  }

  Future<void> loadHistory() async {
    final historyList = prefs.translationHistory;
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
    prefs.removeFavourites();
  }

  void deleteHistoryItem(int index) async {
    if (index >= 0 && index < translationHistory.length) {
      translationHistory.removeAt(index);
      saveHistory();
    }
    flutterTts.stop();
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
    final favList =
        favouriteTranslations
            .map((e) => "${e['id']}|${e['source']}||${e['target']}")
            .toList();
    prefs.favourites = favList;
  }

  // Load from SharedPreferences
  Future<void> loadFavourites() async {
    final prefs = SharedPrefService();
    final favList = prefs.favourites;
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
        languages
            .firstWhere(
              (lang) => lang.name == languageName,
              orElse:
                  () => LanguageModel(
                    name: 'English',
                    code: 'en',
                    countryCode: 'US',
                  ),
            )
            .code;

    translatedText.value = actualText;

    if (actualText.isNotEmpty) {
      speakText(langCodeOverride: langCode);
    }
  }
}
