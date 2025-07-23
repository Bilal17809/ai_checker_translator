

import 'package:ai_checker_translator/data/helper/storage_helper.dart';
import 'package:ai_checker_translator/data/helper/storage_keys.dart';
import 'package:ai_checker_translator/data/models/rules_model.dart';
import 'package:ai_checker_translator/data/services/quizzes_repo.dart';
import 'package:ai_checker_translator/gen/assets.gen.dart';
import 'package:ai_checker_translator/presentations/learn_grammaer/view/rules_detail_screen.dart';
import 'package:ai_checker_translator/presentations/quizzes_category_screen/model/grammarcategory_model.dart';
import 'package:get/get.dart';
import '../../../ads_manager/interstitial_ads.dart';
import '../../../data/models/categories_model.dart';

class CategoriesController extends GetxController {
  final QuizRepository quizRepo;
  CategoriesController(this.quizRepo);

  var categoriesList = <CategoriesModel>[].obs;
  var rulesList = <RulesModel>[].obs;
  var rulesCountMap = <int, int>{}.obs;
  var isLoading = true.obs;

  var learnedMap = <int, Set<int>>{}.obs;
  var contentLearned = <int>{}.obs;
  var learnedCategories = <int>{}.obs;

  final prefs = SharedPrefService();

  void markCategoryContentAsLearned(int catId) {
    contentLearned.add(catId);
    contentLearned.refresh();
    _saveProgressToPrefs();
  }

  void unmarkCategoryContentAsLearned(int catId) {
    contentLearned.remove(catId);
    contentLearned.refresh();
    _saveProgressToPrefs(); 
  }

  bool isCategoryWithoutRulesLearned(int catId) {
    return rulesCountMap[catId] == null && contentLearned.contains(catId);
  }

  var grammarCategories =
      <GrammarCategoryModel>[
        GrammarCategoryModel(
          title: "Nouns",
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
    Get.find<InterstitialAdController>().checkAndShowAd();
    _loadSavedData();
    fetchCategoriesData(1);
  }

 

  void _loadSavedData() async {
    final rulesData = prefs.learnedRules;
    
    for (final entry in rulesData) {
      final parts = entry.split(":");
      if (parts.length == 2) {
        final catId = int.tryParse(parts[0]);
        final ruleId = int.tryParse(parts[1]);
        if (catId != null && ruleId != null) {
          learnedMap[catId] ??= <int>{};
          learnedMap[catId]!.add(ruleId);
        }
      }
    }

    // final contentData = await StorageHelper.loadList(
    //   LearnGrammarKeys.contentLearned,
    // );
    contentLearned.addAll(prefs.contentLearned.map(int.parse));

  }

  Future<void> _saveProgressToPrefs() async {
    final learnedRules = <String>[];
    learnedMap.forEach((catId, ruleSet) {
      for (final ruleId in ruleSet) {
        learnedRules.add('$catId:$ruleId');
      }
    });

    prefs.learnedRules = learnedRules;
    prefs.contentLearned = contentLearned.map((e) => e.toString()).toList();
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

  void toggleLearnedRule(int catId, int ruleId) {
    if (!learnedMap.containsKey(catId)) {
      learnedMap[catId] = <int>{};
    }

    if (learnedMap[catId]!.contains(ruleId)) {
      learnedMap[catId]!.remove(ruleId);
    } else {
      learnedMap[catId]!.add(ruleId);
    }

    learnedMap.refresh();
    _saveProgressToPrefs(); 
  }


  void toggleCategoryContentLearned(int catId) {
    if (contentLearned.contains(catId)) {
      contentLearned.remove(catId); 
    } else {
      contentLearned.add(catId); 
    }
    contentLearned.refresh();
    _saveProgressToPrefs();
  }

  double getProgressForCategory(int catId) {
    final total = rulesCountMap[catId] ?? 0;
    if (total == 0) {
      return contentLearned.contains(catId) ? 1.0 : 0.0;
    }
    final learned = learnedMap[catId]?.length ?? 0;
    return learned / total;
  }

  bool isRuleLearned(int catId, int ruleId) {
    return learnedMap[catId]?.contains(ruleId) ?? false;
  }

  bool isCategoryContentLearned(int catId) {
    return contentLearned.contains(catId);
  }


}
