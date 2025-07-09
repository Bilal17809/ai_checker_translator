import 'package:ai_checker_translator/core/theme/app_colors.dart';
import 'package:ai_checker_translator/core/theme/app_styles.dart';
import 'package:ai_checker_translator/extension/extension.dart';
import 'package:flutter/material.dart';
import 'package:get/get_navigation/get_navigation.dart';

class PhrassesExampleWidget extends StatelessWidget {
  final String phrase;
  final String explanation;
  final  VoidCallback? speakonTap;
  final VoidCallback? copy;
  const PhrassesExampleWidget({
    super.key,
    required this.phrase,
    required this.explanation,
      required this.speakonTap,
      required this.copy
  });

  @override
  Widget build(BuildContext context) {
    final hieght = MediaQuery.of(context).size.height;
    return Column(
      children: [
        Container(
          height: 68,
          width: double.infinity,
          decoration: roundedDecoration,
          child: Center(
            child: Text(
              phrase,
              style: context.textTheme.bodyLarge!.copyWith(
                fontWeight: FontWeight.bold,fontSize: 20
              ),
              textAlign: TextAlign.center,
            ),
          ),
        ),
        const SizedBox(height: 34),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12),
          child: Container(
            height: hieght * 0.30,
            // padding: const EdgeInsets.all(),
            decoration: BoxDecoration(
              color: Colors.grey[100],
              border: Border.all(color: kMintGreen),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 14),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      buttons(
                        speakonTap
                        , Icons.copy),
                      //  SizedBox(width: 10),
                      buttons(copy, Icons.volume_up_outlined),
                    ],
                  ),
                  Expanded(
                    child: SingleChildScrollView(
                      padding: const EdgeInsets.only(top: 8),
                      child: Text(
                        explanation,
                        style: context.textTheme.bodyLarge,
                        textAlign: TextAlign.left,
                      ),
                    ),
                  ),
                  SizedBox(height: 10),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}

Widget buttons(final VoidCallback? onTap, IconData icons) {
  return InkWell(
    onTap: onTap,
    child: Padding(
      padding: const EdgeInsets.all(6.0),
      child: Container(
        height: 40,
        width: 40,
        decoration: roundedDecoration.copyWith(
          borderRadius: BorderRadius.circular(50),
        ),
        child: Center(child: Icon(icons, color: kMintGreen)),
      ),
    ),
  );
}
