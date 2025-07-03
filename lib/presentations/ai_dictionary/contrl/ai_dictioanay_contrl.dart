import 'package:ai_checker_translator/core/common_widgets/fluttertaost_message.dart';
import 'package:ai_checker_translator/core/globle_key/globle_key.dart';
import 'package:ai_checker_translator/misteral_api_data/api_services/use_casses/api_use_casses.dart';
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
      Utils().toastMessage("Enter teext to");
      return;
    }

    isLoading.value = true;
    try {
      final correctionPrompt = '''
          Correct the following sentence or words for grammar and spelling.
If it is already correct, return it exactly as-is without any explanation:

"$inputeText"
''';
      final result = await useCase(correctionPrompt);
      grammarResponseText.value = result;
    } catch (e) {
      grammarResponseText.value = e.toString();
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






