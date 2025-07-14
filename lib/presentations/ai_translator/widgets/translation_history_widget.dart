import 'package:ai_checker_translator/gen/assets.gen.dart';
import 'package:ai_checker_translator/presentations/ai_translator/controller/translation_contrl.dart';
import 'package:ai_checker_translator/core/theme/app_colors.dart';
import 'package:ai_checker_translator/core/common_widgets/fluttertaost_message.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class TranslationHistoryWidget extends StatelessWidget {
  final bool showFavouriteIcon;
  final bool showOnlyFavourites;
  final bool deleteFromFavouritesOnly;
  final bool overrideSpeakAndCopy;
  final bool showSourceText; // ✅ New flag added

  TranslationHistoryWidget({
    super.key,
    this.showFavouriteIcon = true,
    this.showOnlyFavourites = false,
    this.deleteFromFavouritesOnly = false,
    this.overrideSpeakAndCopy = false,
    this.showSourceText = true, // ✅ default true
  });

  final TranslationController controller = Get.find();

  @override
  Widget build(BuildContext context) {
    final historyList =
        showOnlyFavourites
            ? controller.favouriteTranslations
            : controller.translationHistory;

    return Obx(() {
      if (historyList.isEmpty) {
        return Center(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Image.asset(
                  Assets.historyicon.path,
                  height: 50,
                  color: Colors.grey,
                ),
                const SizedBox(height: 10),
                const Center(
                  child: Text(
                    "No History Found!",
                    style: TextStyle(
                      color: Colors.grey,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      }

      return ListView.builder(
        shrinkWrap: true,
        physics: const BouncingScrollPhysics(),
        itemCount: historyList.length,
        itemBuilder: (context, index) {
          final item = historyList[index];
          final sourceText = item['source'] ?? "";
          final targetText = item['target'] ?? "";

          return Column(
            children: [
              Container(
                margin: const EdgeInsets.only(bottom: 14),
                decoration: BoxDecoration(
                  color: Colors.white,
                  border: Border.all(color: kMintGreen, width: 2),
                  borderRadius: BorderRadius.circular(10),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.0),
                      spreadRadius: 1,
                      blurRadius: 4,
                      offset: const Offset(0, 0),
                    ),
                  ],
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 10,
                    vertical: 10,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      if (showSourceText) ...[
                        Text(sourceText, style: const TextStyle(fontSize: 14)),
                        const Divider(),
                      ],
                      Text(targetText, style: const TextStyle(fontSize: 14)),
                      Align(
                        alignment: Alignment.bottomRight,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            if (showFavouriteIcon)
                              Obx(
                                () => IconButton(
                                  onPressed: () {
                                    if (controller.isFavourite(item)) {
                                      controller.removeFromFavourites(item);
                                      Utils().toastMessage(
                                        "Removed from Favourites",
                                      );
                                    } else {
                                      controller.addToFavourites(item);
                                      Utils().toastMessage(
                                        "Added to Favourites",
                                      );
                                    }
                                  },
                                  icon: Icon(
                                    controller.isFavourite(item)
                                        ? Icons.favorite_outlined
                                        : Icons.favorite_border,
                                    color:
                                        controller.isFavourite(item)
                                            ? Colors.red
                                            : kMintGreen,
                                  ),
                                ),
                              ),
                            IconButton(
                              onPressed: () {
                                if (overrideSpeakAndCopy) {
                                  final lines = targetText.split('\n');
                                  String actualTranslated =
                                      lines.length > 1
                                          ? lines.sublist(1).join('\n').trim()
                                          : targetText;

                                  if (actualTranslated.isNotEmpty) {
                                    controller.flutterTts.speak(
                                      actualTranslated,
                                    );
                                  }
                                } else {
                                  final translatedLines = targetText.split(
                                    '\n',
                                  );
                                  final actualTranslation =
                                      translatedLines.length > 1
                                          ? translatedLines
                                              .sublist(1)
                                              .join('\n')
                                          : targetText;

                                  controller.flutterTts.speak(
                                    actualTranslation.trim(),
                                  );
                                }
                              },
                              icon: const Icon(
                                Icons.volume_up,
                                color: kMintGreen,
                              ),
                            ),
                            IconButton(
                              onPressed: () {
                                final lines = targetText.split('\n');
                                String actualTranslated =
                                    lines.length > 1
                                        ? lines.sublist(1).join('\n').trim()
                                        : targetText;

                                Utils.copyTextFrom(text: actualTranslated);
                              },
                              icon: const Icon(Icons.copy, color: kMintGreen),
                            ),
                            IconButton(
                              onPressed: () {
                                if (deleteFromFavouritesOnly) {
                                  controller.deleteFromFavouritesOnly(item);
                                  Utils().toastMessage(
                                    "Removed from Favourites",
                                  );
                                } else {
                                  controller.deleteHistoryItem(index);
                                  Utils().toastMessage("Deleted from History");
                                }
                                controller.flutterTts.stop();
                              },
                              icon: const Icon(
                                Icons.delete,
                                color: kMintGreen,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          );
        },
      );
    });
  }
}
