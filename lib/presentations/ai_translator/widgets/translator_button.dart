
import 'package:ai_checker_translator/core/theme/app_colors.dart';
import 'package:flutter/material.dart';

class TranslatorButton extends StatelessWidget {
  final VoidCallback onTap;
  const TranslatorButton({super.key,required this.onTap});

  @override
  Widget build(BuildContext context) {
    final height =   MediaQuery.of(context).size.height;
    final width =   MediaQuery.of(context).size.width;
    return Align(
      alignment: Alignment.topLeft,
      child: InkWell(
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 06, horizontal: 06),
          child: Container(
            height: height * 0.05,
            width: width * 0.26,
            decoration: BoxDecoration(
              color: kMintGreen,
              borderRadius: BorderRadius.circular(50),
            ),
            child: Center(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.translate, color: kWhite, size: 14),
                    SizedBox(width: 04),
                    Text(
                      "Translate",
                      style: TextStyle(
                        color: kWhite,
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              )
            ),
          ),
        ),
      ),
    );
  }
}