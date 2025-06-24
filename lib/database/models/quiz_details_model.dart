
class QuizDetailsModel {

  final int quizDeatailID;
  final int quizID;
  final String content;
  final String code;

  QuizDetailsModel({
    required this.quizDeatailID,
    required this.quizID,
    required this.content,
    required this.code
  });

  factory QuizDetailsModel.fromMap(Map<String,dynamic>map){
    return QuizDetailsModel(
      quizDeatailID: map["QuizDetailID"] as int,
       quizID: map["QuizID"] as int,
        content: map["Content"] ?? "Unknown", 
        code: map["Code"]?? "Unknown"
        );
  }
}