
import '../repositories/mistral_repo.dart';
class MistralUseCase {
  final MistralRepository repository;
  MistralUseCase(this.repository);

  Future<String> call(String prompt, {int maxTokens = 200}) {
    return repository.generateText(prompt, maxTokens: maxTokens);
  }
}
