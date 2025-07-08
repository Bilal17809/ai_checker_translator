
import 'package:ai_checker_translator/data/models/topicphrase_model.dart';
import 'package:ai_checker_translator/data/models/topics_model.dart';
import 'package:ai_checker_translator/data/helper/database_helper.dart';
import 'package:sqflite/sqflite.dart';

class ParaphraseRepo {

late Database _db;
final String dbName;

ParaphraseRepo(this.dbName);
   
   Future<void> initDatabase()async{
      _db = await DatabaseHelper.initDatabase(dbName);
   }



//fetch Topics from database
     Future<List<TopicsModel>> fetctTopics()async{
      try{
        final data = await _db.query("Topics");
        return data.isNotEmpty ? data.map((e) => TopicsModel.fromMap(e)).toList() : [];
      }catch(e){
        print(" Error fetching Topics: $e");
        return [];
      }
     }



// fetch phrases by topic id
Future<List<TopicphraseModel>> fetchTopicsPhraseByTopicId(int topicId) async {
  try {
    final data = await _db.query(
      "TopicPhrases", 
      where: "TopicId = ?",
      whereArgs: [topicId],
    );
    return data.isNotEmpty
        ? data.map((e) => TopicphraseModel.fromMap(e)).toList()
        : [];
  } catch (e) {
    print("Error fetching topic phrases: $e");
    return [];
  }
}
}