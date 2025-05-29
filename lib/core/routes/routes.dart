import 'package:ai_checker_translator/bindings/bindings.dart';
import 'package:ai_checker_translator/presentations/ai_translator/view/ai_translator_page.dart';
import 'package:ai_checker_translator/presentations/ai_translator/view/curved_bottom_navbar.dart';
import 'package:ai_checker_translator/presentations/bottom_nav_bar/bottom_nav_bar.dart';
import 'package:ai_checker_translator/presentations/splash/view/splash_page.dart';
import 'package:get/get.dart';
import '../../presentations/home/view/home_page.dart';
import 'routes_name.dart';

class Routes {
  static List<GetPage> routes() => [
    GetPage(name: RoutesName.splashPage, page: () => SplashPage()),
    GetPage(name: RoutesName.homePage, page: () => HomePage()),
    GetPage(
      name: RoutesName.bottomnavbar,
      page: () => BottomNavExample(),
      binding: AllBindins(),
    ),
    GetPage(
      name: RoutesName.aitranslationpage,
      page: () => AiTranslatorPage(),
      binding: AllBindins(),
    ),
    GetPage(
      name: RoutesName.aiTranslatornavbar,
      page: () => AiTranslatorBottomNav(),
      binding: AllBindins(),
    ),
  ];
}
