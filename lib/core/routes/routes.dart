import 'package:ai_checker_translator/presentations/ai_dictionary/view/ai_dictionary_page.dart';
import 'package:ai_checker_translator/presentations/ai_translator/view/ai_translator_page.dart';
import 'package:ai_checker_translator/presentations/ai_translator/view/curved_bottom_navbar.dart';
import 'package:ai_checker_translator/presentations/aska/view/ask_ai_screen.dart';
import 'package:ai_checker_translator/presentations/bottom_nav_bar/bottom_nav_bar.dart';
import 'package:ai_checker_translator/presentations/home/view/home_view.dart';
import 'package:ai_checker_translator/presentations/quizzes/quizzes_screen.dart';
import 'package:ai_checker_translator/presentations/paraphrase/view/paraphrase_view.dart';
import 'package:ai_checker_translator/presentations/quizdetail/view/quiz_detail_screen.dart';
import 'package:ai_checker_translator/presentations/quizzes_result/quizzes_result_screen.dart';
import 'package:ai_checker_translator/presentations/splash/view/splash_page.dart';
import 'package:get/get.dart';
import '../../presentations/Quiz_levels/view/quiz_level_screen.dart';
import '../bindings/bindings.dart';
import 'routes_name.dart';

class Routes {
  static List<GetPage> routes() => [
    GetPage(name: RoutesName.splashPage, page: () => SplashPage()),
    GetPage(
      name: RoutesName.homePage,
      page: () => HomeView(),
      binding: AllBindins(),
    ),
    GetPage(
      name: RoutesName.bottomNevBar,
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

    GetPage(
      name: RoutesName.askaiscreen,
      page: () => AskAiScreen(),
      binding: AllBindins(),
    ),

    GetPage(
      name: RoutesName.paraphraseview,
      page: () {
        final args = Get.arguments as Map<String, dynamic>? ?? {};
        return ParaphraseView(
          id: args['id'] ?? 0,
          menuname: args['menuname'] ?? '',
        );
      },
      binding: AllBindins(),
    ),

    GetPage(
      name: RoutesName.aidictionary,
      page: () => AiDictionaryPage(),
      binding: AllBindins(),
    ),

    GetPage(
      name: RoutesName.quizdetailscreen,
      page: () => QuizDetailScreen(quizID: Get.arguments as int),
      binding: AllBindins(),
    ),

    GetPage(
      name: RoutesName.quizdetailscreen,
      page: () => QuizLevelScreen(),
      binding: AllBindins(),
    ),

    GetPage(
      name: RoutesName.quizzesscreen,
      page: () => QuizzesScreen(),
      binding: AllBindins(),
    ),

    GetPage(
      name: RoutesName.quizzesresultscreen,
      page: () => QuizResultScreen(),
      binding: AllBindins(),
    ),
  ];
}
