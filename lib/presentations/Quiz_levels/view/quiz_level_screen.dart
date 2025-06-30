import 'package:ai_checker_translator/core/theme/app_colors.dart';
import 'package:ai_checker_translator/core/theme/app_styles.dart';
import 'package:ai_checker_translator/presentations/Quiz_levels/controller/quizzeslevel_controller.dart';
import 'package:ai_checker_translator/presentations/paraphrase/controller/Categories_controller.dart';
import 'package:ai_checker_translator/presentations/paraphrase/model/grammarcategory_model.dart';
import 'package:ai_checker_translator/presentations/quizdetail/controller/quiz_detail_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../core/common_widgets/app_core_colors.dart';
import '../../../core/common_widgets/icon_buttons.dart';
import '../../../core/constant/constant.dart';

class QuizLevelScreen extends StatefulWidget {
  const QuizLevelScreen({super.key});

  @override
  State<QuizLevelScreen> createState() => _QuizLevelScreenState();
}

class _QuizLevelScreenState extends State<QuizLevelScreen> {

  late final GrammarCategoryModel category;
  final quizzeslevelController = Get.find<QuizzeslevelController>();
  final categoriesController = Get.find<CategoriesController>();
  final QuizDetailController controller = Get.put(QuizDetailController());

  @override
  void initState() {
    super.initState();
    category = Get.arguments as GrammarCategoryModel;

    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (quizzeslevelController.selectedCategory.value !=
          category.title.trim()) {
        quizzeslevelController.fetchLevelsByCategory(category.title.trim());
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final String categoryTitle = category.title.trim();

    return Scaffold(
   
      // appBar: AppBar(
      //   centerTitle: true,
      //   backgroundColor: Colors.teal,
      //   title: Row(
      //       mainAxisSize: MainAxisSize.min,
      //       children: [
      //         Text(
      //           categoryTitle,
      //           style: const TextStyle(fontSize: 18, color: Colors.white),
      //         ),
      //         const SizedBox(width: 8),
      //       ],
      //     ),
      //
      //   actions: [
      //     IconButton(
      //       icon: const Icon(Icons.refresh),
      //       onPressed: () => quizzeslevelController.refreshData(),
      //     ),
      //   ],
      // ),
      /*
      create appbar widget use it every where.
      */
      body: Stack(
        children: [
          const GreenCircleDecoration(),
          Positioned(
            top: 40,
            left: 20,
            right: 16,
            child: SizedBox(
              width: double.infinity,
              child: Stack(
                alignment: Alignment.center,
                children: [
                  Align(
                    alignment: Alignment.centerLeft,
                    child: BackIconButton(),
                  ),
                  Center(
                    child: Text(
                      categoryTitle,
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.w600,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Obx(() {
            if (quizzeslevelController.isLoading.value) {
              return const Center(child: CircularProgressIndicator());
            }

            if (quizzeslevelController.filteredCategoriesList.isEmpty) {
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("No levels found for $categoryTitle"),
                    const SizedBox(height: 16),
                    ElevatedButton(
                      onPressed: () => quizzeslevelController.refreshData(),
                      child: const Text("Retry"),
                    ),
                  ],
                ),
              );
            }

            return  ListView.builder(
              padding:  EdgeInsets.only(top:120, left: 10, right:10),
              itemCount: quizzeslevelController.filteredCategoriesList.length,
              itemBuilder: (context, index) {
                final item = quizzeslevelController.filteredCategoriesList[index];
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: kBodyHp,vertical:10),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(16),
                    child:GestureDetector(
                      onTap: () async {
                        controller.resetQuiz();
                        final catId = item.catID;
                        if (catId != null) {
                          await controller.fetchQuizzesByCategoryId(catId);
                          Get.toNamed(
                            '/quizzes_scren',
                            arguments: {
                              'title': item.catName,
                              'category': category.title.trim(),
                              'catId': catId,
                            },
                          );
                        }
                      },
                      child: Container(
                        decoration: roundedDecoration.copyWith(
                          color:
                          Color(0xFF388E3C).withOpacity(0.9)
                          //const Color(0xFF4CAF50).withOpacity(0.9),
                        ),
                        child: Stack(
                          children: [
                            Positioned(
                              top: -30,
                              left: -40,
                              child: Container(
                                width: 80,
                                height: 80,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  gradient: RadialGradient(
                                    colors: [
                                      const Color(0xff00AB3F).withOpacity(0.5),
                                      Colors.transparent,
                                    ],
                                    radius: 0.6,
                                  ),
                                ),
                              ),
                            ),
                            // Background circle 2
                            Positioned(
                              top:70,
                              right:145,
                              child: Container(
                                width:27,
                                height:27,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color:Color(0xffFFBB00).withOpacity(0.5)
                                ),
                              ),
                            ),
                            Positioned(
                              top:70,
                              right:130,
                              child: Container(
                                width:27,
                                height:27,
                                decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    color:Color(0xffFF7F50).withOpacity(0.5)
                                ),
                              ),
                            ),
                            Positioned(
                              top:70,
                              right:110,
                              child: Container(
                                width:27,
                                height:27,
                                decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    color:Color(0xFF2E7D32).withOpacity(0.5)
                                ),
                              ),
                            ),
                            Positioned(
                              bottom: -20,
                              right: -30,
                              child: Container(
                                width: 100,
                                height: 100,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  gradient: RadialGradient(
                                    colors: [
                                      const Color(0xFF66BB6A).withOpacity(0.4),
                                      Colors.transparent,
                                    ],
                                    radius: 0.5,
                                  ),
                                ),
                              ),
                            ),
                            Positioned(
                              top:2,
                              right: 12,
                              bottom:2,
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(12),
                                child: Image.asset(
                                  "assets/icons/level-1.png",
                                  width: 110,
                                  height: 100,
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),

                            Padding(
                              padding: EdgeInsets.symmetric(horizontal:kBodyHp, vertical:kBodyHp),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Text(
                                    item.catName ?? '',
                                    style:context.textTheme.titleSmall?.copyWith(
                                      color: kWhite,
                                    )
                                  ),
                                  const SizedBox(height: 12),
                                  _Progress(),
                                  const SizedBox(height: 12),
                                   Text(
                                    "Total Questions: 10",
                                      style:context.textTheme.bodySmall?.copyWith(
                                  color: kWhite
                                  )
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                );
              },
            );
          }),
        ],
      ),
    );
  }
}


class _Progress extends StatelessWidget {
  const _Progress({super.key});

  @override
  Widget build(BuildContext context) {
    return  Container(
      width: 140,
      height: 10,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(4),
        color: Colors.white30,
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(4),
        child: LinearProgressIndicator(
          value: 0.5,
          backgroundColor: Colors.transparent,
          color: kYellow.withOpacity(0.8),
        ),
      ),
    );
  }
}

