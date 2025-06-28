import '../helper/html_helper.dart';

class CategoriesModel {

final int? catID;
final int? menuID;
final String catName;
final String content;

CategoriesModel({
required this.catID,
required this.menuID,
required this.catName,
required this.content
});

   factory CategoriesModel.fromMap(Map<String, dynamic> map) {
    return CategoriesModel(
      catID: map['CatID'] as int?,
      menuID: map['MenuID'] as int?,
      catName: HtmlHelper.stripHtmlTags(map['CatName'] ?? 'Unknown'),
      content: HtmlHelper.stripHtmlTags(map['Content'] ?? 'Unknown'),
    );
  }
  
}