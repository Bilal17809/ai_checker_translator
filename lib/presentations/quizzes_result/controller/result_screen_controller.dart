// lib/presentations/quizzes_result/controller/result_controller.dart

import 'package:ai_checker_translator/presentations/quizdetail/controller/quiz_detail_controller.dart';
import 'package:get/get.dart';

class ResultController extends GetxController {
  final QuizDetailController detailController = Get.find();

  /// 📦 Retake the quiz: reset + refetch + navigate
  Future<void> retakeQuiz({
    required int catId,
    required String title,
    required String category,
  }) async {
    // 🔄 Reset state
    // detailController.resetQuiz();

    // 📥 Fetch again
    await detailController.fetchQuizzesByCategoryId(catId);

    // 🔁 Navigate to quiz screen again
    Get.offNamed(
      '/quizzes_scren',
      arguments: {'catId': catId, 'title': title, 'category': category},
    );
  }
}
