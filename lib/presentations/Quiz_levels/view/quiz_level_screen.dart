
import 'package:ai_checker_translator/presentations/Quiz_levels/controller/quizzeslevel_controller.dart';
import 'package:ai_checker_translator/presentations/Quiz_levels/widgets/quiz_level_widget.dart';
import 'package:ai_checker_translator/presentations/paraphrase/controller/Categories_controller.dart';
import 'package:ai_checker_translator/presentations/paraphrase/model/grammarcategory_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class QuizLevelScreen extends StatefulWidget {
  const QuizLevelScreen({super.key});

  @override
  State<QuizLevelScreen> createState() => _QuizLevelScreenState();
}

class _QuizLevelScreenState extends State<QuizLevelScreen> {

  final GrammarCategoryModel category = Get.arguments;



     final  quizzeslevelController = Get.put(QuizzeslevelController());
     final  categoriesController = Get.put(CategoriesController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(category.title),
        backgroundColor: Colors.teal,
      ),
      body:  
Obx(() {
  if (categoriesController.isLoading.value) {
    return const Center(child: CircularProgressIndicator());
  }

  

  if (categoriesController.categoriesList.isEmpty) {
    return const Center(child: Text("No data found for this category"));
  }

  return ListView.builder(
    itemCount: categoriesController.categoriesList.length,
    itemBuilder: (context, index) {
      final item = categoriesController.categoriesList[index];
      return Card(
        margin: const EdgeInsets.all(10),
        elevation: 4,
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "${item.catName}",
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),
             
            ],
          ),
        ),
      );
    },
  );


      })
    );
  }
}