import 'package:ai_checker_translator/core/common_widgets/keyboard_dismiss_wrapper.dart';
import 'package:ai_checker_translator/core/theme/app_colors.dart';
import 'package:ai_checker_translator/presentations/Quiz_levels/controller/quizzeslevel_controller.dart';
import 'package:ai_checker_translator/presentations/Quiz_levels/view/quiz_level_screen.dart';
import 'package:ai_checker_translator/presentations/paraphrase/controller/Categories_controller.dart';
import 'package:ai_checker_translator/presentations/paraphrase/model/grammarcategory_model.dart';
import 'package:ai_checker_translator/presentations/paraphrase/widget/quizzess_grammar_widget.dart';
import 'package:ai_checker_translator/presentations/quizdetail/controller/quiz_detail_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ParaphraseView extends StatefulWidget {
  final int id;
  final String menuname;
  const ParaphraseView({super.key, this.id = 0, this.menuname = ''});

  @override
  State<ParaphraseView> createState() => _ParaphraseViewState();
}

class _ParaphraseViewState extends State<ParaphraseView> {
  final categoriesController = Get.put(CategoriesController());
  final quizDetailController = Get.put(QuizDetailController());
  final quizzeslevelController = Get.put(QuizzeslevelController());



  @override
  Widget build(BuildContext context) {
    return KeyboardDismissWrapper(
      child: Scaffold(
      backgroundColor: kWhiteF7,
      appBar: AppBar(
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
