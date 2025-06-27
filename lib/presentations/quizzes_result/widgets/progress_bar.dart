import 'package:flutter/material.dart';

class ProgressBar extends StatelessWidget {
  final String label;
  final int count;
  final int total;
  final Color color;
  final bool isCorrect; // ✅ new

  const ProgressBar({
    super.key,
    required this.label,
    required this.count,
    required this.total,
    required this.color,
    required this.isCorrect, // ✅ new
  });

  @override
  Widget build(BuildContext context) {
    final double progress = count / total;

    return TweenAnimationBuilder<double>(
      tween: Tween(begin: 0, end: progress),
      duration: const Duration(seconds: 2),
      builder: (context, value, _) => Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // Label Text
            Text(
              label,
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: isCorrect ? Colors.green : Colors.red, // ✅ label color
              ),
            ),
        
            const SizedBox(width: 8),
        
            // Count Text
            Text(
              "$count",
              style: TextStyle(
                fontSize: 16,
                color: isCorrect ? Colors.green : Colors.red, 
                fontWeight: FontWeight.bold// ✅ count color
              ),
            ),
        
            const SizedBox(width: 12),
        
            // Progress Bar
            Expanded(
              child: LinearProgressIndicator(
                value: value,
                color: isCorrect ? Colors.green : Colors.red, // ✅ progress color
                backgroundColor: Colors.grey.shade300,
                minHeight: 12,
                borderRadius: BorderRadius.circular(20),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
