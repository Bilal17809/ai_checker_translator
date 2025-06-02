
import 'package:ai_checker_translator/core/theme/app_colors.dart';
import 'package:flutter/material.dart';

class iconButton extends StatelessWidget {
  final VoidCallback onTap;
  final IconData icon;
  const iconButton({super.key,required this.onTap,required this.icon});

  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      backgroundColor: kMediumGreen2,
      child: IconButton(
          onPressed: onTap,
          icon: Icon(icon,color: kWhite,),
      ),
    );
  }
}