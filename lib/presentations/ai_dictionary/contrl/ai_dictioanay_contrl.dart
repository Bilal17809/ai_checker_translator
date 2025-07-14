import 'package:ai_checker_translator/core/common_widgets/fluttertaost_message.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:get/get.dart';
import 'package:google_generative_ai/google_generative_ai.dart';
import '../../../domain/use_cases/get_mistral.dart';

class GeminiAiCorrectionController extends GetxController {
  final textCheckPromptController = TextEditingController();

  late final GenerativeModel model;
  final MistralUseCase useCase;

  GeminiAiCorrectionController(this.useCase);
  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    // model = GenerativeModel(model: 'gemini-2.0-flash', apiKey: apiKey);
  }

  final FlutterTts flutterTts = FlutterTts();
  static const MethodChannel _speechChannel = MethodChannel(
    'com.example.getx_practice_app/speech_Text',
  );

  final pitch = 0.5.obs;
  final speed = 0.5.obs;

  final grammarResponseText = "".obs;
  final isLoading = false.obs;
  final isSpeaking = false.obs;
  final isTypingStarted = false.obs;

  //start mic input
  Future<void> startMicInput({String languageISO = 'en-US'}) async {

    final hasInternet = await Utils.checkAndShowNoInternetDialogIfOffline();
    if (!hasInternet) return;
    try {
      final result = await _speechChannel.invokeMethod('getTextFromSpeech', {
        'languageISO': languageISO,
      });

      if (result != null && result.isNotEmpty) {
        textCheckPromptController.text = result;

        // Optional: trigger generation
        // await generateText();
      }
    } on PlatformException catch (e) {
      print("Mic Error: ${e.message}");
    }
  }

  //speak
Future<void> speakGeneratedText({String languageCode = 'en-US'}) async {
    try {
      if (isSpeaking.value) {
      await flutterTts.stop();
        isSpeaking.value = false;
        return;
      }

      final text = grammarResponseText.value.trim();
      if (text.isEmpty) return;

      await flutterTts.setLanguage(languageCode);
      await flutterTts.setPitch(pitch.value);
      await flutterTts.setSpeechRate(speed.value);

      isSpeaking.value = true;

      await flutterTts.speak(text);

      /// Listen for when speaking completes
      flutterTts.setCompletionHandler(() {
        isSpeaking.value = false;
      });
    } catch (e) {
      Utils().toastMessage("TTS Error: ${e.toString()}");
      isSpeaking.value = false;
    }
  }


  Future<void> generate() async {
    final inputeText = textCheckPromptController.text.trim();
    if (inputeText.isEmpty) {
      Utils().toastMessage("Enter text to generate");
      return;
    }
    final hasInternet = await Utils.checkAndShowNoInternetDialogIfOffline();
    if (!hasInternet) return;

    isLoading.value = true;
    isTypingStarted.value = false;
    grammarResponseText.value = '';

    try {
      final correctedPrompt = _buildCorrectionPromptWithLimit(inputeText);

      // Optional: control maxTokens if needed
      final result = await useCase(correctedPrompt, maxTokens: 150);

      final lineLimited = _limitResponseLines(result, 10);
      final charLimited = _limitResponseCharacters(lineLimited, 500);

      grammarResponseText.value = charLimited;
      isTypingStarted.value = true;
    } catch (e) {
      grammarResponseText.value = "Error: ${e.toString()}";
    } finally {
      isLoading.value = false;
    }
  }


  String _buildCorrectionPromptWithLimit(String input) {
    final words = input.split(RegExp(r'\s+')).length;
    final lines = input.split('\n').length;
    final chars = input.length;

    if (words <= 3 && chars < 40) {
      return '''
Correct the following short word or phrase. 
Return only corrected version in 1 line without explanation:
"$input"
''';
    } else if (words <= 15 && lines <= 2) {
      return '''
Fix grammar/spelling of the following short sentence.
Return corrected sentence only. No explanation.
"$input"
''';
    } else {
      return '''
Correct grammar and spelling in the following paragraph.
Return only the corrected version without any explanation in max 5–10 lines.
"$input"
''';
    }
  }

  String _limitResponseLines(String text, int maxLines) {
    final lines = text.split('\n');
    if (lines.length <= maxLines) return text;
    return lines.take(maxLines).join('\n');
  }

  String _limitResponseCharacters(String text, int maxChars) {
    if (text.length <= maxChars) return text;
    return text.substring(0, maxChars).trim() + '...';
  }





  void copyResponseText() {
    Utils.copyTextFrom(text: grammarResponseText.value);
  }

void copyPromptText() {
    Utils.copyTextFrom(text: textCheckPromptController.text);
}

  void resetController() {
    
    grammarResponseText.value = '';
    isTypingStarted.value = false;
    textCheckPromptController.clear();
    flutterTts.stop();
  }
}




