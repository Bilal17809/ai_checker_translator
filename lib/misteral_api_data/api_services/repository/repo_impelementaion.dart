
// data/remote/mistral_repository_impl.dart


import 'package:ai_checker_translator/misteral_api_data/api_services/api_services.dart';
import 'package:ai_checker_translator/misteral_api_data/api_services/repository/api_respository.dart';

class MistralRepositoryImpl implements MistralRepository {
  final MistralApiService apiService;

  MistralRepositoryImpl(this.apiService);

  @override
  Future<String> generateText(String prompt) {
    return apiService.generateText(prompt);
  }
}
