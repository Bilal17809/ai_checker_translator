abstract class MistralRepository {
  Future<String> generateText(String prompt, {int maxTokens});
}
