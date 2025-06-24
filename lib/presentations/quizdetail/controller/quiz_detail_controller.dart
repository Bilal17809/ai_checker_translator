
import 'package:ai_checker_translator/database/models/quiz_details_model.dart';
import 'package:ai_checker_translator/database/services/database_helper.dart';
import 'package:get/get.dart';

class QuizDetailController extends GetxController {
  
  var details = <QuizDetailsModel>[].obs;
  var isLoading = true.obs;

  Future<void> fetchDetails(int quizID) async {
    isLoading.value = true;
    final db = DatabaseHelper();
    await db.initDatabase();
    details.value = await db.fetchQuizDetailsByQuizID(quizID);
    isLoading.value = false;
  }
}
