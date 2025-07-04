import 'package:ai_checker_translator/core/theme/app_colors.dart';
import 'package:ai_checker_translator/extension/extension.dart';
import 'package:flutter/material.dart';

class CommonAppbarWidget extends StatelessWidget
    implements PreferredSizeWidget {
  const CommonAppbarWidget({super.key});

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      iconTheme: IconThemeData(color: kWhite),
      centerTitle: true,
      actions: [
        // Image.asset(Assets.crown.path, height: 28),
        // SizedBox(width: 6),
        // // Icon(Icons.more_vert, size: 28),
      ],
      backgroundColor: kMintGreen,
      elevation: 0,
      title: Row(
        // mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            "Ai",
            style: context.textTheme.bodyLarge?.copyWith(
              color: kWhite,
              fontSize: 24,
            ),
          ),
          SizedBox(width: 04),
          Row(
            children: [
              Text(
                "Grammar",
                style: context.textTheme.bodyLarge!.copyWith(
                  color: kWhite,
                  fontSize: 18,
                ),
              ),
              // SizedBox(width: 4),
              // Icon(Icons.menu_book_sharp, size: 16),
            ],
          ),
          SizedBox(width: 04),
          Text(
            "Checker",
            style: context.textTheme.bodyLarge?.copyWith(
              color: kWhite,
              fontSize: 24,
            ),
          ),
        ],
      ),
    );
  }
}
