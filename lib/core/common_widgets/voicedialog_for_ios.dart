
import 'dart:async';
import 'package:ai_checker_translator/core/routes/routes_name.dart';
import 'package:ai_checker_translator/presentations/ai_translator/controller/translation_contrl.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/utils.dart';
import 'package:speech_to_text/speech_to_text.dart' as stt;

class VoiceDialogHelper {

  final stt.SpeechToText speech = stt.SpeechToText();

  Future<void> showVoiceInputDialog({
    required BuildContext context,
    required String languageCode,
    required void Function(String text) onResult,
  }) async {
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

    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setState) {
            if (!isListening) {
              isListening = true;
              _startListening(
                languageCode: languageCode,
                onResult: (text) {
                  setState(() {
                    detectedText = text;
                    speaking = true;

                    timeoutTimer?.cancel();
                    timeoutTimer = Timer(const Duration(seconds: 3), () {
                      onResult(detectedText);
                      Navigator.of(context).pop();
                    });
                  });
                },
                onDone: () {},
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
                Navigator.of(context).pop();
              },
              child: Material(
                color: Colors.transparent,
                child: Center(
                  child: GestureDetector(
                    onTap: () {}, // Prevent inner tap dismiss
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
                          const Text(
                            "Google",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 22,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 20),
                          CircleAvatar(
                            radius: 36,
                            backgroundColor:
                                showError ? Colors.red : Colors.blue,
                            child: const Icon(
                              Icons.mic,
                              color: Colors.white,
                              size: 32,
                            ),
                          ),
                          const SizedBox(height: 20),
                          Text(
                            showError
                                ? "Didn't catch that. Try speaking again."
                                : detectedText.isEmpty
                                ? "Speak now..."
                                : detectedText,
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                            ),
                            textAlign: TextAlign.center,
                          ),
                          const SizedBox(height: 10),
                          const Text(
                            "English (United States)", // You can also pass displayLangName
                            style: TextStyle(color: Colors.grey, fontSize: 12),
                          ),
                          const SizedBox(height: 10),
                          if (showError)
                            TextButton(
                              onPressed: () {
                                Navigator.of(context).pop();
                                showVoiceInputDialog(
                                  context: context,
                                  languageCode: languageCode,
                                  onResult: onResult,
                                );
                              },
                              child: const Text(
                                "Try again",
                                style: TextStyle(color: Colors.red),
                              ),
                            ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            );
          },
        );
      },
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
          timeoutTimer = Timer(const Duration(seconds: 3), onDone);
        }
      },
      listenFor: const Duration(minutes: 1),
      pauseFor: const Duration(seconds: 3),
      cancelOnError: true,
      partialResults: true,
    );

    timeoutTimer = Timer(const Duration(seconds: 7), () {
      if (!speaking) {
        onTimeout();
        speech.stop();
      }
    });
  }
}
