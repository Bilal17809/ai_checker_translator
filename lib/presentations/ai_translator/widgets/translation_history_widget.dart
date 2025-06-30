import 'package:ai_checker_translator/gen/assets.gen.dart';
import 'package:ai_checker_translator/presentations/ai_translator/controller/translation_contrl.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ai_checker_translator/core/theme/app_colors.dart';

import '../controller/translator_controller.dart';

class TranslationHistoryWidget extends StatelessWidget {
  final TranslationController controller = Get.find();

  TranslationHistoryWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;

    return Obx(() {
      if (controller.translationHistory.isEmpty) {
        return Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Image.asset(
                Assets.historyicon.path,
                height: 50,
                color: Colors.grey,
              ),
              SizedBox(height: 10),
              Text(
                "No History Found!",
                style: TextStyle(
                  color: Colors.grey,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        );
      }

      return ListView.builder(
        shrinkWrap: true,
        physics: const BouncingScrollPhysics(),
        itemCount: controller.translationHistory.length,
        itemBuilder: (context, index) {
          final item = controller.translationHistory[index];
          final parts = item.split("||");
          final sourceText = parts[0];
          final targetText = parts.length > 1 ? parts[1] : "";

          return Column(
            children: [
              Container(
                // height: height * 0.,
                margin: const EdgeInsets.only(bottom: 14),
                decoration: BoxDecoration(
                  color: Colors.white,
                  border: Border.all(color: kMintGreen, width: 2),
                  borderRadius: BorderRadius.circular(10),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.0),
                      spreadRadius: 1,
                      blurRadius: 4,
                      offset: const Offset(0, 0),
                    ),
                  ],
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 10,
                    vertical: 10,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(sourceText, style: const TextStyle(fontSize: 14)),
                      const Divider(),
                      Text(targetText, style: const TextStyle(fontSize: 14)),
                      // const SizedBox(height: ),
                      Align(
                        alignment: Alignment.bottomRight,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            IconButton(
                              onPressed: () {
                                // Extract the translated sentence after the line break '||\n'

                                final parts = item.split("||");
                                final translatedSection =
                                    parts.length > 1 ? parts[1] : '';

                                
                                final translatedLines = translatedSection
                                    .trim()
                                    .split('\n');
                                final actualTranslation =
                                    translatedLines.length > 1
                                        ? translatedLines.sublist(1).join('\n')
                                        : translatedSection;

                                controller.flutterTts.speak(
                                  actualTranslation.trim(),
                                );
                              },
                              icon: const Icon(
                                Icons.volume_up,
                                color: kMintGreen,
                              ),
                            ),

                            IconButton(
                              onPressed: () {
                                controller.copyText();
                              },
                              icon: const Icon(
                                Icons.copy,
                                color: kMintGreen,
                              ),
                            ),
                            IconButton(
                              onPressed: () {
                                controller.deleteHistoryItem(index);
                                 controller.flutterTts.stop();
                              },
                              icon: const Icon(
                                Icons.delete,
                                color: kMintGreen,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          );
        },
      );
    });
  }
}
