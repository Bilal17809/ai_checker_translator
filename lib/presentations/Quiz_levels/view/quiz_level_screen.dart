import 'package:ai_checker_translator/core/theme/app_colors.dart';
import 'package:ai_checker_translator/presentations/Quiz_levels/controller/quizzeslevel_controller.dart';
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
        title: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                categoryTitle,
                style: const TextStyle(fontSize: 18, color: Colors.white),
              ),
              const SizedBox(width: 8),
            // Text(
            //   "0/${quizzeslevelController.totalQuizCount}",
            //   style: const TextStyle(fontSize: 18, color: Colors.white),
            // ),
            ],
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

        return GridView.builder(
          padding: const EdgeInsets.all(16),
          itemCount: quizzeslevelController.filteredCategoriesList.length,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 16,
            mainAxisSpacing: 16,
            childAspectRatio: 3 / 3,
          ),
          itemBuilder: (context, index) {
            final item = quizzeslevelController.filteredCategoriesList[index];
            // final levelIndicator = _getLevelIndicator(item.catName ?? '');

            return Stack(
              clipBehavior: Clip.none,
              children: [
                /// Main Container with content
                Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12),
                    boxShadow: [BoxShadow(color: Colors.grey, blurRadius: 1)],
                  ),
                  child: InkWell(
                    borderRadius: BorderRadius.circular(12),
                    onTap: () async {
                      controller.resetQuiz();
                      final catId = item.catID;
                      if (catId != null) {
                        await controller.fetchQuizzesByCategoryId(catId);
                        Get.toNamed(
                          '/quizzes_scren',
                          arguments: {
                            'title': item.catName,
                            'category': category.title.trim(),
                            'catId': catId,
                          },
                        );
                      }
                    },
                    child: Stack(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(12),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              const SizedBox(height: 20), // space for badge
                              Center(
                                child: Text(
                                  "${category.title} - ${item.catName ?? 'Unknown'}",
                                  style: const TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w600,
                                  ),
                                  textAlign: TextAlign.center,
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),

                /// Number badge (1, 2, 3...)
                Positioned(
                  top: -10,
                  left: -10,
                  child: Container(
                    padding: const EdgeInsets.all(10),
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      color: kMediumGreen2,
                    ),
                    child: Text(
                      '${index + 1}',
                      style: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ],
);

          },
        );
      }),
    );
  }
}

//   String _getLevelIndicator(String catName) {
//     final name = catName.toLowerCase();
//     if (name.contains('level a')) return 'A';
//     if (name.contains('level b')) return 'B';
//     if (name.contains('level c')) return 'C';
//     if (name.contains('quiz 1')) return '1';
//     if (name.contains('quiz 2')) return '2';
//     if (name.contains('quiz 3')) return '3';
//     return '';
//   }
// }
