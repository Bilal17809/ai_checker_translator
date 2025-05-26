import 'package:ai_checker_translator/gen/assets.gen.dart';
import 'package:ai_checker_translator/presentations/ai_translator/view/ai_translator_page.dart';
import 'package:ai_checker_translator/presentations/home/view/home_page.dart';
import 'package:flutter/material.dart';

class BottomNavExample extends StatefulWidget {
  const BottomNavExample({super.key});

  @override
  State<BottomNavExample> createState() => _BottomNavExampleState();
}

class _BottomNavExampleState extends State<BottomNavExample> {
  int selectedIndex = 0;

  final List<Widget> screens = [
    HomePage(),
    AiTranslatorPage(),
  ];

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
    return Scaffold(
      // backgroundColor: Colors.grey[200],
      body: IndexedStack(index: selectedIndex, children: screens),
      bottomNavigationBar: Container(
        margin: const EdgeInsets.only(left: 10, right: 10, bottom: 10),
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
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
                setState(() {
                  selectedIndex = index;
                });
              },
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  isSelected
                      ? ColorFiltered(
                        colorFilter: const ColorFilter.mode(
                          Colors.blue,
                          BlendMode.srcIn,
                        ),
                        child: Image.asset(
                          images[index],
                          height: 24,
                          width: 24,
                        ),
                      )
                      : Image.asset(images[index], height: 24, width: 24),

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
                        color: isSelected ? Colors.blue : Colors.grey,
                        fontWeight:
                            isSelected ? FontWeight.normal : FontWeight.normal,
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
