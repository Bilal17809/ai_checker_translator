import 'package:ai_checker_translator/core/bindings/bindings.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import '/core/theme/app_theme.dart';
import 'package:flutter/material.dart';
import 'core/routes/routes.dart';
import 'core/routes/routes_name.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: AppTheme.themeData,
      initialRoute: RoutesName.splashPage,
       getPages: Routes.routes(),
      initialBinding: AllBindins(), 
    );
  }
}
