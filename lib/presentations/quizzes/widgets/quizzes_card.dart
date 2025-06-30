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
    final double height = MediaQuery.of(context).size.height;

    return Obx(() {
      final selectedCode = controller.selectedAnswers[quiz.quizID];
      final hasAnswered = selectedCode != null;
      final isResultMode = controller.isResultMode.value;
      final options = controller.details
          .where((e) => e.quizID == quiz.quizID)
          .toList();

      return SizedBox(
        height: height,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Stack(
            clipBehavior: Clip.none,
            children: [
              /// 🟨 White Container (Question + progress circle)
              Positioned(
                top: 50,
                left: 0,
                right: 0,
                child: Container(
                  width: double.infinity,
                  height: height * 0.32,
                  padding: const EdgeInsets.only(
                    top: 60,
                    left: 16,
                    right: 16,
                    bottom: 16,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                    boxShadow: [
                      BoxShadow(color: Colors.grey.shade400, blurRadius: 2),
                    ],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const SizedBox(height: 20),
                      Text(
                        "Question ${index + 1}/${controller.quizzesList.length}",
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 10),
                      Text(
                        quiz.content,
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                          fontSize: 14,
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              /// 🟢 Circular progress on top
              Positioned(
                top: 0,
                left: 0,
                right: 0,
                child: Center(
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      Container(
                        height: 110,
                        width: 110,
                        decoration: const BoxDecoration(
                          color: kWhite,
                          shape: BoxShape.circle,
                        ),
                      ),
                      SizedBox(
                        height: 96,
                        width: 96,
                        child: CircularProgressIndicator(
                          value: (index + 1) / controller.quizzesList.length,
                          strokeWidth: 8,
                          backgroundColor: Colors.white,
                          color: kMintGreen,
                        ),
                      ),
                      Text(
                        "${index + 1}",
                        style: const TextStyle(
                          fontSize: 40,
                          fontWeight: FontWeight.bold,
                          color: kMintGreen,
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              /// ✅ Options scrollable below the white container
              Positioned(
                top: 50 + height * 0.30 + 32,
                left: 0,
                right: 0,
                bottom: 0,
                child: SingleChildScrollView(
                  physics: const BouncingScrollPhysics(),
                  child: Column(
                    children: [
                      ...options.asMap().entries.map((entry) {
                        final i = entry.key;
                        final option = entry.value;

                        final isSelected = selectedCode == option.code;
                        final isCorrect =
                            quiz.answer.trim() == option.code.trim();

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
                              controller.selectedAnswers[quiz.quizID] =
                                  option.code;
                            }
                          },
                          child: Container(
                            margin: const EdgeInsets.symmetric(
                              vertical: 6,
                              horizontal: 8,
                            ),
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
                                    String.fromCharCode(65 + i),
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

                      /// ✅ Explanation
                      if (hasAnswered || isResultMode) ...[
                        const SizedBox(height: 16),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8),
                          child: Text(
                            "Explanation: ${quiz.explanation}",
                            style: const TextStyle(
                              fontSize: 14,
                              fontStyle: FontStyle.italic,
                              color: Colors.teal,
                            ),
                          ),
                        ),
                      ],

                      const SizedBox(height: 20),

                      /// ✅ Navigation Buttons
                      if (!isResultMode)
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8),
                          child: Row(
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
                                    hasAnswered
                                        ? kMediumGreen2
                                        : Colors.grey.shade400,
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
                        ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      );
    });
  }
}
