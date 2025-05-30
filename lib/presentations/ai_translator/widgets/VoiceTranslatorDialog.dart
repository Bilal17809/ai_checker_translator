import 'package:ai_checker_translator/core/theme/app_colors.dart';
import 'package:ai_checker_translator/presentations/ai_translator/widgets/elevated_button.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controller/translator_controller.dart';

class VoiceTranslatorDialog extends StatelessWidget {
  const VoiceTranslatorDialog({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<TranslatorController>();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      controller.startListening();
    });

    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Obx(() {
        final showMid = controller.showMidDialog.value;
        final noInternet = controller.showNoInternetDialog.value;
        final isListening = controller.isListening.value;
        final sourceText = controller.sourceText.value;
        final translatedText = controller.translatedText.value;

        if (translatedText.isNotEmpty) {
          Future.delayed(const Duration(milliseconds: 1000), () {
            if (Get.isDialogOpen ?? false) {
              controller.stopListening();
            }
          });
        }
        Widget content;

        if (noInternet) {
          content = Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(Icons.wifi_off, size: 50, color: Colors.grey),
              const SizedBox(height: 10),
              const Text(
                "No Internet Connection",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.grey,
                ),
              ),
              const SizedBox(height: 10),
              ElevatedButton(
                style: ElevatedButton.styleFrom(backgroundColor: kRed),
                onPressed: () {
                  controller.resetVoiceTranslation();
                  controller.startListening();
                },
                child: Text("try again"),
              ),
            ],
          );
        } else if (showMid) {
          content = Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(Icons.mic_off, size: 50, color: kRed),
              const SizedBox(height: 10),
              const Text("No voice detected"),
              const SizedBox(height: 10),
              Row(
                children: [
                  elevatedButtons(
                    color: Colors.grey,
                    buttonTitle: "Cancel",
                    onTap: () {
                      controller.stopListening();
                      Get.back();
                    },
                  ),
                  SizedBox(width: 20),
                  elevatedButtons(
                    buttonTitle: "Try again",
                    color: kMediumGreen2,
                    onTap: () {
                      controller.startListening();
                    },
                  ),
                ],
              ),
            ],
          );
        } else {
          content = Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text(
                "Google",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
              ),
              const SizedBox(height: 10),
              InkWell(
                onTap: controller.startListening,
                child: CircleAvatar(
                  radius: 30,
                  backgroundColor: isListening ? Colors.lightBlue : Colors.grey,
                  child: const Icon(Icons.mic, color: Colors.white),
                ),
              ),
              const SizedBox(height: 10),
              Text(
                isListening ? "Listening..." : "Tap to start again",
                style: TextStyle(
                  color: Colors.grey,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 10),
              if (sourceText.isNotEmpty && translatedText.isEmpty)
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    sourceText,
                    textAlign: TextAlign.center,
                    style: const TextStyle(fontSize: 16),
                  ),
                ),
              if (translatedText.isNotEmpty)
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    sourceText,
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              const SizedBox(height: 10),
              Row(
                children: [
                  elevatedButtons(
                    color: Colors.grey,
                    buttonTitle: "Cancel",
                    onTap: () {
                      Get.back();
                      // controller.stopListening();
                    },
                  ),
                  SizedBox(width: 20),
                  elevatedButtons(
                    buttonTitle: "Ok",
                    color: Colors.lightBlue,
                    onTap: () {
                      Get.back(result: translatedText);
                    },
                  ),
                ],
              ),
            ],
          );
        }

        return Padding(padding: const EdgeInsets.all(16.0), child: content);
      }),
    );
  }
}
