
class TopicphraseModel {
  final int? id;
  final int? topicId;
  final String explaination;
  final String sentence;

  TopicphraseModel({
    required this.id,
    required this.topicId,
    required this.explaination,
    required this.sentence,
  });

  factory TopicphraseModel.fromMap(Map<String, dynamic> map) {
    return TopicphraseModel(
      id: map['id'] as int?,
      topicId: map['TopicId'] as int?,
      explaination: map['explaination'] ?? "Unknown",
      sentence: map['sentence'] ?? "Unknown",
    );
  }
}
