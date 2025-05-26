// lib/widgets/assistant_input_box.dart
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
          style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),

        const SizedBox(height: 16),

        /// Text Field Box
        Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            border: Border.all(color: Colors.blue.shade200),
            borderRadius: BorderRadius.circular(16),
          ),
          child: Column(
            children: [
              TextField(
                controller: controller,
                maxLines: 8,
                maxLength: maxLength,
                decoration: const InputDecoration(
                  hintText: "Type here or paste your content",
                  border: InputBorder.none,
                  counterText: "",
                ),
              ),
              const SizedBox(height: 12),

              /// Bottom row with icons & counter
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  /// Dynamic icons
                  Row(
                    children: icons
                        .map((icon) => Padding(
                              padding: const EdgeInsets.only(right: 16),
                              child: Icon(icon, size: 24),
                            ))
                        .toList(),
                  ),

                  /// Character count and copy icon
                  Row(
                    children: [
                      Text(
                        "$currentLength/$maxLength",
                        style: const TextStyle(fontSize: 12, color: Colors.grey),
                      ),
                      const SizedBox(width: 8),
                      const Icon(Icons.copy, size: 20, color: Colors.blue),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),

        const SizedBox(height: 10),

        /// Premium text
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

