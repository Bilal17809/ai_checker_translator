
import 'package:ai_checker_translator/presentations/Quiz_levels/controller/quizzeslevel_controller.dart';
import 'package:ai_checker_translator/presentations/Quiz_levels/view/quiz_level_screen.dart';
import 'package:ai_checker_translator/presentations/paraphrase/controller/Categories_controller.dart';
import 'package:ai_checker_translator/presentations/paraphrase/widget/quizzess_grammar_widget.dart';
import 'package:ai_checker_translator/presentations/quizdetail/controller/quiz_detail_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
// import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
// import 'package:get/instance_manager.dart';
// import 'package:http/http.dart';

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
  
    return Scaffold(
      appBar: AppBar(
        title: Text("${widget.id} ${widget.menuname}"),
        backgroundColor: Colors.teal,
        centerTitle: true,
      ),
      body: Obx(() {
        if (categoriesController.isLoading.value) {
          return const Center(child: CircularProgressIndicator());
        }

        if (categoriesController.categoriesList.isEmpty) {
          return const Center(child: Text("No categories found"));
        }

        return GridView.builder(
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            mainAxisSpacing: 10,
            crossAxisSpacing: 10,
          ),
          itemCount: categoriesController.grammarCategories.length,
          itemBuilder: (context, index) {
            final item = categoriesController.grammarCategories[index];
            return QuizzessGrammarWidget(
              grammarTitle: item.title,
              quizNumber: "Quiz: ${item.quizCount}",
              onTap: () {
              
                Get.to(() => const QuizLevelScreen(), arguments: item);
              },
            );
          },
        );
       
      }),
    );
  }
}
