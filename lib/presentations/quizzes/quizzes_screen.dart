import 'package:ai_checker_translator/core/routes/routes_name.dart';
import 'package:ai_checker_translator/core/theme/app_colors.dart';
import 'package:ai_checker_translator/presentations/quizzes_result/quizzes_result_screen.dart';
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
    final hight = MediaQuery.of(context).size.height;

    final args = Get.arguments ?? {};
    final String category = args['category'] ?? '';
    final String title = args['title'] ?? '';
    final int? catId = args['catId'];

    // final String levelLabel = _extractLevelFromTitle(title);

    return SafeArea(
      child: Scaffold(
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
              // Purple Header
              Container(
                height: hight * 0.34,
                decoration: const BoxDecoration(
                  color: kMintGreen,
                  borderRadius: BorderRadius.only(
                    bottomRight: Radius.circular(20),
                    bottomLeft: Radius.circular(20),
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 4),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Stack(
                        alignment: Alignment.center,
                        children: [
                          Center(
                            child: Text(
                              title,
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          Align(
                            alignment: Alignment.centerLeft,
                            child: IconButton(
                              onPressed: () {
                                Navigator.pop(context);
                              },
                              icon: const Icon(
                                Icons.arrow_back_ios_new_outlined,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),

              /// Overlapping Stack for Card + PageView
              Expanded(
                child: Stack(
                  clipBehavior: Clip.none,
                  children: [
                    Positioned(
                      top:
                          -MediaQuery.of(context).size.height *
                          0.24, // 50% overlap (adjust as needed)
                      left: 0,
                      right: 0,
                      bottom: 0,
                      child: PageView.builder(
                        controller: _pageController,
                        // physics:
                        //     (controller.currentPage.value <
                        //             controller.quizzesList.length)
                        //         ? (() {
                        //           final quiz =
                        //               controller.quizzesList[controller
                        //                   .currentPage
                        //                   .value];
                        //           final selected =
                        //               controller.selectedAnswers[quiz.quizID];
                        //           return selected == null
                        //               ? const NeverScrollableScrollPhysics()
                        //               : const AlwaysScrollableScrollPhysics();
                        //         })()
                        //         : const NeverScrollableScrollPhysics(),
                        // controller: _pageController,
                        onPageChanged:
                            (value) => controller.currentPage.value = value,
                        itemCount: quizzes.length,
                        itemBuilder: (context, index) {
                          return QuizCard(
                            index: index,
                            onNext: () {
                              try {
                                print('=== OnNext Debug Start ===');

                                // Debug controller state
                                print('Controller state:');
                                print(
                                  '  quizzesList: ${controller.quizzesList}',
                                );
                                print(
                                  '  quizzesList.length: ${controller.quizzesList?.length}',
                                );
                                print(
                                  '  currentPage: ${controller.currentPage}',
                                );
                                print(
                                  '  currentPage.value: ${controller.currentPage?.value}',
                                );
                                print(
                                  '  percentageScore: ${controller.percentageScore}',
                                );
                                print(
                                  '  correctAnswersCount: ${controller.correctAnswersCount}',
                                );

                                // Safe null checks
                                final quizzesList = controller.quizzesList;
                                final currentPageRx = controller.currentPage;

                                if (quizzesList == null) {
                                  print('ERROR: quizzesList is null!');
                                  Get.snackbar(
                                    'Error',
                                    'Quiz data is not available',
                                  );
                                  return;
                                }

                                if (currentPageRx == null) {
                                  print('ERROR: currentPage is null!');
                                  Get.snackbar(
                                    'Error',
                                    'Current page is not available',
                                  );
                                  return;
                                }

                                final total = quizzesList.length;
                                final current = currentPageRx.value;

                                print('Navigation values:');
                                print('  total: $total');
                                print('  current: $current');

                                if (current < total - 1) {
                                  print('Moving to next question...');
                                  // Move to next question
                                  _pageController.nextPage(
                                    duration: const Duration(
                                      milliseconds: 300,
                                    ),
                                    curve: Curves.easeInOut,
                                  );
                                }
                                else {
                                  final correct = controller.correctAnswersCount;
                                  final total = controller.quizzesList.length;
                                  final wrong = total - correct;
                                  final score = ((correct / total) * 100).toDouble();

                                  Get.off(() => QuizResultScreen(), arguments: {
                                    'score': score,
                                    'correct': correct,
                                    'wrong': wrong,
                                    'total': total,
                                    'catId': catId ?? 0,
                                    'title': title,
                                    'category': category,
                                  });
                                }


                              } catch (e, stackTrace) {
                                print('CRITICAL ERROR in onNext: $e');
                                print('Stack trace: $stackTrace');
                                Get.snackbar('Error', 'An error occurred: $e');
                              }
  
                              print('=== OnNext Debug End ===');
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
                ),
)

            ],
          );

        }),
      ),
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
