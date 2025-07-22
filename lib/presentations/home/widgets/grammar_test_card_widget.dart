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
  final VoidCallback? onTap;

  const GrammarTestCardWidget({
    super.key,
    required this.title,
    required this.subtitle,
    this.showActionButton = false,
    this.actionButtonText,
    this.onActionPressed,
    this.padding,
    this.icon,
    this.onTap,

  });

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;

    return GestureDetector(
      onTap: onTap,
      child: IntrinsicHeight(
        child: Container(
          padding: padding ?? const EdgeInsets.all(10),
          decoration: roundedDecorationHomevie,
          child: Column(
            // mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  if (icon != null)
                    Image.asset(
                      icon!,
                      height: height * 0.08,
                      fit: BoxFit.contain,
                    ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          title,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: context.textTheme.bodyMedium!.copyWith(
                            color: kWhite,
                            fontWeight: FontWeight.bold,
                            fontSize:height*0.02,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          subtitle,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: context.textTheme.bodySmall!.copyWith(
                            color: kWhite,
                            fontSize: 12,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              if (showActionButton && actionButtonText != null) ...[
                Align(
                  alignment: Alignment.bottomRight,
                  child: SizedBox(
                    height: height*0.035,
                    width: width * 0.3,
                    child: Expanded(
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
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}
