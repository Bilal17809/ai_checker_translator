class TopicsModel {
  final int? id;
  final String title;
  final String desc;
  final int? favorite;

  TopicsModel({
    required this.id,
    required this.title,
    required this.desc,
    required this.favorite,
  });
  factory TopicsModel.fromMap(Map<String, dynamic> map) {
    return TopicsModel(
      id: map['id'] as int?,
      title: map['title'] ?? "Unknown",
      desc: map['desc'] ?? "unknown",
      favorite: map['favorite'] as int?,
    );
  }
}
