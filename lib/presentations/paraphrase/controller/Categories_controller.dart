
import 'package:ai_checker_translator/database/models/categories_model.dart';
import 'package:ai_checker_translator/database/services/database_helper.dart';
import 'package:get/get.dart';


class CategoriesController extends GetxController {

  var categoriesList = <CategoriesModel>[].obs;
  var isLoading = true.obs;

  @override
  void onInit() {
    super.onInit();
     fetchCategoriesData();
  }

  Future<void> fetchCategoriesData() async {
    isLoading.value = true;
    final db = DatabaseHelper();
    await db.initDatabase();
    categoriesList.value = await db.fetchCategories();
    isLoading.value = false;
  }
}
