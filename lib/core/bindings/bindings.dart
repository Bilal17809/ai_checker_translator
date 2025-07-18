
import 'package:ai_checker_translator/data/services/paraphrase_repo.dart';
import 'package:ai_checker_translator/data/services/quizzes_repo.dart';
import 'package:ai_checker_translator/presentations/Quiz_levels/controller/quizzeslevel_controller.dart';
import 'package:ai_checker_translator/presentations/ai_dictionary/contrl/ai_dictioanay_contrl.dart';
import 'package:ai_checker_translator/presentations/paraphrase/controller/paraphrase_controller.dart';
import 'package:ai_checker_translator/presentations/quizdetail/controller/quiz_detail_controller.dart';
import 'package:ai_checker_translator/presentations/quizzes_category_screen/controller/Categories_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../data/data_source/online_data_sr.dart';
import '../../data/repositories_imp/repositories_imp.dart';
import '../../domain/repositories/mistral_repo.dart';
import '../../domain/use_cases/get_mistral.dart';
import '../../presentations/aska/controller/gemini_controller.dart';

class AllBindins implements Bindings {
  @override
  void dependencies() {
    _initDependencies();
  }
  Future<void> _initDependencies() async {
    Get.lazyPut<MenuController>(() => MenuController());
    Get.lazyPut(() => MistralApiService());
    Get.lazyPut<MistralRepository>(() => MistralRepositoryImpl(Get.find()));
    Get.lazyPut(() => MistralUseCase(Get.find()));
    Get.lazyPut(() => GeminiAiCorrectionController(Get.find()));
    Get.put(GeminiController(Get.find()));
    final quizRepo = QuizRepository('english_grammer.db');
    await quizRepo.init();
    Get.put(CategoriesController(quizRepo));
    Get.put(QuizDetailController(quizRepo));
    Get.put(QuizzeslevelController(quizRepo));
    final paraRepo = ParaphraseRepo("db_prahse.db");
    await paraRepo.initDatabase();
    Get.put(ParaphraseController(paraRepo), permanent: true);
  }
}
