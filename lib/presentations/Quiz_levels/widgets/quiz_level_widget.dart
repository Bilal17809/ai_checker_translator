
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
    return GestureDetector(
      onTap: onTap,
      child: Container(
        // padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          // gradient: const LinearGradient(
          //   colors: [Color(0xFFB2FEFA), Color(0xFF0ED2F7)],
          //   begin: Alignment.topLeft,
          //   end: Alignment.bottomRight,
          // ),
          boxShadow: [
            BoxShadow(
              color: Colors.grey,
              blurRadius: 1
            )
          ],
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              title,
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.black87,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 8),
            Text(
              quizCount,
              style: const TextStyle(
                fontSize: 14,
                color: Colors.black54,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
