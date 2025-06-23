import 'package:ai_checker_translator/database/models/quizzes_model.dart';
import 'package:ai_checker_translator/database/services/database_helper.dart';
import 'package:get/get.dart';

class QuizzesController extends GetxController {
  var quizzessList = <QuizzesModel>[].obs;
  var isLoading = true.obs;

  @override
  void onInit() {
    super.onInit();
    fetcQuizzesdata();
  }

  Future<void> fetcQuizzesdata() async {
    isLoading.value = true;
    final db = DatabaseHelper();
    await db.initDatabase();
    quizzessList.value = await db.fetcQuizzes();
    isLoading.value = false;
  }
}
