import 'dart:io';
import 'package:ai_checker_translator/database/models/categories_model.dart';
import 'package:ai_checker_translator/database/models/menu_model.dart';
import 'package:ai_checker_translator/database/models/quiz_details_model.dart';
import 'package:ai_checker_translator/database/models/quizzes_model.dart';
import 'package:flutter/services.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseHelper {

late  Database _db;
  // init database...
Future<void> initDatabase() async {
  var databasesPath = await getDatabasesPath();
  var path = join(databasesPath, 'english_grammer.db');

  // Delete old DB (development only)
  await deleteDatabase(path);
  var exists = await databaseExists(path);

  if (!exists) {
    print('DB not found, copying from assets...');
    try {
      await Directory(dirname(path)).create(recursive: true);
      ByteData data = await rootBundle.load('assets/english_grammer.db');
      List<int> bytes = data.buffer.asUint8List(data.offsetInBytes, data.lengthInBytes);
      await File(path).writeAsBytes(bytes, flush: true);
      print('DB copied successfully');
    } catch (e) {
      print('Error copying database: $e');
    }
  } else {
    print('DB already exists');
  }
  _db = await openDatabase(path, readOnly: false);
  // // Debug: print all table names
  // List<Map<String, dynamic>> tables =
  //     await _db.rawQuery("SELECT name FROM sqlite_master WHERE type='table'");
  // print("Tables in DB: ${tables.map((e) => e['name']).toList()}");
}

  // fetch Menu data from database
Future<List<MenuModel>> fetchMenu() async {
  final List<Map<String, dynamic>> data = await _db.query('Menu');
  if (data.isNotEmpty) {
    return data.map((e) => MenuModel.fromMap(e)).toList();
  } else {
    return [];
  } 
}


Future<List<CategoriesModel>> fetchCategories() async {
  try {
      final List<Map<String, dynamic>> data = await _db.query(
        'Categories',
        where: "MenuID = ?",
        whereArgs: [],
      );
    if (data.isNotEmpty) {
      return data.map((e) => CategoriesModel.fromMap(e)).toList();
    } else {
      return [];
    }
  } catch (e) {
    print("Error fetching categories: $e");
    return [];
  }
}


Future<List<QuizzesModel>> fetcQuizzes() async {
    try {
      final List<Map<String, dynamic>> quizzesdata = await _db.query('Quizzes');
      if (quizzesdata.isNotEmpty) {
        return quizzesdata.map((e) => QuizzesModel.fromMap(e)).toList();
      } else {
        return [];
      }
    } catch (e) {
      print("Error fetching Quizzes:$e");
      return [];
    }
  }



  Future<List<QuizDetailsModel>> fetchQuizDetailsByQuizID(int quizID) async {
    try {
      final List<Map<String, dynamic>> quizzesDetailData = await _db.query(
        'QuizDetail',
        where: 'QuizID = ?',
        whereArgs: [quizID],
      );

      if (quizzesDetailData.isNotEmpty) {
        return quizzesDetailData
            .map((e) => QuizDetailsModel.fromMap(e))
            .toList();
      } else {
        return [];
      }
    } catch (e) {
      print("Error fetching Quiz Details for QuizID $quizID: $e");
      return [];
    }
  }




Future<List<CategoriesModel>> fetchLevelsByCategoryName(int menuId) async {
    try {
      final List<Map<String, dynamic>> data = await _db.query(
        'Categories',
        where: "MenuID = ? AND CatName LIKE ?",
        whereArgs: [menuId],
      );

      if (data.isNotEmpty) {
        return data.map((e) => CategoriesModel.fromMap(e)).toList();
      } else {
        return [];
      }
    } catch (e) {
      print("Error fetching levels: $e");
      return [];
    }
  }

  Future<List<QuizzesModel>> fetchQuizzesByCatId(int catId) async {
    try {
      final List<Map<String, dynamic>> result = await _db.query(
        'Quizzes',
        where: 'CatID = ?', // Make sure column name is correct!
        whereArgs: [catId],
      );
      return result.map((e) => QuizzesModel.fromMap(e)).toList();
    } catch (e) {
      print("❌ Error fetching quizzes by catId: $e");
      return [];
    }
  }


//  static final DatabaseHelper _instance = DatabaseHelper._internal();
//   factory DatabaseHelper() => _instance;
//   DatabaseHelper._internal();

//   static Database? _database;

//   Future<Database> get database async {
//     if (_database != null) return _database!;
//     _database = await _initDB();
//     return _database!;
//   }

//   Future<Database> _initDB() async {
//     final dbPath = await getDatabasesPath();
//     final path = join(dbPath, 'english_grammer.db');

//     return await openDatabase(path, version: 1);
//   }

}
