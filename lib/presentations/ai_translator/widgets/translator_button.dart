
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
        child: Container(
          height: height * 0.06,
          width: width * 0.26,
          decoration: BoxDecoration(
            gradient: LinearGradient(colors: [
              // Colors.lightGre,
              Colors.green,
              Colors.lightGreen
            ]),
            borderRadius: BorderRadius.circular(16)
          ),
          child: Center(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(children: [
                  Icon(Icons.translate, color: kWhite, size: 18),
                  Text(
                    "Translate",
                    style: TextStyle(
                      color: kWhite,
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
              ],),
            )
          ),
        ),
      ),
    );
  }
}