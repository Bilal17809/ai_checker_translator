import 'package:ai_checker_translator/presentations/ai_translator/model/language_model.dart';
import 'package:get/get.dart';


class LanguageController extends GetxController {
  
  final Rx<LanguageModel> selectedSource =
      LanguageModel(countryCode: 'US', name: 'English').obs;
  final Rx<LanguageModel> selectedTarget =
      LanguageModel(countryCode: 'PK', name: 'Urdu').obs;

  final List<LanguageModel> languages = [

    LanguageModel(countryCode: 'US', name: 'English'),
    LanguageModel(countryCode: 'PK', name: 'Urdu'),
    LanguageModel(countryCode: 'FR', name: 'French'),
    LanguageModel(countryCode: 'DE', name: 'German'),
    LanguageModel(countryCode: 'CN', name: 'Chinese'),
    LanguageModel(countryCode: 'ES', name: 'Spanish'),
    LanguageModel(countryCode: 'IN', name: 'Hindi'),
    LanguageModel(countryCode: 'SA', name: 'Arabic'),
    LanguageModel(countryCode: 'JP', name: 'Japanese'),
    LanguageModel(countryCode: 'IT', name: 'Italian'),

  ];

  void updateSource(LanguageModel lang) {
    selectedSource.value = lang;
  }

  void updateTarget(LanguageModel lang) {
    selectedTarget.value = lang;
  }

  void switchLanguages() {
    final temp = selectedSource.value;
    selectedSource.value = selectedTarget.value;
    selectedTarget.value = temp;
  }
}
