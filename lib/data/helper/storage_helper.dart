import 'package:shared_preferences/shared_preferences.dart';


// class StorageHelper {

//   static Future<void> saveText(String key, String value) async {
//     final prefs = await SharedPreferences.getInstance();
//     await prefs.setString(key, value);
//   }

//   static Future<String> loadText(String key) async {
//     final prefs = await SharedPreferences.getInstance();
//     return prefs.getString(key) ?? '';
//   }

//   static Future<void> saveList(String key, List<String> list) async {
//     final prefs = await SharedPreferences.getInstance();
//     await prefs.setStringList(key, list);
//   }

//   static Future<List<String>> loadList(String key) async {
//     final prefs = await SharedPreferences.getInstance();
//     return prefs.getStringList(key) ?? [];
//   }

//   static Future<void> removeKey(String key) async {
//     final prefs = await SharedPreferences.getInstance();
//     await prefs.remove(key);
//   }

//   static Future<void> saveInt(String key, int value) async {
//     final prefs = await SharedPreferences.getInstance();
//     await prefs.setInt(key, value);
//   }

//   static Future<int> loadInt(String key) async {
//     final prefs = await SharedPreferences.getInstance();
//     return prefs.getInt(key) ?? 0;
//   }
// }

class SharedPrefService {
  static final SharedPrefService _instance = SharedPrefService._internal();
  factory SharedPrefService() => _instance;
  SharedPrefService._internal();

  late SharedPreferences _prefs;

  Future<void> init() async {
    _prefs = await SharedPreferences.getInstance();
  }

  String get text => _prefs.getString('text') ?? '';
  set text(String value) => _prefs.setString('text', value);
  void removeText() => _prefs.remove('text');

  String get translatedText => _prefs.getString('translatedText') ?? '';
  set translatedText(String value) => _prefs.setString('translatedText', value);
  void removeTranslatedText() => _prefs.remove('translatedText');

  List<String> get translationHistory =>
      _prefs.getStringList('translationHistory') ?? [];
  set translationHistory(List<String> list) =>
      _prefs.setStringList('translationHistory', list);
  void removeTranslationHistory() => _prefs.remove('translationHistory');

  List<String> get favourites =>
      _prefs.getStringList('favouriteTranslations') ?? [];
  set favourites(List<String> list) =>
      _prefs.setStringList('favouriteTranslations', list);
  void removeFavourites() => _prefs.remove('favouriteTranslations');

  int get interactionCount => _prefs.getInt('interactionCount') ?? 0;
  set interactionCount(int value) => _prefs.setInt('interactionCount', value);
  void removeInteractionCount() => _prefs.remove('interactionCount');

  int get geminiInteractionCount =>
      _prefs.getInt('geminiInteractionCount') ?? 0;
  set geminiInteractionCount(int value) =>
      _prefs.setInt('geminiInteractionCount', value);
  void resetGeminiInteractionCount() => _prefs.remove('geminiInteractionCount');


  List<String> get learnedRules =>
      _prefs.getStringList('learned_rules_map') ?? [];
  set learnedRules(List<String> list) =>
      _prefs.setStringList('learned_rules_map', list);
  void removeLearnedRules() => _prefs.remove('learned_rules_map');


  List<String> get contentLearned =>
      _prefs.getStringList('content_learned_set') ?? [];
  set contentLearned(List<String> list) =>
      _prefs.setStringList('content_learned_set', list);
  void removeContentLearned() => _prefs.remove('content_learned_set');
}
