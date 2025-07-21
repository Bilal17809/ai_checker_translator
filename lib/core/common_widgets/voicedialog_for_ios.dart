import 'dart:async';
import 'package:ai_checker_translator/core/theme/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:speech_to_text/speech_to_text.dart' as stt;

class VoiceDialogHelper {
  final stt.SpeechToText speech = stt.SpeechToText();

  Future<void> showVoiceInputDialog({
    required BuildContext context,
    required String languageCode,
    required void Function(String text) onResult,
  }) async {
    String fullText = "";
    String detectedText = "";
    bool showError = false;
    bool isListening = false;
    bool speaking = false;
    Timer? timeoutTimer;

    await speech.initialize(
      onError: (error) {
        debugPrint("Speech error: $error");
        showError = true;
      },
      onStatus: (status) {
        debugPrint("Speech status: $status");
      },
    );

    Get.dialog(
      StatefulBuilder(
        builder: (context, setState) {
          if (!isListening) {
            isListening = true;
            _startListening(
              languageCode: languageCode,
              onResult: (text) {
                setState(() {
                  fullText = text;
                  detectedText =
                      fullText.length > 60
                          ? '...${fullText.substring(fullText.length - 60)}'
                          : fullText;

                  speaking = true;
                  showError = false;

                  timeoutTimer?.cancel();
                  timeoutTimer = Timer(const Duration(seconds: 4), () {
                    onResult(fullText);
                    Get.back();
                  });
                });
              },
              onDone: () {
                // Get.back();
              },
              onTimeout: () {
                setState(() {
                  showError = true;
                });
              },
            );
          }

          return GestureDetector(
            onTap: () {
              setState(() {
                speech.stop();
              });
              Get.back();
            },
            child: Material(
              color: Colors.transparent,
              child: Center(
                child: GestureDetector(
                  onTap: () {},
                  child: AlertDialog(
                    backgroundColor: Colors.black,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                    contentPadding: const EdgeInsets.symmetric(
                      vertical: 24,
                      horizontal: 16,
                    ),
                    content: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        RichText(
                          text: TextSpan(
                            children: [
                              TextSpan(
                                text: 'Speak',
                                style: TextStyle(
                                  color:
                                      speaking
                                          ? kMintGreen
                                          : showError
                                          ? kRed
                                          : kWhite,
                                  fontSize: 22,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              TextSpan(
                                text: 'Mate',
                                style: TextStyle(
                                  color: kWhite,
                                  fontSize: 22,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                        ),

                        const SizedBox(height: 20),
                        CircleAvatar(
                          radius: 36,
                          backgroundColor:
                              showError
                                  ? kRed
                                  : speaking
                                  ? kMintGreen
                                  : Colors.blue,

                          child: const Icon(
                            Icons.mic,
                            color: Colors.white,
                            size: 32,
                          ),
                        ),
                        const SizedBox(height: 20),
                        TweenAnimationBuilder<Color?>(
                          tween: ColorTween(
                            begin: Colors.grey.shade400,
                            end: speaking ? Colors.white : Colors.white,
                          ),
                          duration: const Duration(milliseconds: 600),
                          curve: Curves.easeInOut,
                          builder: (context, color, _) {
                            return Text(
                              showError
                                  ? "Oops! Didn't quite get that. Give it another go."
                                  : detectedText.isEmpty
                                  ? "I'm Listening..."
                                  : detectedText,
                              key: ValueKey(detectedText),
                              style: TextStyle(color: color, fontSize: 16),
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                              textAlign: TextAlign.center,
                              textDirection:
                                  (!showError && detectedText.isNotEmpty)
                                      ? TextDirection.rtl
                                      : TextDirection.ltr,
                            );
                          },
                        ),

                        const SizedBox(height: 10),
                        if (showError)
                          GestureDetector(
                            onTap: () {
                              Get.back();
                              showVoiceInputDialog(
                                context: context,
                                languageCode: languageCode,
                                onResult: onResult,
                              );
                            },
                            child: Container(
                              height: 40,
                              width: double.infinity,
                              decoration: BoxDecoration(
                                // color: Colors.white,
                                borderRadius: BorderRadius.circular(20),
                                border: Border.all(color: kRed),
                              ),
                              child: Center(
                                child: Text(
                                  "Try again",
                                  style: TextStyle(color: kRed),
                                ),
                              ),
                            ),
                          ),
                        const SizedBox(height: 10),
                        const Text(
                          "English (United States)",
                          style: TextStyle(color: Colors.grey, fontSize: 12),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      ),
      barrierDismissible: false,
    );
  }

  void _startListening({
    required Function(String) onResult,
    required VoidCallback onDone,
    required VoidCallback onTimeout,
    required String languageCode,
  }) {
    String recognizedText = "";
    bool speaking = false;
    Timer? timeoutTimer;

    speech.listen(
      localeId: languageCode,
      onResult: (result) {
        recognizedText = result.recognizedWords;
        if (recognizedText.trim().isNotEmpty) {
          onResult(recognizedText);
          speaking = true;

          timeoutTimer?.cancel();
          timeoutTimer = Timer(const Duration(seconds: 1), onDone);
        }
      },
      listenFor: const Duration(minutes: 1),
      pauseFor: const Duration(minutes: 1),
      cancelOnError: true,
      partialResults: true,
    );

    timeoutTimer = Timer(const Duration(seconds: 4), () {
      if (!speaking) {
        onTimeout();
        speech.stop();
      }
    });
  }
}
