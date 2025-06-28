import 'package:get/get.dart';
import '../../../data/models/quizzes_model.dart';
import '../../../data/services/database_helper.dart';

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
