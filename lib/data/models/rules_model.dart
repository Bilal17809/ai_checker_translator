import 'package:ai_checker_translator/data/helper/html_helper.dart';

class RulesModel {
  final int? ruleId;
  final int? catId;
  final String ruleName;
  final String content;

  RulesModel({
    required this.ruleId,
    required this.catId,
    required this.ruleName,
    required this.content,
  });

  factory RulesModel.fromMap(Map<String, dynamic> map) {
    return RulesModel(
      ruleId: map["RuleID"] as int?,
      catId: map["CatID"] as int?,
      ruleName: HtmlHelper.stripHtmlTags(map["RuleName"] ?? "Unknown",),
      content:HtmlHelper.stripHtmlTags(map["Content"] ?? "Unknown"),
    );
  }

  String get titleOnly => ruleName.split('|').first.trim();
  String get definitionOnly => ruleName.contains('| ' )
      ? content
      : content;
}
