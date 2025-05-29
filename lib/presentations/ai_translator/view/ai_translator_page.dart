import 'package:ai_checker_translator/core/common_widgets/assistent_input_box_widget.dart';
import 'package:ai_checker_translator/core/common_widgets/common_widgets.dart';
import 'package:ai_checker_translator/presentations/ai_translator/controller/translator_controller.dart';
import 'package:ai_checker_translator/presentations/ai_translator/widgets/Languages_show_widgets.dart';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import '../../../core/theme/app_colors.dart';

class AiTranslatorPage extends StatefulWidget {
  AiTranslatorPage({super.key});

  @override
  State<AiTranslatorPage> createState() => _AiTranslatorPageState();
}

class _AiTranslatorPageState extends State<AiTranslatorPage> {

  final TranslatorController controlle = Get.find();

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
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
          child: Column(
            children: [
              LanguageWidget(),
              SizedBox(height: 20),
              Container(
                height: 36,
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
                    () => print("Edit Tapped"),
                    () => print("Delete Tapped"),
                  ],
                ),
              ),
              AssistantInputBox(
                hintText: "Tap on Below Mic to start Typing...",
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(0),
                  topRight: Radius.circular(0),
                  bottomLeft: Radius.circular(16),
                  bottomRight: Radius.circular(16),
                ),
                controller: controlle.textController,
                icons: [],
                showFooter: false,
              ),
              SizedBox(height: height * 0.20),
              Align(
                alignment: Alignment.bottomRight,
                child: IconButton(
                  onPressed: () {},
                  icon: Icon(
                    Icons.volume_up_rounded,
                    color: kMediumGreen2,
                    size: 40,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

