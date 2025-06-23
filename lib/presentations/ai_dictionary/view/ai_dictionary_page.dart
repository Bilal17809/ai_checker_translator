import 'package:ai_checker_translator/core/routes/routes_name.dart';
import 'package:ai_checker_translator/presentations/ai_dictionary/contrl/ai_dictioanay_contrl.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AiDictionaryPage extends StatefulWidget {
  const AiDictionaryPage({super.key});

  @override
  State<AiDictionaryPage> createState() => _AiDictionaryPageState();
}

class _AiDictionaryPageState extends State<AiDictionaryPage> {
  final quizzescontroller = Get.put(QuizzesController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Obx(() {
        if (quizzescontroller.isLoading.value) {
          return Center(child: CircularProgressIndicator());
        }
        if (quizzescontroller.quizzessList.isEmpty) {
          return Center(child: Text("No data Found"));
        }
        return ListView.builder(
          itemCount: quizzescontroller.quizzessList.length,
          itemBuilder: (context, index) {
            final data = quizzescontroller.quizzessList[index];
            return GestureDetector(
              onTap: () {
                Get.toNamed(
                  RoutesName.quizdetailscreen,
                  arguments: data.quizID,
                );
              },
              child: Card(
                margin: EdgeInsets.all(8.0),
                elevation: 3,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("QuizID: ${data.quizID.toString()}"),
                      Text("CatID: ${data.catID.toString()}"),
                      Text("Content: ${data.content}"),
                      Text("Answers: ${data.answer}"),
                      Text("Explanation: ${data.explanation}"),
                    ],
                  ),
                ),
              ),
            );
          },
        );
      }),
    );
  }
}
