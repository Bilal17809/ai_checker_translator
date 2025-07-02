import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart'; // ✅ Added
import '../../../data/models/quiz_details_model.dart';
import '../../../data/models/quizzes_model.dart';
import '../../../data/services/database_helper.dart';

class QuizDetailController extends GetxController {
  var quizzesList = <QuizzesModel>[].obs;
  var details = <QuizDetailsModel>[].obs;
  var currentPage = 0.obs;
  var isResultMode = false.obs;

  void showResultMode() {
    isResultMode.value = true;
  }

  var isLoading = false.obs;
  var selectedAnswers = <int, String>{}.obs;

  // ✅ Added: reactive map to store correct answers by level ID (e.g., catId)
  var correctAnswersPerLevel = <int, int>{}.obs;

  // ✅ Added: load per-level correct answers when controller initializes
  @override
  void onInit() {
    super.onInit();
    loadCorrectAnswersForLevel(1);
  }

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

      // ✅ Load saved correct answers count for this level
      await loadCorrectAnswersForLevel(catId);
    } catch (e) {
      print("❌ Error fetching quizzes or details: $e");
    } finally {
      isLoading.value = false;
    }
  }

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

  void selectAnswer(int quizID, String content) {
    if (!selectedAnswers.containsKey(quizID)) {
      selectedAnswers[quizID] = content;
    }
  }

  bool isCorrectAnswer(int quizID, String selectedContent) {
    final quiz = quizzesList.firstWhereOrNull((q) => q.quizID == quizID);
    final selectedOption = details.firstWhereOrNull(
      (d) => d.quizID == quizID && d.content == selectedContent,
    );

    if (quiz == null || selectedOption == null) return false;

    return quiz.answer.trim().toLowerCase() ==
        selectedOption.code.trim().toLowerCase();
  }

  bool hasAnswered(int quizID) {
    return selectedAnswers.containsKey(quizID);
  }

  int get correctAnswersCount {
    final count =
        quizzesList.where((quiz) {
      final selected = selectedAnswers[quiz.quizID];
      print('Checking quiz: ${quiz.quizID}');
      print('  Answer: ${quiz.answer}');
      print('  Selected: ${selectedAnswers[quiz.quizID]}');
      return selected != null &&
              selected.trim().toLowerCase() == quiz.answer.trim().toLowerCase();
    }).length;

    // ✅ Save to SharedPreferences if current level has quizzes
    if (quizzesList.isNotEmpty) {
      final catId = quizzesList.first.catID;
      saveCorrectAnswersForLevel(catId, count);
    }

    return count;
  }

  double? get percentageScore {
    if (quizzesList.isEmpty) return 0;
    return (correctAnswersCount / quizzesList.length) * 100;
  }

  void resetQuiz() {
    selectedAnswers.clear();
    currentPage.value = 0;
    isResultMode.value = false;
  }


  // ✅ Save correct answer count to SharedPreferences
  Future<void> saveCorrectAnswersForLevel(int catId, int count) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt('correct_level_$catId', count);
    correctAnswersPerLevel[catId] = count;
    print("✅ Saved correct answers for level $catId: $count");
  }

  // ✅ Load correct answer count from SharedPreferences
  Future<void> loadCorrectAnswersForLevel(int catId) async {
    final prefs = await SharedPreferences.getInstance();
    final saved = prefs.getInt('correct_level_$catId') ?? 0;
    correctAnswersPerLevel[catId] = saved;
    print("✅ Loaded correct answers for level $catId: $saved");
  }

  //load progress
  Future<void> loadOnlyProgressForLevels(List<int> levelCatIds) async {
    final prefs = await SharedPreferences.getInstance();

    for (final catId in levelCatIds) {
      final correct = prefs.getInt('correct_level_$catId') ?? 0;
      correctAnswersPerLevel[catId] = correct;
    }

    print("✅ Only progress loaded for levels: $correctAnswersPerLevel");
  }

  // Future<void> saveResultAfterQuiz() async {
  //   if (quizzesList.isEmpty) return;

  //   final correct = correctAnswersCount;
  //   final catId = quizzesList.first.catID;

  //   await saveCorrectAnswersForLevel(catId, correct);
  //   print("📌 Final result saved for catId $catId => $correct correct");
  // }

}
