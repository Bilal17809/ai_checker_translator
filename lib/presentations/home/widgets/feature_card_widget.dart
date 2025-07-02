
import 'package:ai_checker_translator/core/theme/app_styles.dart';
import 'package:ai_checker_translator/extension/extension.dart';
import 'package:flutter/material.dart';

class FeatureCardWidget extends StatelessWidget {
  final String image;
  final String title;
  final String? subtitle;
  final VoidCallback OnTap;

  const FeatureCardWidget({
    super.key,
    required this.image,
    required this.title,
    this.subtitle,
    required this.OnTap
  });

  @override
  Widget build(BuildContext context) {
     final hight = MediaQuery.of(context).size.height;
     final width = MediaQuery.of(context).size.width;
    return GestureDetector(
      onTap: OnTap,
      child: Container(
        width: width * 0.45,
        height: hight * 0.18,
        padding: const EdgeInsets.all(12),
        decoration:rounBorderDecoration,
        
        child: Column(
          children: [
            Image.asset(image, height: 50),
            const SizedBox(height: 8),
            Text(
              title,
              style: context.textTheme.bodyLarge!.copyWith(
                fontWeight: FontWeight.bold
              ),
                textAlign: TextAlign.center,
            ),
            if (subtitle != null && subtitle!.isNotEmpty)
              Text(
                "($subtitle)",
                style: context.textTheme.bodySmall!,
                textAlign: TextAlign.center,
              ),
          ],
        ),
      ),
    );
  }
}
