
// import 'package:ai_checker_translator/presentations/ai_translator/controller/languages_controller.dart';
// import 'package:ai_checker_translator/presentations/ai_translator/controller/translator_controller.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';


// class VoiceTranslatorDialog extends StatelessWidget {
//   const VoiceTranslatorDialog({super.key});

//   @override
//   Widget build(BuildContext context) {
//     final translatorController = Get.find<TranslatorController>();
//     final languageController = Get.find<LanguageController>();

  
//     WidgetsBinding.instance.addPostFrameCallback((_) {
//       translatorController.startListening();
//     });

//     return Dialog(
//       shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
//       child: Obx(() {
//         final isListening = translatorController.isListening.value;
//         final sourceText = translatorController.sourceText.value;
//         final translatedText = translatorController.translatedText.value;
//         final sourceLang = languageController.selectedSource.value.name;
//         // final targetLang = languageController.selectedTarget.value.name;

     
//         if (translatedText.isNotEmpty) {
//           Future.delayed(const Duration(milliseconds: 800), () {
//             if (Get.isDialogOpen ?? false) {
//               Get.back(result: translatedText);
//               translatorController.stopListening();
//             }
//           });
//         }

//         return Padding(
//           padding: const EdgeInsets.all(20),
//           child: Column(
//             mainAxisSize: MainAxisSize.min,
//             children: [
//               const Text(
//                 "Google",
//                 style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
//               ),
//               const SizedBox(height: 10),
//               Stack(
//                 alignment: Alignment.center,
//                 children: [
//                   if (isListening)
//                     const SizedBox(
//                       width: 100,
//                       height: 100,
//                       child: CircularProgressIndicator(
//                         strokeWidth: 6,
//                         color: Colors.blue,
//                       ),
//                     ),

//                   InkWell(
//                     onTap: () {
//                       if (!isListening) translatorController.startListening();
//                     },
//                     child: CircleAvatar(
//                       radius: 30,
//                       backgroundColor: isListening ? Colors.blue : Colors.red,
//                       child: const Icon(Icons.mic, size: 30, color: Colors.white),
//                     ),
//                   ),
//                 ],
//               ),
//               SizedBox(height:10),
//               // Text("Hi Speak something..."),
//                     Text(
//                 isListening ? "Listening in $sourceLang..." : "Tap mic to retry.",
//                 style: const TextStyle(fontSize: 16, color: Colors.grey),
//               ),
//               // const SizedBox(height: 20),

//               // Live Recognized Text
//               if (sourceText.isNotEmpty && translatedText.isEmpty)
//                 Column(
//                   children: [
//                     // const Text("You said:", style: TextStyle(fontWeight: FontWeight.bold)),
//                     const SizedBox(height: 4),
//                     Text(sourceText, style: const TextStyle(fontSize: 20)),
//                   ],
//                 ),

//               // Translated Result
//               // if (translatedText.isNotEmpty)
//               //   Column(
//               //     children: [
//               //       Text("$targetLang Translation:", style: const TextStyle(fontWeight: FontWeight.bold)),
//               //       const SizedBox(height: 4),
//               //       Text(translatedText, style: const TextStyle(fontSize: 16)),
//               //     ],
//               //   ),

//               const SizedBox(height: 20),

//               // Retry Button
//               if (!isListening && translatedText.isEmpty)
//                 ElevatedButton.icon(
//                   onPressed: translatorController.startListening,
//                   icon: const Icon(Icons.refresh),
//                   label: const Text("Try Again"),
//                 ),

//               // Cancel Button
//               // TextButton(
//               //   onPressed: () {
//               //     translatorController.stopListening();
//               //     Get.back();
//               //   },
//               //   child: const Text("Cancel"),
//               // ),
//             ],
//           ),
//         );
//       }),
//     );
//   }
// }
