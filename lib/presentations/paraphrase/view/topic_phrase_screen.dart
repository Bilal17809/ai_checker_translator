// ⬇️ Add this in controller first if not already done
// RxInt currentPage = 0.obs;

import 'package:ai_checker_translator/core/common_widgets/icon_buttons.dart';
import 'package:ai_checker_translator/core/common_widgets/life_cycle_mixin.dart';
import 'package:ai_checker_translator/core/theme/app_colors.dart';
import 'package:ai_checker_translator/presentations/paraphrase/widget/phrasses_example_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../paraphrase/controller/paraphrase_controller.dart';

class TopicPhrasesScreen extends StatefulWidget {
  final int? topicId;
  const TopicPhrasesScreen({super.key, this.topicId});

  @override
  State<TopicPhrasesScreen> createState() => _TopicPhrasesScreenState();
}

class _TopicPhrasesScreenState extends State<TopicPhrasesScreen>
    with AppLifecycleMixin {
  @override
  void onAppPause() {
    controller.flutterTts.stop();
    FocusScope.of(context).unfocus();
  }

  final controller = Get.find<ParaphraseController>();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      controller.fetchTopicPhrasebyTopicId(widget.topicId ?? 0);
    });
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;

    return SafeArea(
      child: Scaffold(
        backgroundColor: kWhiteF7,
        body: Stack(
          children: [
            Column(
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
                    padding: const EdgeInsets.only(top: 10, left: 16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            BackButton(
                              onPressed: () {
                                Get.back();
                              },
                              color: kWhite,
                            ),
                            const Spacer(),
                            const Text(
                              "Phrases Example",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 22,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const Spacer(),
                            const SizedBox(width: 48),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),

            /// 🟦 Main Content Card
            Positioned(
              top: height * 0.12,
              left: 12,
              right: 12,
              bottom: 0,
              child: Obx(() {
                final phraseList = controller.topicPharseList;
                // final currentPage = controller.currentPageIndex.value;

                if (controller.isLoading.value) {
                  return const Center(child: CircularProgressIndicator());
                }
                if (phraseList.isEmpty) {
                  return const Center(child: Text("No phrases available"));
                }

                return Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 06,
                    vertical: 20,
                  ),
                  child: Column(
                    children: [
                      /// PageView of phrases
                      Expanded(
                        child: PageView.builder(
                          controller: controller.pageController,
                          onPageChanged: (index) {
                            controller.currentPageIndex.value = index;
                          },
                          itemCount: phraseList.length,
                          itemBuilder: (context, index) {
                            final phrase = phraseList[index];
                            return PhrassesExampleWidget(
                              copy: () {
                                controller.speakExplanationText(
                                  phrase.explaination,
                                );
                              },
                              speakonTap: () {
                                controller.copyExplanation(phrase.explaination);
                              },
                              phrase: phrase.sentence,
                              explanation: phrase.explaination,
                            );
                          },
                        ),
                      ),

                      Obx(() {
                        final currentPage = controller.currentPageIndex.value;
                        final phraseList = controller.topicPharseList;

                        return Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            /// ⬅️ Previous Button
                            CircleAvatar(
                              backgroundColor:
                                  currentPage == 0
                                      ? Colors.grey[300]
                                      : kMintGreen,
                              child: IconButton(
                                icon: const Icon(
                                  Icons.arrow_back_ios_new_rounded,
                                  size: 18,
                                ),
                                color: Colors.white,
                                onPressed:
                                    currentPage == 0
                                        ? null
                                        : () => controller.goToPage(
                                          currentPage - 1,
                                        ),
                              ),
                            ),
                            const SizedBox(width: 30),

                            /// 📄 Page Count
                            Text(
                              "${currentPage + 1} / ${phraseList.length}",
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                              ),
                            ),

                            const SizedBox(width: 30),

                            /// ➡️ Next Button
                            CircleAvatar(
                              backgroundColor:
                                  currentPage == phraseList.length - 1
                                      ? Colors.grey[300]
                                      : kMintGreen,
                              child: IconButton(
                                icon: const Icon(
                                  Icons.arrow_forward_ios,
                                  size: 18,
                                ),
                                color: Colors.white,
                                onPressed:
                                    currentPage == phraseList.length - 1
                                        ? null
                                        : () {
                                          // controller.flutterTts.stop();
                                          controller.isSpeaking.value = false;
                                          controller.goToPage(currentPage + 1);
                                        },
                              ),
                            ),
                          ],
                        );
                      }),
                    ],
                  ),
                );
              }),
            ),
          ],
        ),
      ),
    );
  }
}
