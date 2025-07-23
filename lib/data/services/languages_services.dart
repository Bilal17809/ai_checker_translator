import 'dart:convert';
import 'package:ai_checker_translator/data/models/language_model.dart';
import 'package:flutter/services.dart';

class LanguageService {
  
  Future<List<LanguageModel>> loadLanguages() async {
    try {
      final String jsonString = await rootBundle.loadString(
        'assets/languages.json',
      );
      final List<dynamic> jsonList = json.decode(jsonString);
      return jsonList.map((e) => LanguageModel.fromJson(e)).toList();
    } catch (e) {
      print('Error loading languages: $e');
      return [];
    }
  }
}
