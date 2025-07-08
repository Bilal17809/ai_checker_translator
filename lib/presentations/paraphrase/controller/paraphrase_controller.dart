
import 'package:ai_checker_translator/data/models/parphrase_models/topicphrase_model.dart';
import 'package:ai_checker_translator/data/models/parphrase_models/topics_model.dart';
import 'package:ai_checker_translator/data/paraphrase_repo/paraphrase_repo.dart';
import 'package:get/get.dart';

class ParaphraseController  extends GetxController{
  
   final ParaphraseRepo _paraphraseRepo;
   ParaphraseController(this._paraphraseRepo);

  var topicsList = <TopicsModel> [].obs;
  var isLoading = false.obs;
  var topicPharseList = <TopicphraseModel> [].obs; 

@override
  void onInit() {
    super.onInit();
    fetctTopicsss();
    // fetchTopicPhrasebyTopicId(2); 
  }

//fetch Topics
  Future<void> fetctTopicsss()async{
   isLoading.value = true;
   try{
       final data = await _paraphraseRepo.fetctTopics();
       topicsList.value = data;
   }catch(e){
        print("Data Not Fetch $e");
   }finally{
           isLoading.value = false;
   }
  }

//fetch topics phrase by topicid
   Future<void> fetchTopicPhrasebyTopicId(int topicId) async {
    isLoading.value = true;
    try {
      print("📥 Fetching topic phrases for topicId: $topicId");
      final data = await _paraphraseRepo.fetchTopicsPhraseByTopicId(topicId);
      topicPharseList.value = data;
      print("✅ Phrases fetched: ${data.length}");
    } catch (e) {
      print("❌ Error fetching topic phrases: $e");
    } finally {
      isLoading.value = false;
    }
  }
}