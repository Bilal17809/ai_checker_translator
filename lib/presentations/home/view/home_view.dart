
import 'package:ai_checker_translator/core/common_widgets/common_appbar_widget.dart';
import 'package:ai_checker_translator/core/constant/constant.dart';
import 'package:ai_checker_translator/core/routes/routes_name.dart';
import 'package:ai_checker_translator/core/theme/app_colors.dart';
import 'package:ai_checker_translator/presentations/home/controller/menu_controller.dart';
import 'package:ai_checker_translator/presentations/home/widgets/grammar_widget.dart';
import 'package:ai_checker_translator/presentations/paraphrase/controller/Categories_controller.dart';
import 'package:ai_checker_translator/presentations/paraphrase/view/paraphrase_view.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/get_instance.dart';
import 'package:get/get_state_manager/get_state_manager.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  final dbController = Get.put(DbController());
  final categoriesController = Get.put(CategoriesController());

 
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kWhiteF7,
      appBar: CommonAppbarWidget(),
      drawer: Drawer(backgroundColor: kWhite),
      body: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: kBodyHp,
          vertical: kBodyHp,
        ),
        child: Column(
          children: [
            GrammarWidget(
              icon: "",
              titleone: "Boost Your learning",
              titletwo: "Learn Grammar by playing Games",
            ),
          ],
        ),
      ),
    );
  }
}

