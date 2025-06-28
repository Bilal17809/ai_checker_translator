import 'package:ai_checker_translator/core/theme/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ai_checker_translator/presentations/quizdetail/controller/quiz_detail_controller.dart';

class QuizCard extends StatelessWidget {
  final int index;
  final VoidCallback? onNext;
  final VoidCallback? onBack;
  final QuizDetailController controller = Get.find<QuizDetailController>();

  QuizCard({super.key, required this.index, this.onNext, this.onBack});

  @override
  Widget build(BuildContext context) {
    final quiz = controller.quizzesList[index];

    return Obx(() {
      final selectedCode = controller.selectedAnswers[quiz.quizID];
      final hasAnswered = selectedCode != null;
      final isResultMode = controller.isResultMode.value;

      final options = controller.details
          .where((e) => e.quizID == quiz.quizID)
          .toList();

      return Card(
        color: Colors.white,
        margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 16),
        elevation: 4,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              /// ✅ Quiz question
              Text(
                " ${quiz.content}",
                style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
              ),
              const SizedBox(height: 16),

              /// ✅ Options
              ...options.asMap().entries.map((entry) {
                final i = entry.key;
                final option = entry.value;

                final isSelected = selectedCode == option.code;
                final isCorrect = quiz.answer.trim() == option.code.trim();

                Color bgGradient = Colors.white;
                Color borderColor = Colors.grey.shade300;
                Color textColor = Colors.black;
                Color circleBg = Colors.grey.shade300;
                Color circleTextColor = Colors.black;

                if (hasAnswered || isResultMode) {
                  if (isCorrect) {
                    bgGradient = kMediumGreen1;
                    textColor = Colors.white;
                    borderColor = Colors.green;
                    circleBg = kMediumGreen2;
                    circleTextColor = Colors.white;
                    if (isSelected) {
                      circleBg = kMediumGreen2;
                      bgGradient = kMediumGreen1;
                      circleTextColor = Colors.white;
                      textColor = Colors.black;
                    }
                  } else if (isSelected) {
                    bgGradient = const Color(0x80ec9ca3);
                    textColor = Colors.white;
                    borderColor = Colors.red;
                    circleBg = Colors.red;
                    circleTextColor = Colors.white;
                  }
                } else if (isSelected) {
                  circleBg = Colors.teal;
                  circleTextColor = Colors.white;
                }

                return GestureDetector(
                  onTap: () {
                    if (!hasAnswered && !isResultMode) {
                      controller.selectedAnswers[quiz.quizID] = option.code;
                    }
                  },
                  child: Container(
                    margin: const EdgeInsets.symmetric(vertical: 6),
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: bgGradient,
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(color: borderColor),
                    ),
                    child: Row(
                      children: [
                        Container(
                          width: 28,
                          height: 28,
                          decoration: BoxDecoration(
                            color: circleBg,
                            shape: BoxShape.circle,
                          ),
                          alignment: Alignment.center,
                          child: Text(
                            String.fromCharCode(65 + i), // A, B, C...
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: circleTextColor,
                            ),
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: Text(
                            option.content,
                            style: TextStyle(
                              fontSize: 16,
                              color: textColor,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              }).toList(),

              /// ✅ Explanation (always show in result mode or after answer)
              if (hasAnswered || isResultMode) ...[
                const SizedBox(height: 16),
                Text(
                  "Explanation: ${quiz.explanation}",
                  style: const TextStyle(
                    fontSize: 14,
                    fontStyle: FontStyle.italic,
                    color: Colors.teal,
                  ),
                ),
              ],

              const Spacer(),

              /// ✅ Buttons: hide in result mode
              if (!isResultMode)
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    CircleAvatar(
                      maxRadius: 34,
                      backgroundColor: kMediumGreen2,
                      child: IconButton(
                        icon: const Icon(
                          Icons.arrow_back,
                          color: Colors.white,
                          size: 38,
                        ),
                        onPressed: onBack,
                      ),
                    ),
                    CircleAvatar(
                      maxRadius: 34,
                      backgroundColor:
                          hasAnswered ? kMediumGreen2 : Colors.grey.shade400,
                      child: IconButton(
                        icon: const Icon(
                          Icons.arrow_forward,
                          color: Colors.white,
                          size: 38,
                        ),
                        onPressed: hasAnswered ? onNext : null,
                      ),
                    ),
                  ],
                ),
            ],
          ),
        ),
      );
    });
  }
}
