// lib/widgets/assistant_input_box.dart
import 'package:ai_checker_translator/core/common_widgets/textform_field.dart';
import 'package:ai_checker_translator/core/theme/app_colors.dart';
import 'package:flutter/material.dart';

class AssistantInputBox extends StatelessWidget {
  final String title;
  final int maxLength;
  final int currentLength;
  final List<IconData> icons;
  final TextEditingController controller;

  const AssistantInputBox({
    super.key,
    required this.title,
    required this.controller,
    required this.icons,
    this.maxLength = 1000,
    this.currentLength = 0,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 16),
        Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: Colors.white,
            border: Border.all(color: kMediumGreen1, width: 2),
            borderRadius: BorderRadius.circular(16),
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
                hintText: "Type here or paste your content",
                maxLines: 10,
                border: InputBorder.none,   
              ),
              const SizedBox(height: 12),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children:
                        icons
                            .map(
                              (icon) => Padding(
                                padding: const EdgeInsets.only(right: 16),
                                child: Icon(
                                  icon,
                                  size: 24,
                                  color: kMediumGreen2,
                                ),
                              ),
                            )
                            .toList(),
                  ),

                  Row(
                    children: [
                      Text(
                        "$currentLength/$maxLength",
                        style: const TextStyle(
                          fontSize: 12,
                          color: Colors.grey,
                        ),
                      ),
                      const SizedBox(width: 8),
                      const Icon(Icons.copy, size: 20, color: kMediumGreen2),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),

        const SizedBox(height: 10),

        const Text.rich(
          TextSpan(
            text: "Daily Limits Remaining=10 ",
            style: TextStyle(fontSize: 12),
            children: [
              TextSpan(
                text: "Go Premium",
                style: TextStyle(
                  color: Colors.red,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
