import 'package:ai_checker_translator/core/common_widgets/common_appbar_widget.dart';
import 'package:ai_checker_translator/core/theme/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ai_checker_translator/presentations/quizzes_category_screen/controller/Categories_controller.dart';


class RuleDetailScreen extends StatelessWidget {
  final String? title;
  final String? definition;

  const RuleDetailScreen({Key? key, this.title, this.definition})
    : super(key: key);

  @override
  Widget build(BuildContext context) {
    final categoriesController = Get.find<CategoriesController>();
    final isLearned = RxBool(false);

    final rule = categoriesController.rulesList.firstWhereOrNull(
      (r) => r.titleOnly == title,
    );
    final ruleId = rule?.ruleId;
    final catId = rule?.catId;

    if (ruleId != null && catId != null) {
      isLearned.value =
          categoriesController.learnedMap[catId]?.contains(ruleId) ?? false;
    }

    return SafeArea(
      child: Scaffold(
        appBar: CommonAppBar(appBarTitle: "Explaination"),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 26),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title ?? '',
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 10),
                SelectableText(
                  definition ?? '',
                  style: const TextStyle(fontSize: 16),
                ),
                const SizedBox(height: 20),

                // ✅ Learn/Unlearn Toggle Button
                if (catId != null && ruleId != null)
                  Obx(
                    () => ElevatedButton.icon(
                      onPressed: () {
                        categoriesController.toggleLearnedRule(catId, ruleId);
                        isLearned.value = !isLearned.value;
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor:
                            isLearned.value ? kMintGreen : Colors.grey,
                        foregroundColor: Colors.white,
                      ),
                      icon: Icon(isLearned.value ? Icons.done_all : Icons.done),
                      label: Text("Learn it"),
                    ),
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
