/*
>>>>>>>>>>>>>>> improve <<<<<<<<<<<<<<<<<<<
what the hell model are her?????????/
use this inside that file don't create separate file
like these small model
*/

class LanguageModel {
  final String name;
  final String code;
  final String countryCode;

  LanguageModel({
    required this.name,
    required this.code,
    required this.countryCode,
  });

  factory LanguageModel.fromJson(Map<String, dynamic> json) {
    return LanguageModel(
      name: json['name'],
      code: json['code'],
      countryCode: json['countryCode'],
    );
  }
}
