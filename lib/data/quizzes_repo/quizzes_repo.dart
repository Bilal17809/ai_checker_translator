
import 'package:ai_checker_translator/data/services/database_helper.dart';
import 'package:sqflite/sqflite.dart';
import '../models/quizzess_models/categories_model.dart';
import '../models/quizzess_models/menu_model.dart';
import '../models/quizzess_models/quiz_details_model.dart';
import '../models/quizzess_models/quizzes_model.dart';
// import '../../data/services/database_service.dart';

class QuizRepository {
  late Database _db;
  final String dbName;

  QuizRepository(this.dbName);

  Future<void> init() async {
    _db = await DatabaseHelper.initDatabase(dbName);
  }

  Future<List<MenuModel>> fetchMenu() async {
    final data = await _db.query('Menu');
    return data.isNotEmpty ? data.map((e) => MenuModel.fromMap(e)).toList() : [];
  }

  Future<List<CategoriesModel>> fetchCategories() async {
    try {
      final data = await _db.query('Categories', where: "MenuID = ?", whereArgs: []);
      return data.isNotEmpty ? data.map((e) => CategoriesModel.fromMap(e)).toList() : [];
    } catch (e) {
      print(" Error fetching categories: $e");
      return [];
    }
  }

  Future<List<QuizzesModel>> fetcQuizzes() async {
    try {
      final data = await _db.query('Quizzes');
      return data.isNotEmpty ? data.map((e) => QuizzesModel.fromMap(e)).toList() : [];
    } catch (e) {
      print(" Error fetching Quizzes: $e");
      return [];
    }
  }

  Future<List<QuizDetailsModel>> fetchQuizDetailsByQuizID(int quizID) async {
    try {
      final data = await _db.query('QuizDetail', where: 'QuizID = ?', whereArgs: [quizID]);
      return data.isNotEmpty ? data.map((e) => QuizDetailsModel.fromMap(e)).toList() : [];
    } catch (e) {
      print(" Error fetching Quiz Details for QuizID $quizID: $e");
      return [];
    }
  }

  Future<List<CategoriesModel>> fetchLevelsByCategoryName(int menuId) async {
    try {
      final data = await _db.query('Categories', where: "MenuID = ?", whereArgs: [menuId]);
      return data.isNotEmpty ? data.map((e) => CategoriesModel.fromMap(e)).toList() : [];
    } catch (e) {
      print(" Error fetching levels: $e");
      return [];
    }
  }

  Future<List<QuizzesModel>> fetchQuizzesByCatId(int catId) async {
    try {
      final result = await _db.query('Quizzes', where: 'CatID = ?', whereArgs: [catId]);
      return result.map((e) => QuizzesModel.fromMap(e)).toList();
    } catch (e) {
      print(" Error fetching quizzes by catId: $e");
      return [];
    }
  }
}


// ✅ usage inside controller:
// // import '../../data/repositories/quiz_repository.dart';
// final _repo = QuizRepository('english_grammer.db');
// await _repo.init();
// final menu = await _repo.fetchMenu();
// final quizzes = await _repo.fetchQuizzesByCatId(1);
