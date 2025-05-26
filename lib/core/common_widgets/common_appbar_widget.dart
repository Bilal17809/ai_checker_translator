import 'package:ai_checker_translator/gen/assets.gen.dart';
import 'package:flutter/material.dart';

class CommonAppbarWidget extends StatelessWidget implements PreferredSizeWidget {
  const CommonAppbarWidget({super.key});

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      actions: [
              Image.asset(Assets.crown.path,height: 28),
              SizedBox(width: 6),
              Icon(Icons.more_vert, size: 28),
      ],
      backgroundColor: Colors.green.shade100,
      elevation: 0,
      title: Row(
        // mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const Text("Ai"),
          SizedBox(width: 04),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(6),
            ),
            child: Row(
              children: const [
                Text("GRAMMAR", style: TextStyle(fontSize: 14)),
                SizedBox(width: 4),
                Icon(Icons.menu_book_sharp, size: 16),
              ],
            ),
          ),
           SizedBox(width: 04),
          const Text("CHECKER"),
        ],
      
      ),
    );
  }
}
