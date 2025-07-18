import 'dart:io';
import 'package:ai_checker_translator/core/routes/routes_name.dart';
import 'package:ai_checker_translator/core/theme/app_colors.dart';
import 'package:ai_checker_translator/gen/assets.gen.dart';
import 'package:ai_checker_translator/presentations/subscription/subscription_view.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/utils.dart';
import 'package:url_launcher/url_launcher.dart';


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
            onTap: privacy,
          ),
          DrawerTile(
            icon: Icons.star,
            title: 'Rate Us',
            onTap: () {
              rateUs();
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
          DrawerTile(icon: Icons.more, title: "More App", onTap: () {
            moreApp();
          }),
          DrawerTile(icon: Icons.workspace_premium, title: "Ads Free", onTap: () {
            Get.to(Subscriptions());
          }),
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

void privacy() async {
  const androidUrl = 'https://modernmobileschool.blogspot.com/2017/07/modern-school-privacy-policy.html';
  const iosUrl = 'https://asadarmantech.blogspot.com';

  final url = Platform.isIOS ? iosUrl : androidUrl;

  if (await canLaunchUrl(Uri.parse(url))) {
    await launchUrl(Uri.parse(url), mode: LaunchMode.externalApplication);
  } else {
    throw 'Could not launch $url';
  }
}

void rateUs() async {
  const androidUrl =
      'https://play.google.com/store/apps/details?id=com.modernschool.aigrammar.learnenglish';
  const iosUrl =
      'https://apps.apple.com/us/app/Estonia Weather Forecast/6748671693';

  final url = Platform.isIOS ? iosUrl : androidUrl;

  if (await canLaunchUrl(Uri.parse(url))) {
    await launchUrl(Uri.parse(url), mode: LaunchMode.externalApplication);
  } else {
    throw 'Could not launch $url';
  }
}

void moreApp() async {
  const androidUrl =
      'https://play.google.com/store/apps/developer?id=Modern+School';
  const iosUrl =
      'https://apps.apple.com/us/developer/muhammad-asad-arman/id1487950157?see-all=i-phonei-pad-apps';

  final url = Platform.isIOS ? iosUrl : androidUrl;

  if (await canLaunchUrl(Uri.parse(url))) {
    await launchUrl(Uri.parse(url), mode: LaunchMode.externalApplication);
  } else {
    throw 'Could not launch $url';
  }
}