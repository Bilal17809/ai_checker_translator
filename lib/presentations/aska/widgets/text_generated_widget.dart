import 'package:ai_checker_translator/core/theme/app_colors.dart';
import 'package:ai_checker_translator/presentations/ai_dictionary/contrl/animation_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controller/gemini_controller.dart';



class GeneratedTextWidget extends StatelessWidget {
  final String text;
  final VoidCallback onTapCopy;
  final VoidCallback onTapstartSpeak;
  final VoidCallback onTapShare;
   GeneratedTextWidget({
    super.key,
    required this.text,
    required this.onTapCopy,
    required this.onTapShare,
    required this.onTapstartSpeak,
  });
  final ScrollController _scrollController = ScrollController();
  final geminicontroller = Get.find<GeminiController>();
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color: kMintGreen, width: 1.5),
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.08),
            blurRadius: 4,
            offset: const Offset(0, 2),
          )
        ],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // 🔹 Scrollable Text
          ConstrainedBox(
            constraints: const BoxConstraints(
    minHeight: 100, maxHeight: 200),
            child: Scrollbar(
              controller: _scrollController,
              thumbVisibility: true,
              child: SingleChildScrollView(
                controller: _scrollController,
                child: Align(
                  alignment: Alignment.topLeft, 
                  child: SizedBox(
                    width: double.infinity, 
                    child: AnimatedTypingText(
                      text: text,
                      style: const TextStyle(fontSize: 14, height: 1.4),
                      charDuration: const Duration(milliseconds: 32),
                      scrollController: _scrollController,
                    ),
                  ),
                ),
              ),
            ),
          ),



          const SizedBox(height: 8),

          // 🔹 Buttons aligned to the right
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Obx(() {
                return IconButton(
                onPressed: onTapstartSpeak,
                  icon: Icon(
                    geminicontroller.isSpeaking.value
                        ? Icons.volume_up
                        : Icons.volume_down,
                    color: kMintGreen,
                  ),
                );
              }),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  IconButton(
                    icon: const Icon(
                      Icons.copy,
                      size: 20,
                      color: kMintGreen,
                    ),
                    tooltip: "Copy",
                    onPressed: onTapCopy,
                  ),
                  IconButton(
                    icon: const Icon(
                      Icons.share,
                      size: 20,
                      color: kMintGreen,
                    ),
                    tooltip: "Share",
                    onPressed: onTapShare,
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
