import 'dart:io';
import 'package:flutter/services.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

// import '../models/categories_model.dart';
// import '../models/menu_model.dart';
// import '../models/quiz_details_model.dart';
// import '../models/quizzes_model.dart';

class DatabaseHelper {

// late  Database _db;
  // init database...
static Future<Database> initDatabase(String dbName) async {
    final databasesPath = await getDatabasesPath();
    final path = join(databasesPath, dbName);

    final exists = await databaseExists(path);

    if (!exists) {
      try {
        await Directory(dirname(path)).create(recursive: true);
        final data = await rootBundle.load('assets/$dbName');
        final bytes = data.buffer.asUint8List(
          data.offsetInBytes,
          data.lengthInBytes,
        );
        await File(path).writeAsBytes(bytes, flush: true);
        print('✅ $dbName copied from assets');
      } catch (e) {
        print('❌ Error copying $dbName: $e');
      }
    } else {
      print('📦 $dbName already exists');
    }

    return await openDatabase(path, readOnly: false);
  }
}




//   // fetch Menu data from database
// Future<List<MenuModel>> fetchMenu() async {
//   final List<Map<String, dynamic>> data = await _db.query('Menu');
//   if (data.isNotEmpty) {
//     return data.map((e) => MenuModel.fromMap(e)).toList();
//   } else {
//     return [];
//   } 
// }


// Future<List<CategoriesModel>> fetchCategories() async {
//   try {
//       final List<Map<String, dynamic>> data = await _db.query(
//         'Categories',
//         where: "MenuID = ?",
//         whereArgs: [],
//       );
//     if (data.isNotEmpty) {
//       return data.map((e) => CategoriesModel.fromMap(e)).toList();
//     } else {
//       return [];
//     }
//   } catch (e) {
//     print("Error fetching categories: $e");
//     return [];
//   }
// }


// Future<List<QuizzesModel>> fetcQuizzes() async {
//     try {
//       final List<Map<String, dynamic>> quizzesdata = await _db.query('Quizzes');
//       if (quizzesdata.isNotEmpty) {
//         return quizzesdata.map((e) => QuizzesModel.fromMap(e)).toList();
//       } else {
//         return [];
//       }
//     } catch (e) {
//       print("Error fetching Quizzes:$e");
//       return [];
//     }
//   }


// //fetch quizess details
//   Future<List<QuizDetailsModel>> fetchQuizDetailsByQuizID(int quizID) async {
//     try {
//       final List<Map<String, dynamic>> quizzesDetailData = await _db.query(
//         'QuizDetail',
//         where: 'QuizID = ?',
//         whereArgs: [quizID],
//       );

//       if (quizzesDetailData.isNotEmpty) {
//         return quizzesDetailData
//             .map((e) => QuizDetailsModel.fromMap(e))
//             .toList();
//       } else {
//         return [];
//       }
//     } catch (e) {
//       print("Error fetching Quiz Details for QuizID $quizID: $e");
//       return [];
//     }
//   }



// Future<List<CategoriesModel>> fetchLevelsByCategoryName(int menuId) async {
//     try {
//       final List<Map<String, dynamic>> data = await _db.query(
//         'Categories',
//         where: "MenuID = ?",
//         whereArgs: [menuId],
//       );

//       if (data.isNotEmpty) {
//         return data.map((e) => CategoriesModel.fromMap(e)).toList();
//       } else {
//         return [];
//       }
//     } catch (e) {
//       print("Error fetching levels: $e");
//       return [];
//     }
//   }
  

//   Future<List<QuizzesModel>> fetchQuizzesByCatId(int catId) async {
//     try {
//       final List<Map<String, dynamic>> result = await _db.query(
//         'Quizzes',
//         where: 'CatID = ?', // Make sure column name is correct!
//         whereArgs: [catId],
//       );
//       return result.map((e) => QuizzesModel.fromMap(e)).toList();
//     } catch (e) {
//       print("Error fetching quizzes by catId: $e");
//       return [];
//     }
//   }


// //  static final DatabaseHelper _instance = DatabaseHelper._internal();
// //   factory DatabaseHelper() => _instance;
// //   DatabaseHelper._internal();

// //   static Database? _database;

// //   Future<Database> get database async {
// //     if (_database != null) return _database!;
// //     _database = await _initDB();
// //     return _database!;
// //   }

// //   Future<Database> _initDB() async {
// //     final dbPath = await getDatabasesPath();
// //     final path = join(dbPath, 'english_grammer.db');

// //     return await openDatabase(path, version: 1);
// //   }

// }
