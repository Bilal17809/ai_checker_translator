
import 'package:ai_checker_translator/data/helper/database_helper.dart';
import 'package:ai_checker_translator/data/models/rules_model.dart';
import 'package:sqflite/sqflite.dart';
import '../models/categories_model.dart';
import '../models/menu_model.dart';
import '../models/quiz_details_model.dart';
import '../models/quizzes_model.dart';
class QuizRepository {
  late Database _db;
  final String dbName;
  bool isInitialized = false;

  QuizRepository(this.dbName);

  Future<void> init() async {
    _db = await DatabaseHelper.initDatabase(dbName);
  }

  Future<List<MenuModel>> fetchMenu() async {
    final data = await _db.query('Menu');
    return data.isNotEmpty ? data.map((e) => MenuModel.fromMap(e)).toList() : [];
  }

  Future<List<CategoriesModel>> fetchCategories(int menuId) async {
    try {
      final data = await _db.query(
        'Categories',
        where: "MenuID = ?",
        whereArgs: [menuId],
      );
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

//fetch Rules bycatID
  Future<List<RulesModel>> fetchRulesByCatId(int catId) async {
    try {
      final data = await _db.query(
        'Rules',
        where: 'CatID = ?',
        whereArgs: [catId],
      );
      return data.isNotEmpty
          ? data.map((e) => RulesModel.fromMap(e)).toList()
          : [];
    } catch (e) {
      print(" Error fetching rules by CatID $catId: $e");
      return [];
    }
  }
}
