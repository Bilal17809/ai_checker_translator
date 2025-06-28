
import 'package:ai_checker_translator/core/theme/app_colors.dart';
import 'package:flutter/material.dart';
class QuizCategoryBox extends StatelessWidget {
  final String title;
  final String quizCount;
  final VoidCallback onTap;

  const QuizCategoryBox({
    super.key,
    required this.title,
    required this.quizCount,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final hight = MediaQuery.of(context).size.height;
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: hight * 0.20,
        width: double.infinity, // Fixed height works better in ListView
        decoration: BoxDecoration(

          color: kMintGreen,
          // // boxShadow: [
          // //   BoxShadow(
          // //     color: Colors.grey,
          // //     blurRadius: 1),
          // ],
          borderRadius: BorderRadius.circular(12),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: kWhite,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 8),
              
              Text(
                quizCount,
                style: const TextStyle(fontSize: 14, color: Colors.black54),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
