import 'package:ai_checker_translator/core/theme/app_colors.dart';
import 'package:ai_checker_translator/presentations/aska/view/controller/gemini_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';


class GeneratedTextWidget extends StatelessWidget {
  final String text;

   GeneratedTextWidget({
    super.key,
    required this.text,
  });
         final geminicontroller = Get.put(GeminiController());
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color: Colors.green.shade200, width: 1.5),
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
              minHeight: 80,
              maxHeight: 200,
            ),
            child: Scrollbar(
              thumbVisibility: true,
              child: SingleChildScrollView(
                child: Align(
                  alignment: Alignment.topLeft,
                  child: Text(
                    text,
                    style: const TextStyle(
                      fontSize: 16,
                      height: 1.5,
                    ),
                  ),
                ),
              ),
            ),
          ),

          const SizedBox(height: 8),

          // 🔹 Buttons aligned to the right
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              IconButton(
                icon: const Icon(Icons.copy, size: 20,color: kMediumGreen2,),
                tooltip: "Copy",
                onPressed: () async {
                 geminicontroller.copyText();
                },
              ),
              IconButton(
                icon: const Icon(Icons.share, size: 20,color: kMediumGreen2,),
                tooltip: "Share",
                onPressed: () async {
                  // await Share.share(text);
                },
              ),
            ],
          ),
        ],
      ),
    );
  }
}
