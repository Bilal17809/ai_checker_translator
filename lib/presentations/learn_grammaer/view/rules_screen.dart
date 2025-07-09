import 'package:ai_checker_translator/core/theme/app_colors.dart';
import 'package:ai_checker_translator/core/theme/app_styles.dart';
import 'package:ai_checker_translator/presentations/quizzes_category_screen/controller/Categories_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class RulesScreen extends StatefulWidget {
  final int? catId;
  final String? content;
  const RulesScreen({super.key, this.catId,this.content});

  @override
  State<RulesScreen> createState() => _RulesScreenState();
}

class _RulesScreenState extends State<RulesScreen> {
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
  return Scaffold(
    backgroundColor: kWhiteF7,
 appBar: AppBar(title: Text("Grammar Rules",style: TextStyle(color: kWhite),),
      centerTitle: true,
      backgroundColor: kMintGreen,
      ),
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
                  style: const TextStyle(fontSize: 16, ),
                ),
              ),

            
            if (categoriesController.rulesList.isNotEmpty)
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  
                  Text("Other Rules",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 18),),
                  Divider(thickness: 2,)
                ],
              ),
          
             ...categoriesController.rulesList.asMap().entries.map((entry) {
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
            backgroundColor:  kMintGreen.withOpacity(0.08),
            child: Text(
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
                  fontWeight: FontWeight.bold
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

          ],
        ),
      );
    }),
  );
}


}
