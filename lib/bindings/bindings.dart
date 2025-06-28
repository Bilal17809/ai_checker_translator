
import 'package:ai_checker_translator/presentations/ai_translator/controller/languages_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AllBindins implements Bindings{

  @override
  void dependencies() {
    Get.lazyPut<LanguageController>(() => LanguageController());
    Get.lazyPut<MenuController>(() => MenuController());
    // Get.lazyPut<TranslatorController>(
    //   () => TranslatorController(),
    //   fenix: true,
    // );
  }
}