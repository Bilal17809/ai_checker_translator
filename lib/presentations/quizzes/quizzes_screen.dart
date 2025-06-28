import 'package:ai_checker_translator/core/routes/routes_name.dart';
import 'package:ai_checker_translator/core/theme/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:ai_checker_translator/presentations/quizdetail/controller/quiz_detail_controller.dart';
import 'package:ai_checker_translator/presentations/quizzes/widgets/quizzes_card.dart';

class QuizzesScreen extends StatefulWidget {
  QuizzesScreen({super.key});

  @override
  State<QuizzesScreen> createState() => _QuizzesScreenState();
}

class _QuizzesScreenState extends State<QuizzesScreen> {
  final QuizDetailController controller = Get.find<QuizDetailController>();

  final PageController _pageController = PageController();

  @override
  Widget build(BuildContext context) {
    final args = Get.arguments ?? {};
    final String category = args['category'] ?? '';
    final String title = args['title'] ?? '';
    final int? catId = args['catId'];

    final String levelLabel = _extractLevelFromTitle(title);

    return Scaffold(
      appBar: AppBar(
        title: Text(
          levelLabel.isNotEmpty
              ? '$category - Level $levelLabel'
              : "$category - $title",
          style: const TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.teal,
      ),
      body: Obx(() {
        if (controller.isLoading.value) {
          return const Center(child: CircularProgressIndicator());
        }

        final quizzes = controller.quizzesList;
        if (quizzes.isEmpty) {
          return const Center(child: Text("No quizzes found"));
        }

        return Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              child: Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 10,
                  vertical: 12,
                ),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black12,
                      blurRadius: 6,
                      offset: Offset(0, 3),
                    ),
                  ],
                ),
                child: Row(
                  // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SmoothPageIndicator(
                      controller: _pageController,
                      count: quizzes.length,
                      effect: const WormEffect(
                        dotHeight: 10,
                        dotWidth: 18,
                        activeDotColor: kMediumGreen2,
                      ),
                    ),
                    const SizedBox(width: 10),
                    Obx(() {
                      final total = controller.quizzesList.length;
                      final current = controller.currentPage.value + 1;
                      return Text(
                        "$current/$total",
                        style: const TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w600,
                        ),
                      );
                    }),
                  ],
                ),
              ),
            ),

            Expanded(
              child: PageView.builder(
                controller: _pageController,
                onPageChanged: (value) => controller.currentPage.value = value,
                itemCount: quizzes.length,
                itemBuilder: (context, index) {
                  return QuizCard(
                    index: index,
                    onNext: () {
                      if (index < controller.quizzesList.length - 1) {
                        _pageController.nextPage(
                          duration: const Duration(milliseconds: 300),
                          curve: Curves.easeInOut,
                        );
                      } else {
                        Get.offNamed(
                          RoutesName.quizzesresultscreen,
                          arguments: {
                            'score': controller.percentageScore,
                            'correct': controller.correctAnswersCount,
                            'total': controller.quizzesList.length,
                            'wrong':
                                controller.quizzesList.length -
                                controller.correctAnswersCount,
                            'catId': catId,
                            'category': category,
                            'title': title,
                          },
                        );
                      }
                    },
                    onBack: () {
                      if (index > 0) {
                        _pageController.previousPage(
                          duration: const Duration(milliseconds: 300),
                          curve: Curves.easeInOut,
                        );
                      }
                    },
                  );
                },
              ),
            ),
          ],
        );
      }),
    );
  }

  String _extractLevelFromTitle(String title) {
    final name = title.toLowerCase();
    if (name.contains('level a')) return 'A';
    if (name.contains('level b')) return 'B';
    if (name.contains('level c')) return 'C';
    return '';
  }
}
