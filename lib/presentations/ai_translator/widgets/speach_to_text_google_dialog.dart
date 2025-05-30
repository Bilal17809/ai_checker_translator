
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:ai_checker_translator/presentations/ai_translator/controller/languages_controller.dart';
// import 'package:ai_checker_translator/presentations/ai_translator/controller/translator_controller.dart';

// class VoiceTranslatorDialog extends StatelessWidget {
//   VoiceTranslatorDialog({super.key}) {
    
//     final controller = Get.find<TranslatorController>();
//     controller.resetVoiceTranslation();
//     controller.startListening();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return PopScope(
//       canPop: false,
//       onPopInvoked: (didPop) {
//         if (didPop) return;
//         final controller = Get.find<TranslatorController>();
//         controller.stopListening();
//         Get.back(result: controller.translatedText.value);
//       },
//       child: Dialog(
//         shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
//         child: Padding(
//           padding: const EdgeInsets.all(20),
//           child: Column(
//             mainAxisSize: MainAxisSize.min,
//             children: [
//               const Text(
//                 "Google",
//                 style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
//               ),
//               const SizedBox(height: 20),
//               Obx(() {
//                 final controller = Get.find<TranslatorController>();
//                 final langController = Get.find<LanguageController>();
                
//                 final isListening = controller.isListening.value;
//                 final sourceText = controller.sourceText.value;
//                 final translatedText = controller.translatedText.value;
//                 final sourceLang = langController.selectedSource.value.name;
//                 final targetLang = langController.selectedTarget.value.name;
                
//                 return Column(
//                   children: [
//                     Stack(
//                       alignment: Alignment.center,
//                       children: [
//                         // Listening indicator
//                         if (isListening)
//                           const SizedBox(
//                             width: 100,
//                             height: 100,
//                             child: CircularProgressIndicator(
//                               strokeWidth: 6,
//                               color: Colors.blue,
//                             ),
//                           ),
                        
//                         // Microphone button
//                         InkWell(
//                           onTap: () {
//                             if (!isListening) {
//                               controller.resetVoiceTranslation();
//                               controller.startListening();
//                             }
//                           },
//                           child: CircleAvatar(
//                             radius: 30,
//                             backgroundColor: isListening ? Colors.blue : Colors.red,
//                             child: const Icon(Icons.mic, size: 30, color: Colors.white),
//                           ),
//                         ),
//                       ],
//                     ),
//                     const SizedBox(height: 20),
//                     Text(
//                       isListening
//                         ? "Listening in $sourceLang..."
//                         : translatedText.isNotEmpty
//                           ? "Tap mic to translate again"
//                           : "Tap mic to start",
//                       style: const TextStyle(fontSize: 16, color: Colors.grey),
//                     ),
//                     const SizedBox(height: 20),
                    
//                     // Original text
//                     if (sourceText.isNotEmpty)
//                       _buildResultSection(
//                         title: "Original ($sourceLang):",
//                         content: sourceText,
//                       ),
                    
//                     // Translation result
//                     if (translatedText.isNotEmpty)
//                       _buildResultSection(
//                         title: "Translation ($targetLang):",
//                         content: translatedText,
//                       ),
                    
//                     const SizedBox(height: 20),
                    
//                     // Action buttons
//                     Row(
//                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                       children: [
//                         // Retry button
//                         ElevatedButton.icon(
//                           onPressed: () {
//                             controller.resetVoiceTranslation();
//                             controller.startListening();
//                           },
//                           icon: const Icon(Icons.mic),
//                           label: const Text("Retry"),
//                         ),
                        
//                         // Done button
//                         ElevatedButton(
//                           onPressed: () {
//                             controller.stopListening();
//                             Get.back(result: translatedText);
//                           },
//                           style: ElevatedButton.styleFrom(
//                             backgroundColor: Colors.green,
//                           ),
//                           child: const Text("Done", style: TextStyle(color: Colors.white)),
//                         ),
//                       ],
//                     ),
//                   ],
//                 );
//               }),
//             ],
//           ),
//         ),
//       ),
//     );
//   }

//   Widget _buildResultSection({required String title, required String content}) {
//     return Padding(
//       padding: const EdgeInsets.only(bottom: 16),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
//           const SizedBox(height: 8),
//           Container(
//             padding: const EdgeInsets.all(12),
//             width: double.infinity,
//             decoration: BoxDecoration(
//               color: Colors.grey[100],
//               borderRadius: BorderRadius.circular(8),
//             ),
//             child: Text(content, style: const TextStyle(fontSize: 16)),
//           ),
//         ],
//       ),
//     );
//   }
// }