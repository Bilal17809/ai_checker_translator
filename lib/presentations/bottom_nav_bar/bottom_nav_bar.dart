import 'package:ai_checker_translator/gen/assets.gen.dart';
import 'package:ai_checker_translator/presentations/ai_dictionary/view/ai_dictionary_page.dart';
import 'package:ai_checker_translator/presentations/ai_translator/view/curved_bottom_navbar.dart';
import 'package:ai_checker_translator/presentations/aska/view/ask_ai_screen.dart';
import 'package:ai_checker_translator/presentations/home/view/home_view.dart';
import 'package:ai_checker_translator/presentations/paraphrase/view/paraphrase_view.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class BottomNavExample extends StatefulWidget {
  const BottomNavExample({super.key});

  @override
  State<BottomNavExample> createState() => _BottomNavExampleState();
}

class _BottomNavExampleState extends State<BottomNavExample> {
  int selectedIndex = 2;
  int previousIndex = 3;
  Key animatedKey = UniqueKey();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  

  final List<String> images = [
    Assets.askai.path,
    Assets.paraphraser.path,
    Assets.home.path,
    Assets.correction.path,
    Assets.translator.path,
  ];

  final List<String> labels = [
    "Ask AI",
    "Paraphraser",
    "Home",
    "AI Correction",
    "Translator",
  ];

  @override
  Widget build(BuildContext context) {
    final bool isTranslatorPage = selectedIndex == 4;

    final List<Widget> screens = [
      AskAiScreen(key: animatedKey),
      ParaphraseView(),
      HomeView(),
      AiDictionaryPage(key: animatedKey),
      Container(),
    ];

    return Scaffold(
      body: IndexedStack(index: selectedIndex, children: screens),
      bottomNavigationBar:
          isTranslatorPage
              ? null
              : Container(
                margin: const EdgeInsets.only(left: 10, right: 10, bottom: 10),
                padding: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 10,
                ),
                decoration: BoxDecoration(
                  color: const Color(0xffF9DEDF),
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.2),
                      blurRadius: 6,
                      offset: const Offset(0, 6),
                    ),
                  ],
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: List.generate(images.length, (index) {
                    final isSelected = selectedIndex == index;
                    return GestureDetector(
                      onTap: () {
                        if (index == 4) {
                          Get.to(() => const AiTranslatorBottomNav())!.then((
                            _,
                          ) {
                            setState(() {
                              previousIndex = selectedIndex;
                              selectedIndex = 2;
                              if (previousIndex != 3 && selectedIndex == 3 ||
                                  previousIndex != 0 && selectedIndex == 0) {
                                animatedKey = UniqueKey();
                              }
                            });
                          });
                        } else {
                          if (selectedIndex != index) {
                            setState(() {
                              previousIndex = selectedIndex;
                              selectedIndex = index;

                              if (previousIndex != 3 && selectedIndex == 3 ||
                                  previousIndex != 0 && selectedIndex == 0) {
                                animatedKey = UniqueKey();
                              }
                            });
                          }

                        }
                      },
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          isSelected
                              ? ColorFiltered(
                                colorFilter: ColorFilter.mode(
                                  Color(0xFF006400),
                                  BlendMode.srcIn,
                                ),
                                child: Image.asset(
                                  images[index],
                                  height: isSelected ? 28 : 24,
                                  width: isSelected ? 28 : 24,
                                ),
                              )
                              : Image.asset(
                                images[index],
                                height: isSelected ? 28 : 24,
                                width: isSelected ? 28 : 24,
                              ),
                          const SizedBox(height: 4),
                          SizedBox(
                            width: 60,
                            child: Text(
                              labels[index],
                              overflow:
                                  isSelected
                                      ? TextOverflow.visible
                                      : TextOverflow.ellipsis,
                              maxLines: 1,
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: 12,
                                color:
                                    isSelected
                                        ? Color(0xFF006400)
                                        : Color(0xFF228B22),
                                fontWeight: FontWeight.normal,
                              ),
                            ),
                          ),
                        ],
                      ),
                    );
                  }),
                ),
              ),
    );
  }
}
