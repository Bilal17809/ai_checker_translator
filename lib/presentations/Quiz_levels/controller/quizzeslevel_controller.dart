import 'package:ai_checker_translator/database/models/categories_model.dart';
import 'package:ai_checker_translator/database/services/database_helper.dart';
import 'package:get/get.dart';

class QuizzeslevelController extends GetxController {
  var categoriesList = <CategoriesModel>[].obs;
  var filteredCategoriesList = <CategoriesModel>[].obs;
  var isLoading = false.obs;
  var selectedCategory = ''.obs;

  // ✅ New Observables
  var totalQuizCount = 0.obs;
  var totalQuestionCount = 0.obs;

  @override
  void onInit() {
    super.onInit();
    // Don’t fetch all data until a category is selected
  }

  /// Fetch all levels and filter them based on category name
  Future<void> fetchLevelsByCategory(String categoryName) async {
    try {
      isLoading.value = true;
      selectedCategory.value = categoryName;

      final db = DatabaseHelper();
      await db.initDatabase();

      final fetchedList = await db.fetchLevelsByCategoryName(5);
      categoriesList.value = fetchedList;

      filterLevelsByCategory(categoryName);

      /// ✅ New: Count quizzes and questions after filtering
      int quizCount = 0;
      int questionCount = 0;

      for (final category in filteredCategoriesList) {
        final catId = category.catID;
        if (catId != null) {
          final quizzes = await db.fetchQuizzesByCatId(catId);
          quizCount += quizzes.length;

          for (final quiz in quizzes) {
            final details = await db.fetchQuizDetailsByQuizID(quiz.quizID ?? 0);
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
    print('✅ Filtered ${filtered.length} levels for category: $categoryName');
  }

  Future<void> refreshData() async {
    if (selectedCategory.value.isNotEmpty) {
      await fetchLevelsByCategory(selectedCategory.value);
    }
  }
}
