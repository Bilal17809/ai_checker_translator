
import 'package:ai_checker_translator/presentations/home/controller/menu_controller.dart';
import 'package:ai_checker_translator/translations/translation_contrl.dart';
import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/get_instance.dart';
import 'package:get/get_state_manager/get_state_manager.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  final dbController = Get.put(DbController());

 
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Home"),
        backgroundColor: Colors.teal,
      ),
      body: Obx(() {
        if (dbController.isLoading.value) {
          return Center(child: CircularProgressIndicator());
        }

        if (dbController.menuList.isEmpty) {
          return Center(child: Text("No data found"));
        }

        return ListView.builder(
          itemCount: dbController.menuList.length,
          itemBuilder: (context, index) {
            final item = dbController.menuList[index];
            return Card(
              margin: EdgeInsets.all(10),
              elevation: 4,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              child: Padding(
                padding: EdgeInsets.all(12),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                            
                      Text("Grammar: ${dbController.menuList[index].grammarrules}", style: _textStyle()),
                      // Text("Punctuation: ${item.punctuationRules}", style: _textStyle()),
         
                      // Text("Spelling/Vocab: ${item.spellingVocabularyCommonlyConfusedWords}", style: _textStyle()),
                   
                      // Text("Other Rules: ${item.otherRules}", style: _textStyle()),

                      // Text("Quiz: ${item.quizzesGrammarPretest}", style: _textStyle()),    
                  ],
                ),
              ),
            );
          },
        );
      }),
    );
  }

  TextStyle _textStyle() {
    return TextStyle(fontSize: 15, color: Colors.black87, height: 1.5);
  }
}