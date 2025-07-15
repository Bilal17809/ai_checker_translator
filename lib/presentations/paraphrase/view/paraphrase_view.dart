import 'package:ai_checker_translator/core/common_widgets/back_to_home_wrapper.dart';
import 'package:ai_checker_translator/core/common_widgets/textform_field.dart';
import 'package:ai_checker_translator/core/theme/app_styles.dart';
import 'package:ai_checker_translator/presentations/paraphrase/controller/paraphrase_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../core/theme/app_colors.dart';
import 'topic_phrase_screen.dart';

class ParaphraseView extends StatelessWidget {
  final controller = Get.find<ParaphraseController>();

  ParaphraseView({super.key});

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;

    return BackToHomeWrapper(
      child: SafeArea(
        child: Scaffold(
          backgroundColor: kWhiteF7,
          body: Stack(
            children: [
              /// 🟩 Top Green Header
              Column(
                // mainAxisAlignment: MainAxisAlignment.start,
                // crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    height: height * 0.20,
                    decoration: const BoxDecoration(
                      color: kMintGreen,
                      borderRadius: BorderRadius.only(
                        bottomRight: Radius.circular(20),
                        bottomLeft: Radius.circular(20),
                      ),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.only(top: 10, left: 10),
                      child: Column(
                        // crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              BackButton(
                                color: kWhite,
                                onPressed: () {
                                  Get.back();
                                },
                              ),
                              const Spacer(),
                              SizedBox(width: 20),
                              Align(
                                alignment: Alignment.center,
                                child: const Text(
                                  "Topic Phrases",
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 22,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                              const Spacer(), // to keep title centered
                              const SizedBox(
                                width: 48,
                              ), // match IconButton width
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              Positioned(
                top: height * 0.13,
                left: 06,
                right: 06,
                bottom: 0,
                child: Padding(
                  padding: const EdgeInsets.all(12),
                  child: Column(
                    children: [
                      Container(
                        height: height * 0.10,
                        decoration: roundedDecoration,
                        child: Center(
                          child: ClipOval(
                            child: CustomTextFormField(
                              hintText: "Search Words",
                              controller: controller.searchController,
                              onChanged: (value) {
                                controller.searchTopics(value);
                              },
                              suffixIcon: Icon(
                                Icons.search,
                                color: Colors.grey,
                              ),
                              border: InputBorder.none,
                              contentPadding: EdgeInsets.symmetric(
                                vertical: 14,
                                horizontal: 14,
                              ),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 12),
                      Expanded(
                        child: Obx(() {
                          final list = controller.filteredTopics;
                          if (controller.isLoading.value) {
                            return const Center(
                              child: CircularProgressIndicator(),
                            );
                          }
                          if (list.isEmpty) {
                            return const Center(child: Text("No topics found"));
                          }

                          return ListView.builder(
                            itemCount: list.length,
                            padding: const EdgeInsets.only(top: 4),
                            itemBuilder: (context, index) {
                              final topic = list[index];
                              return GestureDetector(
                                onTap: () {
                                  FocusScope.of(context).unfocus();
                                  Get.to(
                                    () => TopicPhrasesScreen(topicId: topic.id),
                                  );
                                },
                                child: Padding(
                                  padding: const EdgeInsets.all(6.0),
                                  child: Container(
                                    height: height * 0.10,
                                    // margin: const EdgeInsets.only(bottom: 10),
                                    decoration: roundedDecoration,

                                    child: Center(
                                      child: ListTile(
                                        title: Text(topic.title),
                                        trailing: const Icon(
                                          Icons.arrow_forward_ios,
                                          size: 16,
                                          color: kMintGreen,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              );
                            },
                          );
                        }),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      )
    );
  }
}
