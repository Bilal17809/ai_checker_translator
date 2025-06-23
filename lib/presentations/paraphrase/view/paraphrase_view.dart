
import 'package:ai_checker_translator/presentations/paraphrase/controller/Categories_controller.dart';
import 'package:ai_checker_translator/presentations/paraphrase/widget/quizzess_grammar_widget.dart';
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

  final CategoriesController categoriesController = Get.put(CategoriesController());
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
            mainAxisSpacing: 04,
            crossAxisSpacing: 04,
            // childAspectRatio: 2.6,
          ),
          itemCount: 7,
          itemBuilder: (context, index) {
            QuizzessGrammarWidget(grammarTitle: "grammarTitle", quizNumber: 0);
          },
        );
         

        // ListView.builder(
        //   itemCount: categoriesController.categoriesList.length,
        //   itemBuilder: (context, index) {
        //     final item = categoriesController.categoriesList[index];
        //     return Card(
        //       margin: const EdgeInsets.all(10),
        //       elevation: 4,
        //       child: Padding(
        //         padding: const EdgeInsets.all(12),
        //         child: Column(
        //           crossAxisAlignment: CrossAxisAlignment.start,
        //           children: [
        //             // Text("Category ID: ${item.catID}"),
        //             // Text("Menu ID: ${item.menuID}"),
        //             // Text("Category Name: ${item.catName}",
        //             //     style: const TextStyle(fontWeight: FontWeight.bold)),
        //             // const SizedBox(height: 8),
        //             // // Text("Content: ${item.content}"),
        //           ],
        //         ),
        //       ),
        //     );
        //   },
        // );
      }),
    );
  }
}