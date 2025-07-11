import 'dart:convert';

import 'package:ai_checker_translator/core/globle_key/globle_key.dart';
import 'package:http/http.dart' as http;

class MistralApiService {
  static const String _baseUrl = 'https://api.mistral.ai/v1/chat/completions';

  Future<String> generateText(String prompt, {int maxTokens = 200}) async {
    final response = await http.post(
      Uri.parse(_baseUrl),
      headers: {
        'Authorization': 'Bearer $apiKey',
        'Content-Type': 'application/json',
      },
      body: jsonEncode({
        "model": "mistral-small",
        "messages": [
          {"role": "user", "content": prompt}
        ],
        "temperature": 0.7,
        "max_tokens": maxTokens,
      }),
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      return data['choices'][0]['message']['content'];
    } else {
      throw Exception("API Error ${response.statusCode}: ${response.body}");
    }
  }
}
