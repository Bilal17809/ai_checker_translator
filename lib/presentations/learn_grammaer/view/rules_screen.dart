import 'package:ai_checker_translator/core/common_widgets/common_appbar_widget.dart';
import 'package:ai_checker_translator/core/common_widgets/life_cycle_mixin.dart';
import 'package:ai_checker_translator/core/theme/app_colors.dart';
import 'package:ai_checker_translator/core/theme/app_styles.dart';
import 'package:ai_checker_translator/presentations/quizzes_category_screen/controller/Categories_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class RulesScreen extends StatefulWidget {
  final int? catId;
  final String? content;

  // final int? catId;
  final int? ruleId;
  const RulesScreen({super.key, this.catId, this.content, this.ruleId});

  @override
  State<RulesScreen> createState() => _RulesScreenState();
}

class _RulesScreenState extends State<RulesScreen> with AppLifecycleMixin {
  final categoriesController = Get.find<CategoriesController>();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      categoriesController.fetchRulesByCategoryId(widget.catId ?? 0);
    });
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: true,
      onPopInvoked: (didPop) {
        if (!didPop) {
          Get.back(result: true);
        }
      },
      child: SafeArea(
        child: Scaffold(
          backgroundColor: kWhiteF7,
          appBar: CommonAppBar(appBarTitle: "Grammar Rules"),
          body: Obx(() {
            if (categoriesController.isLoading.value) {
              return const Center(child: CircularProgressIndicator());
            }

            return SingleChildScrollView(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  if (widget.content != null && widget.content!.isNotEmpty)
                    Padding(
                      padding: const EdgeInsets.only(bottom: 12),
                      child: Text(
                        widget.content!,
                        style: const TextStyle(fontSize: 16),
                      ),
                    ),

                  if (categoriesController.rulesList.isNotEmpty)
                    Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Other Rules",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                          ),
                        ),
                        Divider(thickness: 2),
                      ],
                    ),

                  ...categoriesController.rulesList.asMap().entries.map((
                    entry,
                  ) {
                    final index = entry.key;
                    final rule = entry.value;

                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        height: 70,
                        decoration: roundedDecoration,
                        child: Center(
                          child: ListTile(
                            trailing: const Icon(
                              Icons.arrow_forward_ios_outlined,
                              color: kMintGreen,
                              size: 20,
                            ),
                            leading: CircleAvatar(
                              maxRadius: 16,
                              backgroundColor: kMintGreen.withOpacity(0.08),
                              child:
                                  categoriesController.learnedMap[rule.catId]
                                              ?.contains(rule.ruleId) ??
                                          false
                                      ? Icon(
                                        Icons.done_all,
                                        color: kMintGreen,
                                        size: 16,
                                      )
                                      : Text(
                                        "${index + 1}",
                                        style: const TextStyle(
                                          color: kMintGreen,
                                          fontSize: 14,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                            ),
                            title: Text(
                              rule.titleOnly,
                              style: context.textTheme.bodyMedium!.copyWith(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            onTap: () {
                              categoriesController.goToRuleDetail(rule);
                            },
                          ),
                        ),
                      ),
                    );
                  }).toList(),

                  if (categoriesController.rulesList.isEmpty)
                    Obx(() {
                      final isLearned = categoriesController.contentLearned
                          .contains(widget.catId);

                      return Center(
                        child: ElevatedButton.icon(
                          style: ElevatedButton.styleFrom(
                            backgroundColor:
                                isLearned ? kMintGreen : Colors.grey,
                            foregroundColor: Colors.white,
                            padding: const EdgeInsets.symmetric(
                              horizontal: 20,
                              vertical: 18,
                            ),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(50),
                            ),
                          ),

                          label: Text("Learn it"),
                          icon: Icon(isLearned ? Icons.done_all : Icons.done),
                          onPressed: () {
                            final id = widget.catId ?? 0;

                            if (isLearned) {
                              categoriesController
                                  .unmarkCategoryContentAsLearned(id);
                            } else {
                              categoriesController.markCategoryContentAsLearned(
                                id,
                              );
                            }
                          },
                        ),
                      );
                    }),
                ],
              ),
            );
          }),
        ),
      ),
    );
  }
}
