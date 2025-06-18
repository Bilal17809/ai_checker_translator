
class MenuModel {
  final String? grammarrules;
  final String? punctuationRules;
  final String? spellingVocabularyCommonlyConfusedWords;
  final String? otherRules;
  final String? quizzesGrammarPretest;

  MenuModel({
    required this.grammarrules,
    required this.punctuationRules,
    required this.spellingVocabularyCommonlyConfusedWords,
    required this.otherRules,
    required this.quizzesGrammarPretest,
  });

factory MenuModel.fromMap(Map<String, dynamic> map) {
  return MenuModel(
    grammarrules: map['Grammar Rules'] ?? '',
    punctuationRules: map['Punctuation Rules'] ?? '',
    spellingVocabularyCommonlyConfusedWords: map['Spelling, Vocabulary and Commonly Confused Words'] ?? '',
    otherRules: map['Other Rules'] ?? '',
    quizzesGrammarPretest: map['Quizzes - Grammar Pretest'] ?? '',
  );
}
}