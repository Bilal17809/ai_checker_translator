import 'dart:io';
import 'package:flutter/services.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseHelper {
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
      } catch (e) {
        print('❌ Error copying $dbName: $e');
      }
    } else {
      print('📦 $dbName already exists');
    }

    return await openDatabase(path, readOnly: false);
  }
}

