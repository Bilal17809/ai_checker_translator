import 'package:ai_checker_translator/data/models/rules_model.dart';
import 'package:ai_checker_translator/data/services/quizzes_repo.dart';
import 'package:ai_checker_translator/gen/assets.gen.dart';
import 'package:ai_checker_translator/presentations/learn_grammaer/view/rules_detail_screen.dart';
import 'package:ai_checker_translator/presentations/quizzes_category_screen/model/grammarcategory_model.dart';
import 'package:get/get.dart';
import '../../../data/models/categories_model.dart';

class CategoriesController extends GetxController {

    final QuizRepository quizRepo;
  CategoriesController(this.quizRepo);


  /*
  improve how to do use for loop
  */

  var categoriesList = <CategoriesModel>[].obs;
  var rulesList = <RulesModel>[].obs;
  var rulesCountMap = <int, int>{}.obs;
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
    fetchCategoriesData(1);
  }

  Future<void> fetchCategoriesData(int menuId) async {
    try {
      isLoading.value = true;
      categoriesList.value = await quizRepo.fetchCategories(menuId);
      await fetchAllRulesCountForCategories();
    } catch (e) {
      print("❌ Error loading categories: $e");
    } finally {
      isLoading.value = false;
    }
  }

    
  Future<void> fetchRulesByCategoryId(int catId) async {
    try {
      isLoading.value = true;
      rulesList.value = await quizRepo.fetchRulesByCatId(catId);
    } catch (e) {
      print("❌ Error loading rules: $e");
    } finally {
      isLoading.value = false;
    }
  }

  void goToRuleDetail(RulesModel rule) {
    Get.to(
      () => RuleDetailScreen(
        title: rule.titleOnly,
        definition: rule.definitionOnly,
      ),
    );
  }

  Future<void> fetchAllRulesCountForCategories() async {
    rulesCountMap.clear();
    for (var cat in categoriesList) {
      final rules = await quizRepo.fetchRulesByCatId(cat.catID ?? 0);
      if (rules.isNotEmpty) {
        rulesCountMap[cat.catID ?? 0] = rules.length;
      }
    }
  }

}
