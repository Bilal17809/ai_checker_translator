
import 'package:ai_checker_translator/core/common_widgets/keyboard_dismiss_wrapper.dart';
import 'package:ai_checker_translator/core/theme/app_colors.dart';
import 'package:ai_checker_translator/presentations/Quiz_levels/controller/quizzeslevel_controller.dart';
import 'package:ai_checker_translator/presentations/Quiz_levels/view/quiz_level_screen.dart';
import 'package:ai_checker_translator/presentations/quizzes_category_screen/controller/Categories_controller.dart';
// import 'package:ai_checker_translator/presentations/quizzes_category_screen/model/grammarcategory_model.dart';
import 'package:ai_checker_translator/presentations/quizzes_category_screen/widget/quizzess_grammar_widget.dart';
import 'package:ai_checker_translator/presentations/quizdetail/controller/quiz_detail_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class QuizessCategoryScreen extends StatefulWidget {
  const QuizessCategoryScreen({super.key});

  @override
  State<QuizessCategoryScreen> createState() => _QuizessCategoryScreenState();
}

class _QuizessCategoryScreenState extends State<QuizessCategoryScreen> {
  
 final categoriesController = Get.find<CategoriesController>();
  final quizDetailController = Get.find<QuizDetailController>();
  final quizzeslevelController = Get.find<QuizzeslevelController>();



  @override
  Widget build(BuildContext context) {
    Future.delayed(Duration(milliseconds: 50), () {
      FocusScope.of(context).unfocus();
    });
    return KeyboardDismissWrapper(
      child: Scaffold(
      backgroundColor: kWhiteF7,
      appBar: AppBar(
          iconTheme: IconThemeData(color: kWhite),
        title: Text("Quizzes", style: TextStyle(color: Colors.white)),
        backgroundColor: kMintGreen,
        centerTitle: true,
      ),
        body: GestureDetector(
          onTap: () {
            FocusScope.of(context).unfocus();
          },
          child: Obx(() {
            if (categoriesController.isLoading.value) {
              return const Center(child: CircularProgressIndicator());
            }

            if (categoriesController.grammarCategories.isEmpty) {
              return const Center(child: Text("No categories found"));
            }

            return GridView.builder(
              padding: const EdgeInsets.all(16),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                mainAxisSpacing: 18,
                crossAxisSpacing: 18,
                childAspectRatio: 3 / 3,
              ),
              itemCount: categoriesController.grammarCategories.length,
              itemBuilder: (context, index) {
                final item = categoriesController.grammarCategories[index];
                final title = item.title.trim();

                return QuizzessGrammarWidget(
                  icon: item.icons,
                  grammarTitle: title,
                  quizNumber: "Quiz: ${item.quizCount}",
                  onTap: () {
                    quizzeslevelController.fetchLevelsByCategory(
                      item.title,
                    ); // Map format
                    Get.to(
                      () => const QuizLevelScreen(),
                      arguments: item,
                    ); // Passing map to next screen
                  },
                );
              },
            );
          }),
        ),
      )
    );
  }
}