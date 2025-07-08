import 'package:ai_checker_translator/core/common_widgets/keyboard_dismiss_wrapper.dart';
import 'package:ai_checker_translator/core/theme/app_colors.dart';
import 'package:ai_checker_translator/presentations/paraphrase/controller/paraphrase_controller.dart';
import 'package:ai_checker_translator/presentations/paraphrase/view/topic_phrase_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';



class ParaphraseView extends StatefulWidget {
  // final int id;
  // final String menuname;
  const ParaphraseView({super.key});

  @override
  State<ParaphraseView> createState() => _ParaphraseViewState();
}

class _ParaphraseViewState extends State<ParaphraseView> {

  final controller = Get.find<ParaphraseController>();
  



  @override
  Widget build(BuildContext context) {
    return KeyboardDismissWrapper(
      child: Scaffold(
      backgroundColor: kWhiteF7,
      appBar: AppBar(
          iconTheme: IconThemeData(color: kWhite),
          title: Text("Paraphrase", style: TextStyle(color: Colors.white)),
        backgroundColor: kMintGreen,
        centerTitle: true,
      ),
        body: Obx(() {
          if (controller.isLoading.value) {
            return CircularProgressIndicator();
          }
          if (controller.topicsList.isEmpty) {
            return Text("Data Not Loaded Empty");
          }
          return ListView.builder(
            itemCount: controller.topicsList.length,
            itemBuilder: (context, index) {
              final data = controller.topicsList[index];
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: GestureDetector(
                  onTap: () {
                    print("Data fetch");
                    Get.to(() => TopicPhrasesScreen(topicId: data.id));
                  },
                  child: Card(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("id: ${data.id}"),
                          Text("Title: ${data.title}"),
                          Text("desc: ${data.desc}"),
                          Text("favourite: ${data.favorite}"),
                        ],
                      ),
                    ),
                  ),
                ),
                );
            },
          );

        })
      )
    );
  }
}
