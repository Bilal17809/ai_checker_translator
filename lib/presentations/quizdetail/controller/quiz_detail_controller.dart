
import 'package:ai_checker_translator/database/models/quiz_details_model.dart';
import 'package:ai_checker_translator/database/models/quizzes_model.dart';
import 'package:ai_checker_translator/database/services/database_helper.dart';
import 'package:get/get.dart';

class QuizDetailController extends GetxController {
  
  var details = <QuizDetailsModel>[].obs;
  var isLoading = true.obs;
  var quizzesList = <QuizzesModel>[].obs;

  Future<void> fetchDetails(int quizID) async {
    isLoading.value = true;
    final db = DatabaseHelper();
    await db.initDatabase();
    details.value = await db.fetchQuizDetailsByQuizID(quizID);
    isLoading.value = false;
  }





  Future<void> fetchQuizzesByCategoryId(int catId) async {
    try {
      isLoading.value = true;

      final db = DatabaseHelper();
      await db.initDatabase();

      // Fetch all quizzes with matching catId
      final result = await db.fetchQuizzesByCatId(catId);
      quizzesList.value = result;
      print("Fetched ${result.length} quizzes for catId: $catId");
    } catch (e) {
      print("Error fetching quizzes: $e");
    } finally {
      isLoading.value = false;
    }
  }
}
