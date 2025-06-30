import 'package:ai_checker_translator/gen/assets.gen.dart';
import 'package:ai_checker_translator/presentations/paraphrase/model/grammarcategory_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../data/models/categories_model.dart';
import '../../../data/services/database_helper.dart';

class CategoriesController extends GetxController {
  var categoriesList = <CategoriesModel>[].obs;
  var isLoading = true.obs;

  var grammarCategories =
      <GrammarCategoryModel>[
        GrammarCategoryModel(
          title: "Nouns  ",
          quizCount: 3,
          icons: Assets.noun.path,
        ),
        GrammarCategoryModel(
          title: "Verbs",
          quizCount: 2,
          icons: Assets.verbsicon.path,
        ),
        GrammarCategoryModel(
          title: "Subject",
          quizCount: 1,
          icons: Assets.subjecticon.path,
        ),
        GrammarCategoryModel(
          title: "Pronouns",
          quizCount: 2,
          icons: Assets.pronounsicon.path,
        ),
        GrammarCategoryModel(
          title: "Adjectives and Adverbs",
          quizCount: 1,
          icons: Assets.adjectives.path,
        ),
        GrammarCategoryModel(
          title: "Who and Whom",
          quizCount: 2,
          icons: Assets.who.path,
        ),
        GrammarCategoryModel(
          title: "Which, That, and Who",
          quizCount: 1,
          icons: Assets.which.path,
        ),
      ].obs;



  @override
  void onInit() {
    super.onInit();
    fetchCategoriesData();
  }

  Future<void> fetchCategoriesData() async {
    isLoading.value = true;
    final db = DatabaseHelper();
    await db.initDatabase();
    categoriesList.value = await db.fetchCategories();
    isLoading.value = false;
  }
}
