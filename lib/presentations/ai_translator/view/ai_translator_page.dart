import 'package:ai_checker_translator/core/common_widgets/assistent_input_box_widget.dart';
import 'package:ai_checker_translator/core/common_widgets/common_widgets.dart';
import 'package:ai_checker_translator/presentations/ai_translator/controller/translator_controller.dart';
import 'package:ai_checker_translator/presentations/ai_translator/widgets/Languages_show_widgets.dart';
import 'package:ai_checker_translator/presentations/ai_translator/widgets/translated_text_widget.dart';
// import 'package:ai_checker_translator/presentations/ai_translator/widgets/icon_button.dart';
import 'package:ai_checker_translator/presentations/ai_translator/widgets/translator_button.dart';
import 'package:ai_checker_translator/translations/translation_contrl.dart';
import 'package:country_flags/country_flags.dart';
// import 'package:ai_checker_translator/presentations/ai_translator/widgets/translator_button.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../core/theme/app_colors.dart';

class AiTranslatorPage extends StatefulWidget {
  AiTranslatorPage({super.key});

  @override
  State<AiTranslatorPage> createState() => _AiTranslatorPageState();
}

class _AiTranslatorPageState extends State<AiTranslatorPage> {

  // final TranslatorController controlle = Get.find();
  final TranslationController controller = Get.put(TranslationController());

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: kLightGreen1,
        title: LogoWidget(title: 'Voice Typing All Languages'),
        centerTitle: true,
      ),
      drawer: Drawer(),
      body: SingleChildScrollView(
        // physics: NeverScrollableScrollPhysics(),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
          child: Column(
        
          
            children: [
              LanguageWidget(),
              SizedBox(height: 20),
              Container(
                height: height * 0.06,
                decoration: BoxDecoration(
                  color: kMediumGreen2,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(10),
                    topRight: Radius.circular(10),
                  ),
                ),
                child: KeyValueText(
                  title: "Write Message",
                  value: "",
                  textColor: Colors.teal,
                  icons: [Icons.copy, Icons.close],
                  onIconTaps: [
                    () => controller.copyText(),
                    () => controller.clearData(),
                
                  ],
                ),
              ),
Obx(() {
                final isSourceRTL = controller.isRTLLanguage(
                  controller.selectedLanguage1.value,
                );
                // final input = controller.controller.text.trim();
                // final translated = controller.translatedText.value.trim();

                // final displayText = (input.isNotEmpty) ? input : input;
                return AssistantInputBox(
                  hintText: "Tap on Below Mic to start Typing...",
                  textalign: isSourceRTL ? TextAlign.right : TextAlign.left,
                  textDirection:
                      isSourceRTL ? TextDirection.rtl : TextDirection.ltr,
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(0),
                    topRight: Radius.circular(0),
                    bottomLeft: Radius.circular(16),
                    bottomRight: Radius.circular(16),
                  ),
                  controller: controller.controller,
                  // readOnly: true,
                  iconButtons: [
                    IconButton(
                      onPressed: () {
                        controller.copyText();
                      },
                      icon: Icon(Icons.copy, color: kMediumGreen2),
                    ),
                    IconButton(
                      onPressed: () {
                        controller.clearData();
                      },
                      icon: Icon(Icons.delete, color: kMediumGreen2),
                    ),
                    IconButton(
                      onPressed: () {
                        controller.speakText();
                      },
                      icon: Icon(Icons.volume_up_rounded, color: kMediumGreen2),
                    ),
                  ],
                  showFooter: true,
                );
              }),
              SizedBox(height: 20),
              Obx(() {
                final input = controller.controller.text.trim();
                final translated = controller.translatedText.value.trim();
                if (input.isNotEmpty || translated.isNotEmpty) {
                  return Padding(
                    padding: const EdgeInsets.only(top: 16),
                    child: TranslatedTextWidget(),
                  );
                } else {
                  return Text("No History");
                }
              }),

              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [

                ],
              ),
              // SizedBox(height: height * 0.08),
              // Align(
              //   alignment: Alignment.bottomRight,
              //   child: IconButton(
              //     onPressed: () {},
              //     icon: Icon(
              //       Icons.volume_up_rounded,
              //       color: kMediumGreen2,
              //       size: 40,
              //     ),

              //   )
              // ),
           
            ],
          ),
        ),
      ),
    );
  }
}

