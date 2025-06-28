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
    final hight = MediaQuery.of(context).size.height;

    final args = Get.arguments ?? {};
    final String category = args['category'] ?? '';
    final String title = args['title'] ?? '';
    final int? catId = args['catId'];

    final String levelLabel = _extractLevelFromTitle(title);

    return SafeArea(
      child: Scaffold(
        // appBar: AppBar(
        //   title: Text(
        //     levelLabel.isNotEmpty
        //         ? '$category - Level $levelLabel'
        //         : "$category - $title",
        //     style: const TextStyle(color: Colors.white),
        //   ),
        //   backgroundColor: Colors.teal,
        // ),
        body: Obx(() {
          if (controller.isLoading.value) {
            return const Center(child: CircularProgressIndicator());
          }

          final quizzes = controller.quizzesList;
          if (quizzes.isEmpty) {
            return const Center(child: Text("No quizzes found"));
          }

          return Column(
            // crossAxisAlignment: CrossAxisAlignment.start,
            // mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Stack(
                children: [
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
                      padding: const EdgeInsets.symmetric(horizontal: 04),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Stack(
                            alignment: Alignment.center,
                            children: [
                              // Centered Title
                              const Center(
                                child: Text(
                                  "Noun",
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),

                              // Back Button on the left
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

                  Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 20,
                      vertical: 120,
                    ),
                    child: Stack(
                      clipBehavior: Clip.none,
                      children: [
                        // White card
                        Container(
                          width: double.infinity,
                          height: hight * 0.36,
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
                              BoxShadow(
                                color: Colors.grey.shade400,
                                blurRadius: 2,
                              ),
                            ],
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              const SizedBox(
                                height: 20,
                              ), // reserve space for yellow circle
                              const Text(
                                "Questions: 9/10",
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const SizedBox(height: 20),

                              const Text(
                                "What is Noun?",
                                style: TextStyle(
                                  fontSize: 20,
                                  color: Colors.black,
                                ),
                              ),
                              // const SizedBox(height: 12),
                              // ElevatedButton(
                              //   onPressed: () {},
                              //   child: const Text("Continue"),
                              // ),
                            ],
                          ),
                        ),

                        // Yellow circle positioned to overlap the card
                        Positioned(
                          top: -50,
                          left: 0,
                          right: 0,
                          child: Center(
                            child: Stack(
                              alignment: Alignment.center,
                              children: [
                                // Outer white circle
                                Container(
                                  height: 110,
                                  width: 110,
                                  decoration: const BoxDecoration(
                                    color: kWhite,
                                    shape: BoxShape.circle,
                                  ),
                                ),

                                // Circular progress indicator
                                SizedBox(
                                  height: 96,
                                  width: 96,
                                  child: CircularProgressIndicator(
                                    value: 0.9,
                                    strokeWidth: 8,
                                    backgroundColor: Colors.white,
                                    color: kMintGreen,
                                  ),
                                ),

                                // Percentage text in center
                                const Text(
                                  "09", // you can replace with dynamic text
                                  style: TextStyle(
                                    fontSize: 40,
                                    fontWeight: FontWeight.bold,
                                    color: kMintGreen,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),

                      ],
                    ),
                  ),

                ],
              ),



              // Expanded(
              //   child: PageView.builder(
              //     controller: _pageController,
              //     onPageChanged:
              //         (value) => controller.currentPage.value = value,
              //     itemCount: quizzes.length,
              //     itemBuilder: (context, index) {
              //       return QuizCard(
              //         index: index,
              //         onNext: () {
              //           if (index < controller.quizzesList.length - 1) {
              //             _pageController.nextPage(
              //               duration: const Duration(milliseconds: 300),
              //               curve: Curves.easeInOut,
              //             );
              //           } else {
              //             Get.offNamed(
              //               RoutesName.quizzesresultscreen,
              //               arguments: {
              //                 'score': controller.percentageScore,
              //                 'correct': controller.correctAnswersCount,
              //                 'total': controller.quizzesList.length,
              //                 'wrong':
              //                     controller.quizzesList.length -
              //                     controller.correctAnswersCount,
              //                 'catId': catId,
              //                 'category': category,
              //                 'title': title,
              //               },
              //             );
              //           }
              //         },
              //         onBack: () {
              //           if (index > 0) {
              //             _pageController.previousPage(
              //               duration: const Duration(milliseconds: 300),
              //               curve: Curves.easeInOut,
              //             );
              //           }
              //         },
              //       );
              //     },
              //   ),
              // ),
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
