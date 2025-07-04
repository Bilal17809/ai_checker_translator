
import 'package:ai_checker_translator/misteral_api_data/api_services/api_services.dart';
import 'package:ai_checker_translator/misteral_api_data/api_services/repository/api_respository.dart';
import 'package:ai_checker_translator/misteral_api_data/api_services/repository/repo_impelementaion.dart';
import 'package:ai_checker_translator/misteral_api_data/api_services/use_casses/api_use_casses.dart';
import 'package:ai_checker_translator/presentations/ai_dictionary/contrl/ai_dictioanay_contrl.dart';
import 'package:ai_checker_translator/presentations/ai_dictionary/contrl/animation_controller.dart';
import 'package:ai_checker_translator/presentations/ai_translator/controller/languages_controller.dart';
import 'package:ai_checker_translator/presentations/aska/view/controller/gemini_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AllBindins implements Bindings{

  @override
  void dependencies() {
    Get.lazyPut<LanguageController>(() => LanguageController());
    Get.lazyPut<MenuController>(() => MenuController());
    Get.lazyPut(() => MistralApiService());
    Get.lazyPut<MistralRepository>(() => MistralRepositoryImpl(Get.find()));
    Get.lazyPut(() => MistralUseCase(Get.find()));
    Get.lazyPut(() => GeminiController(Get.find()));
    Get.lazyPut(() => GeminiAiCorrectionController(Get.find()));
      
    // Get.lazyPut<AnimatedTextController>(() => AnimatedTextController());
    // Get.lazyPut<TranslatorController>(
    //   () => TranslatorController(),
    //   fenix: true,
    // );
  }
}