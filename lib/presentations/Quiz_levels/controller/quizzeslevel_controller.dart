import 'package:get/get.dart';
import '../../../data/models/quizzess_models/categories_model.dart';
import '../../../data/quizzes_repo/quizzes_repo.dart';

class QuizzeslevelController extends GetxController {
  final QuizRepository quizRepo;
  QuizzeslevelController(this.quizRepo); 

  var categoriesList = <CategoriesModel>[].obs;
  var filteredCategoriesList = <CategoriesModel>[].obs;
  var isLoading = false.obs;
  var selectedCategory = ''.obs;

  var totalQuizCount = 0.obs;
  var totalQuestionCount = 0.obs;

  @override
  void onInit() {
    super.onInit();
    // fetchLevelsByCategory will be called after category selection
  }

  Future<void> fetchLevelsByCategory(String categoryName) async {
    try {
      isLoading.value = true;
      selectedCategory.value = categoryName;

      final fetchedList = await quizRepo.fetchLevelsByCategoryName(5);
      categoriesList.value = fetchedList;

      filterLevelsByCategory(categoryName);

      int quizCount = 0;
      int questionCount = 0;

      for (final category in filteredCategoriesList) {
        final catId = category.catID;
        if (catId != null) {
          final quizzes = await quizRepo.fetchQuizzesByCatId(catId);
          quizCount += quizzes.length;

          for (final quiz in quizzes) {
            final details = await quizRepo.fetchQuizDetailsByQuizID(
              quiz.quizID ?? 0,
            );
            questionCount += details.length;
          }
        }
      }

      totalQuizCount.value = quizCount;
      totalQuestionCount.value = questionCount;
    } catch (e) {
      print("Error in fetchLevelsByCategory: $e");
      totalQuizCount.value = 0;
      totalQuestionCount.value = 0;
    } finally {
      isLoading.value = false;
    }
  }

  void filterLevelsByCategory(String categoryName) {
    if (categoryName.isEmpty) {
      filteredCategoriesList.value = categoriesList;
      return;
    }

    var filtered =
        categoriesList.where((category) {
          String catName = (category.catName ?? '').toLowerCase().trim();
          String searchCategory = categoryName.toLowerCase().trim();
          return catName.startsWith(searchCategory);
        }).toList();

    filteredCategoriesList.value = filtered;
    print('📋 Total categories in categoriesList: ${categoriesList.length}');
    for (var category in categoriesList) {
      print('➡️ ${category.catName}');
    }
  }

  Future<void> refreshData() async {
    if (selectedCategory.value.isNotEmpty) {
      await fetchLevelsByCategory(selectedCategory.value);
    }
  }
}
