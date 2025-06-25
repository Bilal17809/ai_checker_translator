import 'package:ai_checker_translator/presentations/Quiz_levels/controller/quizzeslevel_controller.dart';
import 'package:ai_checker_translator/presentations/aska/view/ask_ai_screen.dart';
import 'package:ai_checker_translator/presentations/paraphrase/controller/Categories_controller.dart';
import 'package:ai_checker_translator/presentations/paraphrase/model/grammarcategory_model.dart';
import 'package:ai_checker_translator/presentations/quizdetail/controller/quiz_detail_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class QuizLevelScreen extends StatefulWidget {
  const QuizLevelScreen({super.key});

  @override
  State<QuizLevelScreen> createState() => _QuizLevelScreenState();
}

class _QuizLevelScreenState extends State<QuizLevelScreen> {
  
  late final GrammarCategoryModel category;
  final quizzeslevelController = Get.find<QuizzeslevelController>();
  final categoriesController = Get.find<CategoriesController>();
  final QuizDetailController controller = Get.put(QuizDetailController());

  @override
  void initState() {
    super.initState();
    category = Get.arguments as GrammarCategoryModel;

    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (quizzeslevelController.selectedCategory.value !=
          category.title.trim()) {
        quizzeslevelController.fetchLevelsByCategory(category.title.trim());
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final String categoryTitle = category.title.trim();

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.teal,
        title: Obx(
          () => Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                categoryTitle,
                style: const TextStyle(fontSize: 18, color: Colors.white),
              ),
              const SizedBox(width: 08),
              Text(
                "0 / ${quizzeslevelController.totalQuizCount}",
                style: const TextStyle(fontSize: 18, color: Colors.white),
              ),
            ],
          ),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: () => quizzeslevelController.refreshData(),
          ),
        ],
      ),

      body: Obx(() {
        if (quizzeslevelController.isLoading.value) {
          return const Center(child: CircularProgressIndicator());
        }

        if (quizzeslevelController.filteredCategoriesList.isEmpty) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text("No levels found for $categoryTitle"),
                const SizedBox(height: 16),
                ElevatedButton(
                  onPressed: () => quizzeslevelController.refreshData(),
                  child: const Text("Retry"),
                ),
              ],
            ),
          );
        }

        return ListView.builder(
          padding: const EdgeInsets.all(16),
          itemCount: quizzeslevelController.filteredCategoriesList.length,
          itemBuilder: (context, index) {
            final item = quizzeslevelController.filteredCategoriesList[index];
            final levelIndicator = _getLevelIndicator(item.catName ?? '');

            return Card(
              margin: const EdgeInsets.only(bottom: 12),
              elevation: 4,
              child: ListTile(
                leading: CircleAvatar(
                  backgroundColor: Colors.teal,
                  child: Text(
                    levelIndicator.isNotEmpty ? levelIndicator : '${index + 1}',
                    style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                title: Text(
                  item.catName ?? 'Unknown',
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
                trailing: const Icon(
                  Icons.arrow_forward_ios,
                  color: Colors.teal,
                  size: 16,
                ),
                onTap: () {
                  final catId = item.catID;

                  if (catId != null) {
                    controller.fetchQuizzesByCategoryId(catId);
                  }

                  Get.toNamed(
                    '/quizzes_scren',
                    arguments: {
                      'title': item.catName,
                      'category': categoryTitle,
                      'catId': item.catID,
                    },
                  );
                },
              ),
            );
          },
        );
      }),
    );
  }

  // Optional: Get level label from name
  String _getLevelIndicator(String catName) {
    final name = catName.toLowerCase();
    if (name.contains('level a')) return 'A';
    if (name.contains('level b')) return 'B';
    if (name.contains('level c')) return 'C';
    if (name.contains('quiz 1')) return '1';
    if (name.contains('quiz 2')) return '2';
    if (name.contains('quiz 3')) return '3';
    return '';
  }
}
