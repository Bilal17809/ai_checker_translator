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
    required this.OnTap,
  });

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;

    return GestureDetector(
      onTap: OnTap,
      child: Container(
        width: width * 0.45,
        padding: const EdgeInsets.all(12),
        height: height * 0.18,
        decoration: rounBorderDecoration,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Flexible(
              flex: 3,
              child: Image.asset(image, height: 50, fit: BoxFit.contain),
            ),
            const SizedBox(height: 8),
            Flexible(
              flex: 2,
              child: Text(
                title,
                style: context.textTheme.bodyLarge!.copyWith(
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
            ),
            if (subtitle != null && subtitle!.isNotEmpty)
              Flexible(
                flex: 2,
                child: Text(
                  "($subtitle)",
                  style: context.textTheme.bodySmall,
                  textAlign: TextAlign.center,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
          ],
        ),
      ),
    );
  }
}
