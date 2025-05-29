import 'package:ai_checker_translator/core/theme/app_colors.dart';
import 'package:flutter/material.dart';

class KeyValueText extends StatelessWidget {
  final String title;
  final String value;
  final Color textColor;
  final List<IconData> icons;
  final List<VoidCallback?>? onIconTaps;

  const KeyValueText({
    super.key,
    required this.title,
    required this.value,
    required this.textColor,
    required this.icons,
    this.onIconTaps,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          /// Left side - title
          Text(
            title,
            style: Theme.of(
              context,
            ).textTheme.bodyMedium?.copyWith(color: kWhite, fontSize: 14)
          ),

          /// Right side - value + icons
          Row(
            children: [
              Text(
                value,
                style: Theme.of(
                  context,
                ).textTheme.titleSmall?.copyWith(color: textWhiteColor),
              ),
              const SizedBox(width: 8),
              ...List.generate(icons.length, (index) {
                return Padding(
                  padding: const EdgeInsets.only(left: 8),
                  child: InkWell(
                    onTap:
                        onIconTaps != null && index < onIconTaps!.length
                            ? onIconTaps![index]
                            : null,
                    borderRadius: BorderRadius.circular(20),
                    child: Icon(icons[index], size: 20, color: kWhite),
                  ),
                );
              }),
            ],
          ),
        ],
      ),
    );
  }
}
