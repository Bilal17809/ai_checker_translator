import 'package:ai_checker_translator/data/quizzes_repo/quizzes_repo.dart';
import 'package:ai_checker_translator/gen/assets.gen.dart';
import 'package:ai_checker_translator/presentations/quizzes_category_screen/model/grammarcategory_model.dart';
import 'package:get/get.dart';
import '../../../data/models/quizzess_models/categories_model.dart';

class CategoriesController extends GetxController {

    final QuizRepository quizRepo;
  CategoriesController(this.quizRepo);

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
    try {
      isLoading.value = true;
      categoriesList.value = await quizRepo.fetchCategories();
    } catch (e) {
      print("❌ Error loading categories: $e");
    } finally {
      isLoading.value = false;
    }
  }
}
