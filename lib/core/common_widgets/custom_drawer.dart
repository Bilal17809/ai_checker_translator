
import 'package:ai_checker_translator/core/routes/routes_name.dart';
import 'package:ai_checker_translator/core/theme/app_colors.dart';
import 'package:ai_checker_translator/gen/assets.gen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/utils.dart';


class CustomDrawer extends StatelessWidget {
  const CustomDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: [
          Column(
            children: [
              DrawerHeader(
                decoration: const BoxDecoration(
              color: kMintGreen),
                child: Row(
                  children: [
                    ClipOval(
                      // clipBehavior: Clip.none,
                      child: Image.asset(Assets.appIcon.path, height: 70),
                    ),
                    const SizedBox(width: 12),
                    Text(
                      "AI Checker Translator",
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
              Divider(thickness: 10, height: 02),
            ],
          ),

         
          DrawerTile(
            icon: Icons.privacy_tip,
            title: 'Privacy Policy',
            onTap: () {
              Navigator.pop(context);
              // Navigate or handle
            },
          ),
          DrawerTile(
            icon: Icons.star,
            title: 'Rate Us',
            onTap: () {
              Navigator.pop(context);
         
            },
          ),
          DrawerTile(
            icon: Icons.favorite,
            title: "favourite",
            onTap: () {
              Get.toNamed(RoutesName.aitranslationHistoryScreen);
            },
          ),
          DrawerTile(icon: Icons.more, title: "More App", onTap: () {}),

        ],
      ),
    );


  }
}




class DrawerTile extends StatelessWidget {
  final IconData icon;
  final String title;
  final VoidCallback onTap;

  const DrawerTile({
    super.key,
    required this.icon,
    required this.title,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(icon, color: kMintGreen),
      title: Text(title),
      onTap: onTap,
    );
  }
}
