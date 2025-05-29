import 'package:ai_checker_translator/core/common_widgets/textform_field.dart';
import 'package:ai_checker_translator/core/theme/app_colors.dart';
import 'package:flutter/material.dart';
class AssistantInputBox extends StatefulWidget {
  final int maxLength;
  final List<IconData> icons;
  final TextEditingController controller;
  final BorderRadius borderRadius;
  final bool showFooter;
  final String hintText;
  const AssistantInputBox({
    super.key,
    required this.controller,
    required this.icons,
    this.maxLength = 1000,
    this.borderRadius = const BorderRadius.all(Radius.circular(16)),
    this.showFooter = true,
    required this.hintText
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

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color: kMediumGreen1, width: 2),
        borderRadius: widget.borderRadius,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.2),
            spreadRadius: 2,
            blurRadius: 8,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      child: Column(
        children: [
          CustomTextFormField(
            controller: widget.controller,
            hintText: widget.hintText,
            maxLines: 10,
            border: InputBorder.none,
          ),
          if (widget.showFooter) ...[
            const SizedBox(height: 12),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children:
                      widget.icons
                          .map(
                            (icon) => Padding(
                              padding: const EdgeInsets.only(right: 16),
                              child: Icon(icon, size: 24, color: kMediumGreen2),
                            ),
                          )
                          .toList(),
                ),
                Row(
                  children: [
                    Text(
                      "$currentLength/${widget.maxLength}",
                      style: const TextStyle(fontSize: 12, color: Colors.grey),
                    ),
                    const SizedBox(width: 8),
                    const Icon(Icons.copy, size: 20, color: kMediumGreen2),
                  ],
                ),
              ],
            ),
          ],
        ],
      ),
    );
  }
}
