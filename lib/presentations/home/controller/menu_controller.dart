// import 'package:get/get.dart';
// import '../../../data/models/menu_model.dart';
// import '../../../data/services/database_helper.dart';

// class DbController extends GetxController {

//  var menuList = <MenuModel>[].obs;
//   RxBool isLoading = true.obs;

//   @override
//   void onInit() {
//     super.onInit();
//     // print("Data Fetct");
//     fetchData();

//   }

// Future<void> fetchData() async {
//   isLoading.value = true;
//   final db = DatabaseHelper();
//   await db.initDatabase();
//   menuList.value = await db.fetchMenu();

//   // // 👇 Add this line to print loaded data
//   // print("Fetched Menu List:");
//   // for (var item in menuList) {
//   //   print("Grammar: ${item.grammarrules}");
//   //   print("Punctuation: ${item.punctuationRules}");
//   //   print("Spelling: ${item.spellingVocabularyCommonlyConfusedWords}");
//   //   print("Other: ${item.otherRules}");
//   //   print("Quiz: ${item.quizzesGrammarPretest}");
//   // }

//   isLoading.value = false;
// }

// }

