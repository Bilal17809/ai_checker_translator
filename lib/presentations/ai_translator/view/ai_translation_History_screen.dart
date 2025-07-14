
import 'package:ai_checker_translator/core/theme/app_colors.dart';
import 'package:ai_checker_translator/presentations/ai_translator/widgets/translation_history_widget.dart';
import 'package:flutter/material.dart';

class AiTranslationHistoryScreen extends StatefulWidget {
  const AiTranslationHistoryScreen({super.key});

  @override
  State<AiTranslationHistoryScreen> createState() => _AiTranslationHistoryScreenState();
}

class _AiTranslationHistoryScreenState extends State<AiTranslationHistoryScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: kWhite),
        backgroundColor: kMintGreen,
        title: Text("Favourite",style: TextStyle(color: kWhite),),
      ),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20,vertical: 20),
          child: SingleChildScrollView(
            child: Column(
              children: [
                
              TranslationHistoryWidget(
  showFavouriteIcon: true,
  showOnlyFavourites: true,
  deleteFromFavouritesOnly: true,
  overrideSpeakAndCopy: false,
  showSourceText: true, 
),

              ],
            ),
          ),
        ),
    );
  }
}