import 'package:ai_checker_translator/core/theme/app_colors.dart';
import 'package:ai_checker_translator/presentations/ai_dictionary/contrl/animation_controller.dart';
import 'package:ai_checker_translator/presentations/report_issue/view/report_issue_view.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controller/gemini_controller.dart';

class GeneratedTextWidget extends StatefulWidget {
  final String text;
  final VoidCallback onTapCopy;
  final VoidCallback onTapstartSpeak;
  final VoidCallback onTapShare;

  const GeneratedTextWidget({
    super.key,
    required this.text,
    required this.onTapCopy,
    required this.onTapShare,
    required this.onTapstartSpeak,
  });

  @override
  State<GeneratedTextWidget> createState() => _GeneratedTextWidgetState();
}

class _GeneratedTextWidgetState extends State<GeneratedTextWidget> {
  final ScrollController _scrollController = ScrollController();
  final geminiController = Get.find<GeminiController>();

  @override
  Widget build(BuildContext context) {
    final hiegt = MediaQuery.of(context).size.height;
    return Obx(() {
      return Container(
        height: hiegt * 0.28,
        // padding: const EdgeInsets.symmetric(horizontal: 08),
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(color: kMintGreen, width: 1.5),
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.08),
              blurRadius: 4,
              offset: const Offset(0, 2),
            ),
          ],
        ),
      
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            SizedBox(height: 10),
            Expanded(
              child: ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: Scrollbar(
                  controller: _scrollController,
                  thumbVisibility: true,
                  child: SingleChildScrollView(
                    controller: _scrollController,
                    child: Align(
                      alignment: Alignment.topLeft,
                      child: _buildContent(),
                    ),
                  ),
                ),
              ),
            ),
            // const SizedBox(height: 06),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Obx(() {
                  return IconButton(
                    onPressed: widget.onTapstartSpeak,
                    icon: Icon(
                      geminiController.isSpeaking.value
                          ? Icons.volume_up
                          : Icons.volume_down,
                      color: kMintGreen,
                    ),
                  );
                }),
                Row(
                  children: [
                    IconButton(
                      icon: const Icon(
                        Icons.report,
                        size: 23,
                        color: kMintGreen,
                      ),
                      tooltip: "Report",
                      onPressed:(){
                        Get.to(ReportScreen());
                      },
                    ),
                    IconButton(
                      icon: const Icon(Icons.copy, size: 20, color: kMintGreen),
                      tooltip: "Copy",
                      onPressed: widget.onTapCopy,
                    ),
                    IconButton(
                      icon: const Icon(
                        Icons.share,
                        size: 20,
                        color: kMintGreen,
                      ),
                      tooltip: "Share",
                      onPressed: widget.onTapShare,
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      );
    });
  }

  Widget _buildContent() {
    if (geminiController.isLoading.value) {
      return _buildLoadingWidget();
    }

    if (widget.text.isEmpty) {
      return const SizedBox.shrink();
    }

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      child: SimpleTypingText(
        text: widget.text,
        style: const TextStyle(fontSize: 14, height: 1.4),
        charDuration: const Duration(milliseconds: 8),
        scrollController: _scrollController,
      ),
    );
  }

  Widget _buildLoadingWidget() {
    return const Padding(
      padding: EdgeInsets.symmetric(vertical: 40),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircularProgressIndicator(color: kMintGreen),
            SizedBox(height: 16),
            Text(
              "Generating response...",
              style: TextStyle(color: Colors.grey, fontStyle: FontStyle.italic),
            ),
          ],
        ),
      ),
    );
  }
}
