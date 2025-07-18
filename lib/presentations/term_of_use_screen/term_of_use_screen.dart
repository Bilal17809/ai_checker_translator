import 'package:ai_checker_translator/core/theme/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get_utils/src/extensions/export.dart';

class TermOfUseScreen extends StatefulWidget {
  const TermOfUseScreen({super.key});

  @override
  State<TermOfUseScreen> createState() => _TermOfUseScreenState();
}

class _TermOfUseScreenState extends State<TermOfUseScreen> {
  @override
  Widget build(BuildContext context) {
    final hiegt = MediaQuery.of(context).size.height;
    return SafeArea(
      child: Scaffold(
        body: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: hiegt * 0.20,
              width: double.infinity,
              
              decoration: BoxDecoration(
                gradient: kGradient
              ),
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Welcome to AI Checker Translator:",style: context.textTheme.bodyLarge!.copyWith(
                 color: kWhite,
                 fontWeight: FontWeight.bold,
                 fontSize: 16
                    ),),
                    SizedBox(height: 10),
                    Text("An all-in-one AI-powered app for translation, grammar correction, English learning, and quizzes.",style: context.textTheme.bodyMedium!.copyWith(
                 color: kWhite,
                 fontWeight: FontWeight.bold,
                 fontSize: 12
                    ),),
                  ],
                ),
              )
            ),
             Padding(
               padding: const EdgeInsets.symmetric(horizontal: 10,vertical: 10),
               child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                 children: [
                   Text("Ai Checker Translator - features overview",style: context.textTheme.bodyLarge!.copyWith(
                 color:  kBlack,
                 fontWeight: FontWeight.bold,
                 fontSize: 16
                    ),),
                    SizedBox(height: 10),
                   Row(
                     children: [
                         Icon(Icons.done,color: kMintGreen,),
                         SizedBox(width: 10,),
                       Text("Free Features",style: context.textTheme.bodyLarge!.copyWith(
                        fontWeight: FontWeight.bold
                       ),),
                     ],
                   ),
                   SizedBox(height: 10),
                   _showfeatures(featuresTitle: "Text Translator - translate text between multiple languages."),
                    SizedBox(height: 16),
                   _showfeatures(featuresTitle: "English Grammar learning - Explore essential grammar rules."),
                   SizedBox(height: 16),
                   _showfeatures(featuresTitle: "Grammar Quizzes - Practice with daily quiz questions."),
                     SizedBox(height: 20),
                     Row(
                     children: [
                         Icon(Icons.diamond,color: kBlue,),
                         SizedBox(width: 10,),
                       Text("Premium Features",style: context.textTheme.bodyLarge!.copyWith(
                        fontWeight: FontWeight.bold,
                      
                       ),),
                     ],
                   ),
                     SizedBox(height: 10),
                   _showfeatures(featuresTitle: "AI Grammar Correction Tool – Correct your sentences with precision using AI."),
                    SizedBox(height: 16),
                    _showfeatures(featuresTitle: "AI Assistant – Ask anything and get smart AI-powered answers. (Daily Limit)"),


                       SizedBox(height: 20), 
                     Text("Please note",style: context.textTheme.bodyLarge!.copyWith(
                        fontWeight: FontWeight.bold,
                      
                       ),),
                        Text("- Grammar Correction Tool is available only in the Premium plan and daily limit.",style: context.textTheme.bodyMedium!.copyWith(
                        // fontSize: 16
                      
                       ),),
                    //  Text("Feedback and ")
                 ],
               ),
             )
          ],
        ),
      ),
    );
  }
}

class _showfeatures extends StatelessWidget {
  final String featuresTitle;
  const _showfeatures({super.key,required this.featuresTitle});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
       CircleAvatar(
        maxRadius: 18,
        backgroundColor: kMintGreen.withOpacity(0.12),
      child: Center(
        child: Icon(Icons.done_all,color: kMintGreen,size: 20,),
      ),
       ),
       SizedBox(width: 10),
       Expanded(child: Text(featuresTitle,style: context.textTheme.bodyMedium,
       maxLines: 2,
       ))
      ],
    );
  }
}
