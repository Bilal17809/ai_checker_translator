

import 'package:ai_checker_translator/database/helper/html_helper.dart';

class QuizzesModel {
  final int quizID;
  final int catID;
  final String content;
  final String answer;
  final String explanation;

  QuizzesModel({
    required this.quizID,
    required this.catID,
    required this.content,
    required this.answer,
    required this.explanation,
  });

  factory QuizzesModel.fromMap(Map<String, dynamic> map) {
    return QuizzesModel(
      quizID: map["QuizID"] as int,
      catID: map["CatID"] as int,
      content: HtmlHelper.stripHtmlTags(map["Content"] ?? "Unknown"),
      answer: HtmlHelper.stripHtmlTags(map["Answer"] ?? "Unknown"),
      explanation: HtmlHelper.stripHtmlTags(map["Explanation"] ?? "Unknown"),
    );
  }

}