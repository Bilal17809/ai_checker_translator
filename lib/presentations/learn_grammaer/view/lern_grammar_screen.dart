import 'package:ai_checker_translator/core/common_widgets/common_appbar_widget.dart';
import 'package:ai_checker_translator/core/common_widgets/fluttertaost_message.dart';
import 'package:ai_checker_translator/core/theme/app_colors.dart';
import 'package:ai_checker_translator/core/theme/app_styles.dart';
import 'package:ai_checker_translator/presentations/learn_grammaer/view/rules_screen.dart';
import 'package:ai_checker_translator/presentations/quizzes_category_screen/controller/Categories_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
// import 'package:get/get_core/get_core.dart';
// import 'package:get/get_state_manager/get_state_manager.dart';

class LearnGrammarScreen extends StatefulWidget {
  const LearnGrammarScreen({super.key});

  @override
  State<LearnGrammarScreen> createState() => _LernGrammarScreenState();
}

class _LernGrammarScreenState extends State<LearnGrammarScreen> {
  final categoriesController = Get.find<CategoriesController>();
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: kWhiteF7,
        appBar: CommonAppBar(appBarTitle: "Learn Grammar"),
        body: Obx(() {
          if (categoriesController.isLoading.value) {
            return Center(child: CircularProgressIndicator());
          }
          if (categoriesController.categoriesList.isEmpty) {
            return Center(child: Text("No data found"));
          }
          return ListView.builder(
            itemCount: categoriesController.categoriesList.length,
            itemBuilder: (context, index) {
              final data = categoriesController.categoriesList[index];
              return Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 20,
                  vertical: 04,
                ),
                child: Card(
                  color: kWhite,
                  elevation: 1,
                  child: InkWell(
                    onTap: () {
                      Get.to(
                        () => RulesScreen(
                          catId: data.catID,
                          content: data.content,
                        ),
                      );
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Obx(() {
                            final hasRules = categoriesController.rulesCountMap
                                .containsKey(data.catID);
                            final progress = categoriesController
                                .getProgressForCategory(data.catID ?? 0);
                            final isContentLearned = categoriesController
                                .isCategoryWithoutRulesLearned(data.catID ?? 0);

                            return Stack(
                              alignment: Alignment.center,
                              children: [
                                CircularProgressIndicator(
                                  value:
                                      categoriesController.rulesCountMap
                                              .containsKey(data.catID)
                                          ? progress
                                          : 1.0,
                                  strokeWidth: 4,
                                  backgroundColor: Colors.grey.withOpacity(0.2),
                                  valueColor: AlwaysStoppedAnimation<Color>(
                                    Utils.getColor(
                                      progress: progress,
                                      hasRules: hasRules,
                                      isContentLearned: isContentLearned,
                                    ),
                                  ),
                                ),
                                categoriesController.rulesCountMap.containsKey(
                                      data.catID,
                                    )
                                    ? Text(
                                      "${(progress * 100).toStringAsFixed(0)}%",
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: Utils.getColor(
                                          progress: progress,
                                          hasRules: hasRules,
                                          isContentLearned: isContentLearned,
                                        ),
                                      ),
                                    )
                                    : Icon(
                                      isContentLearned
                                          ? Icons.done_all
                                          : Icons.done,
                                      size: 18,
                                      color:
                                          isContentLearned
                                              ? Colors.green
                                              : Colors.grey,
                                    ),
                              ],
                            );
                          }),

                          const SizedBox(width: 16),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Text(
                                  data.catName,
                                  style: context.textTheme.bodyLarge,
                                ),
                                if (categoriesController.rulesCountMap
                                    .containsKey(data.catID))
                                  Text(
                                    "Learn 0/${categoriesController.rulesCountMap[data.catID]} tests",
                                    style: context.textTheme.bodySmall,
                                  ),
                              ],
                            ),
                          ),
                          const SizedBox(width: 10),
                          Icon(
                            Icons.arrow_forward_ios,
                            size: 20,
                            color: kMintGreen,
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
      ),
    );
    
  }
}
