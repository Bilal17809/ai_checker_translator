import 'package:ai_checker_translator/core/common_widgets/assistent_input_box_widget.dart';
import 'package:ai_checker_translator/core/common_widgets/common_appbar_widget.dart';
import 'package:ai_checker_translator/core/theme/app_colors.dart';
import 'package:ai_checker_translator/core/theme/app_theme.dart';
import 'package:ai_checker_translator/presentations/ai_dictionary/contrl/animation_controller.dart';
import 'package:ai_checker_translator/presentations/aska/view/controller/gemini_controller.dart';
import 'package:ai_checker_translator/presentations/aska/view/widgets/text_generated_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:panara_dialogs/panara_dialogs.dart';
import 'package:share_plus/share_plus.dart';

class AskAiScreen extends StatefulWidget {
  const AskAiScreen({super.key});

  @override
  State<AskAiScreen> createState() => _AskAiScreenState();
}

final GeminiController controller = Get.find<GeminiController>();

class _AskAiScreenState extends State<AskAiScreen> with WidgetsBindingObserver {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    controller.flutterTts.stop();
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.paused ||
        state == AppLifecycleState.inactive ||
        state == AppLifecycleState.detached) {
      controller.flutterTts.stop();
      controller.promptController.clear();
    }
  }

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    final bottomInset = mediaQuery.viewInsets.bottom;
    final screenHeight = mediaQuery.size.height;

    return PopScope(
      canPop: false,
      onPopInvoked: (didPop) {
        if (didPop) return;
        PanaraConfirmDialog.show(
          context,
          title: "Exit App",
          message: "Do you really want to exit the app?",
          confirmButtonText: "Exit",
          cancelButtonText: "No",
          onTapCancel: () => Navigator.of(context).pop(),
          onTapConfirm: () {
            Navigator.of(context).pop();
            SystemNavigator.pop();
          },
          panaraDialogType: PanaraDialogType.custom,
          color: kMediumGreen2,
          barrierDismissible: false,
        );
      },
      child: Scaffold(
        appBar: CommonAppbarWidget(),
        body: Stack(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
              child: SingleChildScrollView(
                physics: const NeverScrollableScrollPhysics(),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    AnimatedTypingText(
                      key: widget.key,
                      text: "Ask AI (Writting Assistant)",
                      charDuration: Duration(milliseconds: 50),
                      style: TextStyle(fontSize: 20, color: Colors.blue),
                    ),
                    const SizedBox(height: 20),
                    AssistantInputBox(
                      hintText: "Type here or paste your content",
                      controller: controller.promptController,
                      iconButtons: [],
                      showClearIcon: true,
                      footerButtons: [
                        IconButton(
                          onPressed:
                              () => controller.startMicInput(
                                languageISO: 'en-US',
                              ),
                          icon: const Icon(
                            Icons.mic,
                            size: 20,
                            color: kMintGreen,
                          ),
                        ),
                        const Spacer(),
                        IconButton(
                          onPressed: controller.copyTextwithassitantbox,
                          icon: const Icon(
                            Icons.copy,
                            size: 20,
                            color: kMintGreen,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),
                    Text.rich(
                      TextSpan(
                        text: "Daily Limits Remaining = 10 ",
                        style: const TextStyle(fontSize: 12),
                        children: [
                          TextSpan(
                            text: "Go Premium",
                            style: const TextStyle(
                              color: Colors.red,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 10),
                    Obx(
                      () => SizedBox(
                        height: 48,
                        child: ElevatedButton(
                          onPressed: () {
                            controller.generate();
                            FocusScope.of(context).unfocus();
                          },
                          style: AppTheme.elevatedButtonStyle.copyWith(
                            backgroundColor: MaterialStateProperty.all(
                              kMintGreen,
                            ),
                          ),
                          child:
                              controller.isLoading.value
                                  ? const Center(
                                    child: CircularProgressIndicator(
                                      color: kWhite,
                                    ),
                                  )
                                  : const Text('Generate'),
                        ),
                      ),
                    ),
                    const SizedBox(height: 300),
                  ],
                ),
              ),
            ),
            Positioned(
              bottom: bottomInset,
              left: 0,
              right: 0,
              top: screenHeight * 0.50,
              child: Obx(
                () =>
                    controller.responseText.isEmpty
                        ? const SizedBox()
                        : Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20),
                          child: SingleChildScrollView(
                            child: GeneratedTextWidget(
                              onTapCopy: controller.copyText,
                              onTapShare:
                                  () => Share.share(
                                    controller.responseText.value,
                                  ),
                              onTapstartSpeak: controller.speakGeneratedText,
                              text: controller.responseText.value,
                            ),
                          ),
                        ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
