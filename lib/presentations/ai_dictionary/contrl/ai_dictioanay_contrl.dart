import 'package:ai_checker_translator/core/common_widgets/fluttertaost_message.dart';
import 'package:ai_checker_translator/core/globle_key/globle_key.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:get/get.dart';
import 'package:google_generative_ai/google_generative_ai.dart';
// import '../../../data/models/quizzes_model.dart';
// import '../../../data/services/database_helper.dart';

class GeminiAiCorrectionController extends GetxController {
  final textCheckPromptController = TextEditingController();

  late final GenerativeModel model;


  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    model = GenerativeModel(model: 'gemini-2.0-flash', apiKey: apiKey);
  }

  final FlutterTts flutterTts = FlutterTts();
  static const MethodChannel _speechChannel = MethodChannel(
    'com.example.getx_practice_app/speech_Text',
  );

  final pitch = 0.5.obs;
  final speed = 0.5.obs;

  final grammarResponseText = "".obs;
  final isLoading = false.obs;

  //start mic input
  Future<void> startMicInput({String languageISO = 'en-US'}) async {
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
      await flutterTts.stop();
      await flutterTts.setLanguage(languageCode);
      await flutterTts.setPitch(pitch.value);
      await flutterTts.setSpeechRate(speed.value);

      if (grammarResponseText.value.trim().isNotEmpty) {
        await flutterTts.speak(grammarResponseText.value.trim());
      }
    } catch (e) {
      Utils().toastMessage("TTS Error: ${e.toString()}");
    }
  }

  Future<void> correctGrammarAndSpelling() async {
    final inputText = textCheckPromptController.text.trim();
    if (inputText.isEmpty) {
      Utils().toastMessage("Enter some text to correct.");
      return;
    }

    isLoading.value = true;
    try {
      final correctionPrompt =
          "Please correct the following text for grammar and spelling mistakes, and return only the corrected version:\n\n$inputText";

      final content = [Content.text(correctionPrompt)];
      final response = await model.generateContent(content);

      grammarResponseText.value = response.text ?? "No correction received.";
    } catch (e) {
      grammarResponseText.value = "Correction Error: ${e.toString()}";
    } finally {
      isLoading.value = false;
    }
  }

  void copyText() {
    if (grammarResponseText.isNotEmpty) {
      Clipboard.setData(ClipboardData(text: grammarResponseText.value));
      Utils().toastMessage("Copied\nResponse text copied to clipboard!");
    }
  }

  void resetController() {
    textCheckPromptController.clear();
    textCheckPromptController.clear();
  }
}







  // var quizzessList = <QuizzesModel>[].obs;
  // var isLoading = true.obs;

  // @override
  // void onInit() {
  //   super.onInit();
  //   fetcQuizzesdata();
  // }

  // Future<void> fetcQuizzesdata() async {
  //   isLoading.value = true;
  //   final db = DatabaseHelper();
  //   await db.initDatabase();
  //   quizzessList.value = await db.fetcQuizzes();
  //   isLoading.value = false;
  // }






