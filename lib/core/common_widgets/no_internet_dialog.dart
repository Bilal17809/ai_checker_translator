import 'package:ai_checker_translator/core/routes/routes_name.dart';
import 'package:ai_checker_translator/core/theme/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CustomInfoDialog extends StatelessWidget {
  final String title;
  final String message;
  final String iconPath;
  final DialogType type;
  final VoidCallback? onPrimaryPressed;
  final VoidCallback? onSecondaryPressed;

  const CustomInfoDialog({
    super.key,
    required this.title,
    required this.message,
    required this.iconPath,
    this.onPrimaryPressed,
    this.onSecondaryPressed,
    this.type = DialogType.internet,
  });

  @override
  Widget build(BuildContext context) {
    final isInternet = type == DialogType.internet;

    return Dialog(
      backgroundColor: Colors.white,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Image.asset(iconPath, height: 120),
            const SizedBox(height: 10),
            Text(
              title,
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: isInternet ? Colors.red : kMintGreen,
              ),
            ),
            const SizedBox(height: 10),
            Text(
              message,
              textAlign: TextAlign.center,
              style: const TextStyle(fontSize: 14, color: Colors.black87),
            ),
            const SizedBox(height: 16),
            if (isInternet)
              ElevatedButton.icon(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.red,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 24,
                    vertical: 12,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                ),
                icon: const Icon(Icons.wifi_off, color: Colors.white),
                label: const Text("OK", style: TextStyle(color: Colors.white)),
                onPressed: onPrimaryPressed ?? () => Get.back(),
              )
            else ...[
              ElevatedButton.icon(
                style: ElevatedButton.styleFrom(
                  backgroundColor: kMintGreen,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 24,
                    vertical: 12,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                ),
                icon: const Icon(
                  Icons.workspace_premium_outlined,
                  color: Colors.white,
                ),
                label: const Text(
                  "Unlock Premium",
                  style: TextStyle(color: Colors.white),
                ),
                onPressed:
                    onPrimaryPressed ??
                    () => Get.offNamed(RoutesName.premiumscreen),
              ),

              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 20,
                  vertical: 20,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Flexible(
                      child: PlainTextButton(
                        label: "Cancel",
                        color: Colors.black,
                        onPressed: () => Get.back(),
                      ),
                    ),
                    const SizedBox(width: 20),
                    Flexible(
                      child: PlainTextButton(
                        label: "Watch Ads",
                        color: Colors.blue,
                        onPressed: onSecondaryPressed??() => Get.back(),
                      ),
                    ),
                  ],
                ),
              )



            ],
          ],
        ),
      ),
    );
  }
}

enum DialogType { internet, premium }

class PlainTextButton extends StatelessWidget {
  final String label;
  final Color color;
  final VoidCallback onPressed;

  const PlainTextButton({
    Key? key,
    required this.label,
    required this.onPressed,
    this.color = Colors.black,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: onPressed,
      style: ButtonStyle(
        overlayColor: MaterialStateProperty.all(Colors.transparent),
        padding: MaterialStateProperty.all(EdgeInsets.zero),
        minimumSize: MaterialStateProperty.all(Size.zero),
        tapTargetSize: MaterialTapTargetSize.shrinkWrap,
        backgroundColor: MaterialStateProperty.all(Colors.transparent),
        elevation: MaterialStateProperty.all(0),
        shape: MaterialStateProperty.all(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.zero,
            side: BorderSide.none,
          ),
        ),
      ),
      child: Text(label, style: TextStyle(color: color)),
    );
  }
}
