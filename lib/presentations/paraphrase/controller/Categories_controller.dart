import 'package:ai_checker_translator/presentations/paraphrase/model/grammarcategory_model.dart';
import 'package:get/get.dart';

import '../../../data/models/categories_model.dart';
import '../../../data/services/database_helper.dart';

class CategoriesController extends GetxController {
  var categoriesList = <CategoriesModel>[].obs;
  var isLoading = true.obs;

  var grammarCategories =
      <GrammarCategoryModel>[
        GrammarCategoryModel(title: "Nouns  ", quizCount: 3),
        GrammarCategoryModel(title: "Verbs", quizCount: 2),
        GrammarCategoryModel(title: "Subject", quizCount: 1),
        GrammarCategoryModel(title: "Pronouns", quizCount: 2),
        GrammarCategoryModel(title: "Adjectives and Adverbs", quizCount: 1),
        GrammarCategoryModel(title: "Who and Whom", quizCount: 2),
        GrammarCategoryModel(title: "Which, That, and Who", quizCount: 1),
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
