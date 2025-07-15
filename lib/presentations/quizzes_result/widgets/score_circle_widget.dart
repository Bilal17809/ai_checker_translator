import 'package:flutter/material.dart';
import 'package:ai_checker_translator/core/theme/app_colors.dart';

class ScoreCircle extends StatelessWidget {
  final double score;
  const ScoreCircle({super.key, required this.score});

  @override
  Widget build(BuildContext context) {
    const double circleSize = 140; 

    return TweenAnimationBuilder<double>(
      tween: Tween(begin: 0, end: score / 100),
      duration: const Duration(seconds: 2),
      builder: (context, value, _) {
        return Stack(
          alignment: Alignment.center,
          clipBehavior: Clip.none,
          children: [
            Container(
              height: circleSize,
              width: circleSize,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(color: kMediumGreen1, width: 14),
              ),
            ),
            SizedBox(
              height: circleSize,
              width: circleSize,
              child: CircularProgressIndicator(
                value: value,
                strokeWidth: 12,
                backgroundColor: Colors.transparent,
                valueColor: const AlwaysStoppedAnimation<Color>(kMintGreen),
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
