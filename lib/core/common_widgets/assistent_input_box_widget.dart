import 'package:ai_checker_translator/core/common_widgets/textform_field.dart';
import 'package:ai_checker_translator/core/theme/app_colors.dart';
import 'package:ai_checker_translator/core/theme/app_styles.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../presentations/ai_translator/controller/translation_contrl.dart';

class AssistantInputBox extends StatefulWidget {
  final int maxLength;
  final List<IconButton> iconButtons;
  final TextEditingController controller;
  final BorderRadius borderRadius;
  final bool showFooter;
  final String hintText;
  final TextAlign textalign;
  final TextDirection textDirection;
  final bool readOnly;
  final double? customHeight;
  final List<Widget>? footerButtons;
  final bool showClearIcon;

  const AssistantInputBox({
    super.key,
    required this.controller,
    this.readOnly = false,
    required this.iconButtons,
    this.maxLength = 1000,
    this.borderRadius = const BorderRadius.all(Radius.circular(16)),
    this.showFooter = true,
    required this.hintText,
    this.textDirection = TextDirection.rtl,
    this.textalign = TextAlign.start,
    this.customHeight,
    this.footerButtons,
    this.showClearIcon = false,
  });

  @override
  State<AssistantInputBox> createState() => _AssistantInputBoxState();
}

class _AssistantInputBoxState extends State<AssistantInputBox> {
  late int currentLength;

  @override
  void initState() {
    super.initState();
    currentLength = widget.controller.text.length;
    widget.controller.addListener(_updateLength);
  }

  void _updateLength() {
    setState(() {
      currentLength = widget.controller.text.length;
    });
  }

  @override
  void dispose() {
    widget.controller.removeListener(_updateLength);
    super.dispose();
  }

  final TranslationController controller = Get.put(TranslationController());
  final ScrollController _scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          height:
          widget.customHeight ?? MediaQuery.of(context).size.height * 0.24,
          padding: const EdgeInsets.symmetric(horizontal: 04, vertical: 02),
          decoration: roundedDecoration.copyWith(
            border: Border.all(color: kMintGreen, width: 2),
            borderRadius: widget.borderRadius,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: ClipRRect(
                  borderRadius: widget.borderRadius,
                  child: Scrollbar(
                    controller: _scrollController,
                    thumbVisibility: true,
                    child: SingleChildScrollView(
                      controller: _scrollController,
                      // padding: const EdgeInsets.symmetric(horizontal: 00),
                      child: CustomTextFormField(
                        readOnly: widget.readOnly,
                        textDirection: widget.textDirection,
                        textAlign: widget.textalign,
                        controller: widget.controller,
                        hintText: widget.hintText,
                        border: InputBorder.none,
                        suffixIcon: null,
                        maxLines: null, // important to allow vertical scroll
                        keyboardType: TextInputType.multiline,
                      ),
                    ),
                  ),
                ),
              ),
              if (widget.showFooter) ...[
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    if (widget.footerButtons != null) ...widget.footerButtons!,
                  ],
                ),
              ],
            ],
          ),
        ),

        // Clear icon
        if (widget.showClearIcon && widget.controller.text.isNotEmpty)
          Positioned(
            top: 12,
            right: 8,
            child: IconButton(
              icon: const Icon(Icons.close, size: 18),
              onPressed: () {
                setState(() {
                  widget.controller.clear();
                });
              },
            ),
          ),
      ],
    );
  }
}
