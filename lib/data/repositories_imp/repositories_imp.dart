
import '../../domain/repositories/mistral_repo.dart';
import '../data_source/online_data_sr.dart';

class MistralRepositoryImpl implements MistralRepository {
  final MistralApiService apiService;

  MistralRepositoryImpl(this.apiService);

  @override
  Future<String> generateText(String prompt) {
    return apiService.generateText(prompt);
  }
}
