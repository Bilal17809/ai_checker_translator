
// application/mistral_usecase.dart


import 'package:ai_checker_translator/misteral_api_data/api_services/repository/api_respository.dart';

class MistralUseCase {
  final MistralRepository repository;
  MistralUseCase(this.repository);
  Future<String> call(String prompt) => repository.generateText(prompt);
}
