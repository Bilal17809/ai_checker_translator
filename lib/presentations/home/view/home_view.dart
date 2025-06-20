
import 'package:ai_checker_translator/core/routes/routes_name.dart';
import 'package:ai_checker_translator/presentations/home/controller/menu_controller.dart';
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
      appBar: AppBar(
        title: Text("Home"),
        backgroundColor: Colors.teal,
      ),
      body: Obx(() {
        if (dbController.isLoading.value) {
          return Center(child: CircularProgressIndicator());
        }
        if (dbController.menuList.isEmpty) {
          return Center(child: Text("No data found"));
        }
        return ListView.builder(
          itemCount: dbController.menuList.length,
          itemBuilder: (context, index) {
            final item = dbController.menuList[index];
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 06),
              child: InkWell(
                onTap: () {
                  Get.toNamed(
                    RoutesName.paraphraseview,
                    arguments: {'id': item.id, 'menuname': item.name},
                  );

                  // categoriesController.fetchCategoriesData(item.id);

                  // categoriesController.fetchCategoriesData(item.id);
                },
                child: Card(
                  child: ListTile(
                    leading: CircleAvatar(child: Text(item.id.toString())),
                    title: Text(item.name),
                  ),
                ),
              ),
            );
          },
        );
      }),
    );
  }
}