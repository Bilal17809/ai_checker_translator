import 'package:ai_checker_translator/core/common_widgets/textform_field.dart';
import 'package:ai_checker_translator/core/theme/app_colors.dart';
import 'package:ai_checker_translator/presentations/ai_translator/widgets/translator_button.dart';
import 'package:ai_checker_translator/translations/translation_contrl.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';

class AssistantInputBox extends StatefulWidget {
  final int maxLength;
  final List<IconButton> iconButtons; // 🔄 Changed from IconData to IconButton
  final TextEditingController controller;
  final BorderRadius borderRadius;
  final bool showFooter;
  final String hintText;
  final TextAlign textalign;
  final TextDirection textDirection;
  final bool readOnly;
  const AssistantInputBox({
    super.key,
    required this.controller,
    this.readOnly = false,
    required this.iconButtons,
    this.maxLength = 1000,
    this.borderRadius = const BorderRadius.all(Radius.circular(16)),
    this.showFooter = true,
    required this.hintText,
    this.textDirection = TextDirection.rtl,
    this.textalign = TextAlign.start,
  });

  @override
  State<AssistantInputBox> createState() => _AssistantInputBoxState();
}

class _AssistantInputBoxState extends State<AssistantInputBox> {
  late int currentLength;

  @override
  void initState() {
    super.initState();
    currentLength = widget.controller.text.length;
    widget.controller.addListener(_updateLength);
  }

  void _updateLength() {
    setState(() {
      currentLength = widget.controller.text.length;
    });
  }

  @override
  void dispose() {
    widget.controller.removeListener(_updateLength);
    super.dispose();
  }
  final TranslationController controller = Get.put(TranslationController());
  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.40,
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color: kMediumGreen1, width: 2),
        borderRadius: widget.borderRadius,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.2),
            spreadRadius: 1,
            blurRadius: 6,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Obx(() {
            final sourceLang = controller.selectedLanguage1.value;
            final sourceFlagCode = controller.languageFlags[sourceLang] ?? 'US';
            final sourceFlag = controller.getFlagEmoji(sourceFlagCode);
            if (controller.controller.text.isNotEmpty) {
              return Text(
                "$sourceFlag $sourceLang",
                style: const TextStyle(
                  fontSize: 16,
                  fontFamily: 'NotoColorEmoji',
                ),
              );
            }
            return SizedBox.shrink();
          }),
          CustomTextFormField(
            readOnly: widget.readOnly,
            textDirection: widget.textDirection,
            textAlign: widget.textalign,
            controller: widget.controller,
            hintText: widget.hintText,
            // maxLines: 10,
            border: InputBorder.none,
          ),
          Divider(),
          Obx(() {
            if (controller.translatedText.value.isNotEmpty) {
              final isRTL = controller.isRTLLanguage(
                controller.selectedLanguage2.value,
              );
              final targetLang = controller.selectedLanguage2.value;
              final targetFlagCode =
                  controller.languageFlags[targetLang] ?? 'ES';

              final targetFlag = controller.getFlagEmoji(targetFlagCode);

              return Expanded(
                child: SingleChildScrollView(
                  child: Align(
                    alignment: Alignment.topLeft,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "$targetFlag $targetLang",
                          style: const TextStyle(
                            fontSize: 16,
                            fontFamily: 'NotoColorEmoji',
                          ),
                        ),
                        Text(
                          controller.translatedText.value,
                          textDirection:
                              isRTL ? TextDirection.rtl : TextDirection.ltr,
                        ),
                      ],
                    ),
                  ),
                ),
              );
            } else {
              return const SizedBox();
            }
          }),

          if (widget.showFooter) ...[
            // const SizedBox(height: 12),
            Spacer(),
            Align(
              alignment: Alignment.bottomCenter,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children:
                        widget.iconButtons.map((btn) {
                          return Padding(
                            padding: const EdgeInsets.only(right: 00),
                            child: btn,
                          );
                        }).toList(),
                  ),
                  Row(
                    children: [
                      TranslatorButton(
                        onTap: () {
                          final inputText = controller.controller.text;
                          if (inputText.isNotEmpty) {
                            controller.translate(inputText);
                            controller.onTranslateButtonPressed();
                            controller.speakText();
                            // print(controller.translatedText);
                            // print(controller.selectedLanguage2);
                            print("Translated");
                          } else {
                            // print(controller.translatedText);
                            print("Empty input. Nothing to translate.");
                          }
                        },
                      ),
                      // Text(
                      //   "$currentLength/${widget.maxLength}",
                      //   style: const TextStyle(
                      //     fontSize: 12,
                      //     color: Colors.grey,
                      //   ),
                      // ),
                      const SizedBox(width: 8),
                      // const Icon(Icons.copy, size: 20, color: kMediumGreen2),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ],
      ),
  
    );
  
  }
}
