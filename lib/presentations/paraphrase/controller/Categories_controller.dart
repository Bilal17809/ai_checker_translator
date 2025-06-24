
import 'package:ai_checker_translator/database/models/categories_model.dart';
import 'package:ai_checker_translator/database/services/database_helper.dart';
import 'package:ai_checker_translator/presentations/paraphrase/model/grammarcategory_model.dart';
import 'package:get/get.dart';


class CategoriesController extends GetxController {

  var categoriesList = <CategoriesModel>[].obs;
  var isLoading = true.obs;

  var grammarCategories =
      <GrammarCategoryModel>[
        GrammarCategoryModel(title: "Nouns  ", level: 1, quizCount: 3),
        GrammarCategoryModel(title: "Verbs", level: 2, quizCount: 2),
        GrammarCategoryModel(title: "Subject", level: 3, quizCount: 1),
        GrammarCategoryModel(title: "Pronouns", level: 4, quizCount: 2),
        GrammarCategoryModel(
          title: "Adjective and Adverbs",
          level: 5,
          quizCount: 3,
        ),
        GrammarCategoryModel(title: "Who and Whom", level: 6, quizCount: 1),
        GrammarCategoryModel(
          title: "Which, That, and Who",
          level: 7,
          quizCount: 2,
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
