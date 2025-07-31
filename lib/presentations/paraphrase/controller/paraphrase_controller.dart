import 'package:ai_checker_translator/core/common_widgets/fluttertaost_message.dart';
import 'package:ai_checker_translator/data/models/topicphrase_model.dart';
import 'package:ai_checker_translator/data/models/topics_model.dart';
import 'package:ai_checker_translator/data/services/paraphrase_repo.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:get/get.dart';

import '../../../ads_manager/interstitial_ads.dart';

class ParaphraseController extends GetxController {
  final ParaphraseRepo paraphraseRepo;
  ParaphraseController(this.paraphraseRepo);

  final TextEditingController searchController = TextEditingController();

  var topicsList = <TopicsModel>[].obs;
  var filteredTopics = <TopicsModel>[].obs;
  var topicPharseList = <TopicphraseModel>[].obs;

  final isSpeaking = false.obs;
  final pitch = 0.5.obs;
  final speed = 0.5.obs;
  var isLoading = false.obs;

  final FlutterTts flutterTts = FlutterTts();
  static const MethodChannel _speechChannel = MethodChannel(
    'com.example.getx_practice_app/speech_Text',
  );


  final pageController = PageController();
  var currentPageIndex = 0.obs;

  @override
  void onInit() {
    super.onInit();
    fetchTopics();
  }

  void searchTopics(String query) {
    if (query.trim().isEmpty) {
      filteredTopics.value = topicsList;
    } else {
      filteredTopics.value =
          topicsList.where((topic) {
            return topic.title?.toLowerCase().contains(query.toLowerCase()) ??
                false;
          }).toList();
    }
    print("👀 Filtered length: ${filteredTopics.length}");
  }

  // 📥 Fetch all topics
  Future<void> fetchTopics() async {
    isLoading.value = true;
    try {
      final data = await paraphraseRepo.fetctTopics();
      topicsList.value = data;
      filteredTopics.value = data;
      print("✅ Topics fetched: ${data.length}");
    } catch (e) {
      print("❌ Error fetching topics: $e");
    } finally {
      isLoading.value = false;
    }
  }


  Future<void> fetchTopicPhrasebyTopicId(int topicId) async {
    isLoading.value = true;
    try {
      print("📥 Fetching topic phrases for topicId: $topicId");
      final data = await paraphraseRepo.fetchTopicsPhraseByTopicId(topicId);
      topicPharseList.value = data;

      currentPageIndex.value = 0;
      pageController.jumpToPage(0);

      print("✅ Phrases fetched: ${data.length}");
    } catch (e) {
      print("❌ Error fetching topic phrases: $e");
    } finally {
      isLoading.value = false;
    }
  }

  // 🔁 Navigate PageView
  void goToPage(int index) {
    if (index >= 0 && index < topicPharseList.length) {
      currentPageIndex.value = index;
      pageController.animateToPage(
        index,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    }
  }

  Future<void> speakExplanationText(
    String explanation, {
    String languageCode = 'en-US',
  }) async {
    try {
      if (isSpeaking.value) {
        await flutterTts.stop();
        isSpeaking.value = false;
        return;
      }

      if (explanation.trim().isEmpty) return;

      await flutterTts.setLanguage(languageCode);
      await flutterTts.setPitch(pitch.value);
      await flutterTts.setSpeechRate(speed.value);

      isSpeaking.value = true;

      await flutterTts.speak(explanation.trim());

      flutterTts.setCompletionHandler(() {
        isSpeaking.value = false;
      });
    } catch (e) {
      Utils().toastMessage("TTS Error: ${e.toString()}");
      isSpeaking.value = false;
    }
  }
  void copyExplanation(String explanation) {
    Utils.copyTextFrom(text: explanation);
  }



}
