import 'package:ai_checker_translator/database/models/categories_model.dart';
import 'package:ai_checker_translator/database/services/database_helper.dart';
import 'package:get/get.dart';

class QuizzeslevelController extends GetxController {
  
  var categoriesList = <CategoriesModel>[].obs;
  var grammarCategories = <Map<String, dynamic>>[].obs;
  var isLoading = false.obs;

  @override
  void onInit() {
    super.onInit();
    fetchGrammarCategoriesFromDB();
  }

  Future<void> fetchGrammarCategoriesFromDB() async {
    try {
      isLoading.value = true;

      final db = DatabaseHelper();
      await db.initDatabase();
      final fetchedList = await db.fetchLevelsByCategoryName(5); 
      categoriesList.value = fetchedList;

      // 🔄 Group by catName and count occurrences
      final Map<String, int> grouped = {};
      for (var item in fetchedList) {
        final catName = item.catName.trim();
        grouped[catName] = (grouped[catName] ?? 0) + 1;
      }

      // 🔁 Convert grouped map to List<Map<String, dynamic>>
      grammarCategories.value = grouped.entries.map((entry) {
        return {
          'title': entry.key,
          'level': grouped.keys.toList().indexOf(entry.key) + 1, 
          'quizCount': entry.value,
        };
      }).toList();
    } catch (e) {
      print("Error in fetchGrammarCategoriesFromDB: $e");
    } finally {
      isLoading.value = false;
    }
  }
}
