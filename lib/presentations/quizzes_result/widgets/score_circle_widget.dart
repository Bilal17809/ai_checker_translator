import 'package:flutter/material.dart';
import 'package:ai_checker_translator/core/theme/app_colors.dart';

class ScoreCircle extends StatelessWidget {
  final double score;
  const ScoreCircle({super.key, required this.score});

  @override
  Widget build(BuildContext context) {
    final hight = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return TweenAnimationBuilder<double>(
      tween: Tween(begin: 0, end: score / 100),
      duration: const Duration(seconds: 2),
      builder: (context, value, _) {
        return Stack(
          alignment: Alignment.center,
          clipBehavior: Clip.none,
          children: [
            Container(
              height: hight * 0.21,
              width: width * 0.40,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(100),
                border: Border.all(color: kMediumGreen1, width: 14),
              ),
            ),
            Positioned(
              top: -1,
              child: SizedBox(
                height: hight * 0.21,
                width: width * 0.40,
                child: CircularProgressIndicator(
                  value: value,
                  strokeWidth: 12,
                  backgroundColor: Colors.transparent,
                  valueColor: const AlwaysStoppedAnimation<Color>(kMintGreen),
                ),
              ),
            ),
            Text(
              "${(value * 100).toInt()}%",
              style: const TextStyle(
                fontSize: 32,
                fontWeight: FontWeight.bold,
                color: Color(0xff18C184),
              ),
            ),
          ],
        );
      },
    );
  }
}
