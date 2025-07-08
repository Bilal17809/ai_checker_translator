
import 'package:flutter/material.dart';
import 'package:get/get.dart';
// import 'package:html/parser.dart';
// import '../../../data/models/parphrase_models/topic_phrase_model.dart';
import '../../paraphrase/controller/paraphrase_controller.dart';

class TopicPhrasesScreen extends StatefulWidget {
  final int? topicId;
  const TopicPhrasesScreen({super.key,this.topicId});

  @override
  State<TopicPhrasesScreen> createState() => _TopicPhrasesScreenState();
}

class _TopicPhrasesScreenState extends State<TopicPhrasesScreen> {
  final controller = Get.find<ParaphraseController>();

    @override
  void initState() {
    super.initState();

    // ✅ Delayed fetch after build is complete
    WidgetsBinding.instance.addPostFrameCallback((_) {
      controller.fetchTopicPhrasebyTopicId(widget.topicId ?? 0);
    });
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Topic Phrases")),
      body: Obx(() {
        if (controller.isLoading.value) {
          return Center(child: CircularProgressIndicator());
        }

        if (controller.topicPharseList.isEmpty) {
          return Center(child: Text("No phrases found for this topic"));
        }

        return ListView.builder(
          itemCount: controller.topicPharseList.length,
          itemBuilder: (context, index) {
            final phrase = controller.topicPharseList[index];
            return ListTile(
              title: Text(phrase.explaination ?? ''),
              subtitle: Text(phrase.sentence ?? ''),
              trailing: Text(phrase.topicId.toString() ),
            );
          },
        );
      }),
    );
  }
}
