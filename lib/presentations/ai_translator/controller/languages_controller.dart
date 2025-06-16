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

//   String getLanguageCode(String countryCode) {
  //   switch (countryCode) {
  //     case 'US': return 'en'; // English
  //     case 'PK': return 'ur'; // Urdu
  //     case 'FR': return 'fr'; // French
  //     case 'DE': return 'de'; // German
  //     case 'CN': return 'zh'; // Chinese
  //     case 'ES': return 'es'; // Spanish
  //     case 'IN': return 'hi'; // Hindi
  //     case 'SA': return 'ar'; // Arabic
  //     case 'JP': return 'ja'; // Japanese
  //     case 'IT': return 'it'; // Italian
  //     default: return 'en';
  //   }
  // }

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
    'Hebrew': 'he',
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
    'Hebrew': 'IL',
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

}
