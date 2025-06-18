import 'package:ai_checker_translator/core/theme/app_colors.dart';
import 'package:ai_checker_translator/translations/translation_contrl.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class TranslatedTextWidget extends StatefulWidget {
  TranslatedTextWidget({super.key});

  @override
  State<TranslatedTextWidget> createState() => _TranslatedTextWidgetState();
}

class _TranslatedTextWidgetState extends State<TranslatedTextWidget> {
  
  final TranslationController controller = Get.find();

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;

    return Obx(() {
      if (controller.controller.text.isEmpty) return const SizedBox();

      final sourceLang = controller.selectedLanguage1.value;
      final sourceFlagCode = controller.languageFlags[sourceLang] ?? 'US';
      final sourceFlag = controller.getFlagEmoji(sourceFlagCode);

      final targetLang = controller.selectedLanguage2.value;
      final targetFlagCode = controller.languageFlags[targetLang] ?? 'ES';
      final targetFlag = controller.getFlagEmoji(targetFlagCode);
      final isRTL = controller.isRTLLanguage(targetLang);

      return Container(
        height: height * 0.26,
        width: double.infinity,
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(color: kMediumGreen1, width: 2),
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.2),
              spreadRadius: 1,
              blurRadius: 6,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
          child: Column(
            children: [
              Expanded(
                child: Scrollbar(
                  thumbVisibility: true,
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        /// Source
                        Text(
                          "$sourceFlag $sourceLang",
                          style: const TextStyle(
                            fontSize: 16,
                            fontFamily: 'NotoColorEmoji',
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          controller.controller.text,
                          style: const TextStyle(fontSize: 14),
                        ),
                        const Divider(height: 20),

                        /// Target
                        if (controller.translatedText.isNotEmpty) ...[
                          Text(
                            "$targetFlag $targetLang",
                            style: const TextStyle(
                              fontSize: 16,
                              fontFamily: 'NotoColorEmoji',
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            controller.translatedText.value,
                            textDirection:
                                isRTL ? TextDirection.rtl : TextDirection.ltr,
                            style: const TextStyle(fontSize: 14),
                          ),
                        ],
                      ],
                    ),
                  ),
                ),
              ),
              /// Action buttons
              Align(
                alignment: Alignment.bottomRight,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    IconButton(
                      onPressed: () {
                        controller.speakText();
                      },
                      icon: const Icon(Icons.volume_up,color: kMediumGreen2),
                    ),
                    IconButton(
                      onPressed: () {
                        controller.copyText();
                      },
                      icon: const Icon(Icons.copy,color: kMediumGreen2),
                    ),
                     IconButton(
                      onPressed: () {
                        controller.clearData();
                      },
                      icon: const Icon(Icons.delete,color: kMediumGreen2),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      );
    });
  }
}
