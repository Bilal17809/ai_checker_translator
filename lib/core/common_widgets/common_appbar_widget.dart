
import 'package:ai_checker_translator/core/theme/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/utils.dart';

class CommonAppbarWidget extends StatelessWidget
    implements PreferredSizeWidget {
  const CommonAppbarWidget({super.key});



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
  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}


class CommonAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String appBarTitle;

  const CommonAppBar({super.key, required this.appBarTitle});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      iconTheme: IconThemeData(color: kWhite),
      backgroundColor: kMintGreen,
      centerTitle: true,
      title: Text(
        appBarTitle,
        style: const TextStyle(
          color: Colors.white,
          fontSize: 22,
          fontWeight: FontWeight.w600,
        ),
      ),
      elevation: 0,
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}

