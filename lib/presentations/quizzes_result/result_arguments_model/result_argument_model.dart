class ResultArguments {
  final double score;
  final int correct;
  final int wrong;
  final int total;
  final int catId;
  final String title;
  final String category;

  ResultArguments({
    required this.score,
    required this.correct,
    required this.wrong,
    required this.total,
    required this.catId,
    required this.title,
    required this.category,
  });

  factory ResultArguments.fromMap(Map<String, dynamic> map) {
    return ResultArguments(
      score: map['score'] ?? 0.0,
      correct: map['correct'] ?? 0,
      wrong: map['wrong'] ?? 0,
      total: map['total'] ?? 0,
      catId: map['catId'] ?? 0,
      title: map['title'] ?? '',
      category: map['category'] ?? '',
    );
  }
}
