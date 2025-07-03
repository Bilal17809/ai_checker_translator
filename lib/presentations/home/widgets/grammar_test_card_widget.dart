import 'package:ai_checker_translator/core/theme/app_colors.dart';
import 'package:ai_checker_translator/core/theme/app_styles.dart';
import 'package:ai_checker_translator/core/theme/app_theme.dart';
import 'package:ai_checker_translator/extension/extension.dart';
import 'package:flutter/material.dart';

class GrammarTestCardWidget extends StatelessWidget {
  final String title;
  final String subtitle;
  final bool showActionButton;
  final String? actionButtonText;
  final VoidCallback? onActionPressed;
  final EdgeInsetsGeometry? padding;
  final String? icon;

  const GrammarTestCardWidget({
    super.key,
    required this.title,
    required this.subtitle,
    this.showActionButton = false,
    this.actionButtonText,
    this.onActionPressed,
    this.padding,
    this.icon,
  });

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;

    return Container(
      height: height * 0.18,
      padding: padding ?? const EdgeInsets.all(16),
      decoration: roundedDecorationHomevie,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Expanded(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                if (icon != null)
                  Image.asset(
                    icon!,
                    height: height * 0.07,
                    fit: BoxFit.contain,
                  ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Flexible(
                        child: Text(
                          title,
                          maxLines: 3,
                          overflow: TextOverflow.ellipsis,
                          style: context.textTheme.bodyLarge!.copyWith(
                            color: kWhite,
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                          ),
                        ),
                      ),
                      const SizedBox(height: 4),
                      Flexible(
                        child: Text(
                          subtitle,
                          maxLines: 3,
                          overflow: TextOverflow.ellipsis,
                          style: context.textTheme.bodySmall!.copyWith(
                            color: kWhite,
                            fontSize: 10,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          if (showActionButton && actionButtonText != null) ...[
            const SizedBox(height: 8),
            Align(
              alignment: Alignment.bottomRight,
              child: SizedBox(
                height: height * 0.045,
                width: width * 0.3,
                child: ElevatedButton(
                  onPressed: onActionPressed,
                  style: AppTheme.elevatedButtonStyle,
                  child: FittedBox(
                    fit: BoxFit.scaleDown,
                    child: Text(
                      actionButtonText!,
                      style: const TextStyle(fontSize: 13, color: kBlack),
                    ),
                  ),
                ),
              ),
            ),
          ]
        ],
      ),
    );
  }
}
