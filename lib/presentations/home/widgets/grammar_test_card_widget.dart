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
    this.icon,
    required this.subtitle,
    this.showActionButton = false,
    this.actionButtonText,
    this.onActionPressed,
    this.padding,
  });

  @override
  Widget build(BuildContext context) {
    final hight = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return Container(
      height: hight * 0.18,
      padding: padding ?? const EdgeInsets.all(16),
      decoration: roundedDecorationHomevie,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              
            Image.asset(icon!,height: hight * 0.07,),
            SizedBox(width: 14),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      title,
                      style: context.textTheme.bodyLarge!.copyWith(
                        color: kWhite,fontWeight: FontWeight.bold,fontSize: 22
                      )
                    ),
                    // const SizedBox(height: 0),
                    Text(
                      subtitle,
                      style: context.textTheme.bodySmall!.copyWith(
                        color: kWhite
                      )
                    ),
                  ],
                ),
              ),
            
            ],
          ),
            if (showActionButton && actionButtonText != null) ...[
                SizedBox(
                  height: hight * 0.04,
                  width:width * 0.27,
                  child: ElevatedButton(
                    onPressed: onActionPressed,
                    style: AppTheme.elevatedButtonStyle,             
                    child: Text(actionButtonText!,style: TextStyle(fontSize: 13,color: kBlack),),
                  ),
                ),
              ]
        ],
      ),
    );
  }
}
