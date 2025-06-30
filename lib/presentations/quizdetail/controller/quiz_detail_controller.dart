import 'package:get/get.dart';
import '../../../data/models/quiz_details_model.dart';
import '../../../data/models/quizzes_model.dart';
import '../../../data/services/database_helper.dart';

class QuizDetailController extends GetxController {
  
  var quizzesList = <QuizzesModel>[].obs;
  var details = <QuizDetailsModel>[].obs;
  var currentPage = 1.obs;
  var isResultMode = false.obs;


void showResultMode() {
    isResultMode.value = true;
  }

  var isLoading = false.obs;
  var selectedAnswers = <int, String>{}.obs;
  Future<void> fetchQuizzesByCategoryId(int catId) async {
    try {
      isLoading.value = true;

      final db = DatabaseHelper();
      await db.initDatabase();

      final quizzes = await db.fetchQuizzesByCatId(catId);
      quizzesList.value = quizzes;
      print("✅ Fetched ${quizzes.length} quizzes for catId: $catId");

      final allDetails = <QuizDetailsModel>[];
      for (final quiz in quizzes) {
        if (quiz.quizID != null) {
          final options = await db.fetchQuizDetailsByQuizID(quiz.quizID);
          allDetails.addAll(options);
        }
      }

      details.value = allDetails;
      print("✅ Fetched ${details.length} total quiz options");
    } catch (e) {
      print("❌ Error fetching quizzes or details: $e");
    } finally {
      isLoading.value = false;
    }
  }

  /// ✅ Fetch options for a specific quiz
  Future<void> fetchDetails(int quizID) async {
    try {
      isLoading.value = true;

      final db = DatabaseHelper();
      await db.initDatabase();

      final options = await db.fetchQuizDetailsByQuizID(quizID);
      details.value = options;
      print("✅ Fetched ${options.length} options for quizID: $quizID");

    } catch (e) {
      print("❌ Error fetching quiz details: $e");
    } finally {
      isLoading.value = false;
    }
  }

  /// ✅ Select an answer
  void selectAnswer(int quizID, String content) {
    if (!selectedAnswers.containsKey(quizID)) {
      selectedAnswers[quizID] = content;
    }
  }

  /// ✅ Check if user selected the correct option by matching code
  bool isCorrectAnswer(int quizID, String selectedContent) {
    final quiz = quizzesList.firstWhereOrNull((q) => q.quizID == quizID);
    final selectedOption = details.firstWhereOrNull(
      (d) => d.quizID == quizID && d.content == selectedContent,
    );

    if (quiz == null || selectedOption == null) return false;

    return quiz.answer.trim().toLowerCase() ==
        selectedOption.code.trim().toLowerCase();
  }

  /// ✅ Check if quiz is already answered
  bool hasAnswered(int quizID) {
    return selectedAnswers.containsKey(quizID);
  }

  //answer correction logic
  int get correctAnswersCount {
    return quizzesList.where((quiz) {
      final selected = selectedAnswers[quiz.quizID];
      print('Checking quiz: ${quiz.quizID}');
      print('  Answer: ${quiz.answer}');
      print('  Selected: ${selectedAnswers[quiz.quizID]}');
      return selected != null &&
          selected.trim().toLowerCase() == quiz.answer.trim().toLowerCase();
          
    }).length;
  }

  double? get percentageScore {
    if (quizzesList.isEmpty) return 0;
    return (correctAnswersCount / quizzesList.length) * 100;
  }

  void resetQuiz() {
    // quizzesList.clear();
    selectedAnswers.clear();
    currentPage.value = 0;
    isResultMode.value = false;
  }
}
