import 'package:ai_checker_translator/core/theme/app_colors.dart';
import 'package:flutter/material.dart';

class Button extends StatelessWidget {
  final String buttonTitle;
  final VoidCallback onPressed;
  final Color? buttonColor;
  final double height;

  const Button({
    super.key,
    required this.buttonTitle,
    required this.onPressed,
    this.buttonColor,
    this.height = 48, // ✅ fixed height
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: SizedBox(
        height: height, // ✅ fixed height box
        width: double.infinity, // optional: full width
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: buttonColor ??  Color(0xff18C184),
            padding: const EdgeInsets.symmetric(horizontal: 16),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            elevation: 4,
          ),
          onPressed: onPressed,
          child: Text(
            buttonTitle,
            textAlign: TextAlign.center,
            softWrap: false, 
            overflow: TextOverflow.ellipsis, 
            style: const TextStyle(
              color: Colors.white,
              fontSize: 16,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
      ),
    );
  }
}
