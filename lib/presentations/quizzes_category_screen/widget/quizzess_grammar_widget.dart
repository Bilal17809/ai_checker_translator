
import 'package:ai_checker_translator/core/theme/app_colors.dart';
import 'package:ai_checker_translator/core/theme/app_styles.dart';
import 'package:ai_checker_translator/extension/extension.dart';
import 'package:flutter/material.dart';

class QuizzessGrammarWidget extends StatelessWidget {
  final String grammarTitle;
  final String quizNumber;
  final VoidCallback onTap;
  final String icon;
  const QuizzessGrammarWidget({
    super.key,
    required this.grammarTitle,
    required this.quizNumber,
    required this.onTap,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    final hieght = MediaQuery.of(context).size.height;
    return InkWell(
      onTap: onTap,
      child: Container(
        height: hieght * 0.40,
        decoration: roundedDecoration.copyWith(
          color: kWhite.withValues(alpha: 0.8),
        ),
        
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Spacer(),
            CircleAvatar(
              radius: 28,
              backgroundColor: kMintGreen.withOpacity(0.08),
              child: SizedBox(
                height: 28,
                width: 28,
                child: Image.asset(icon, fit: BoxFit.cover, color: kMintGreen),
              ),
            ),
            Spacer(),
            Center(
              child: Text(
                grammarTitle,
                style: context.textTheme.titleLarge?.copyWith(
                  color: kBlack,
                  fontSize: 18,
                ),
                textAlign: TextAlign.center,
              ),
            ),
            Spacer(),
            Align(
              alignment: Alignment.bottomCenter,
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 24,
                  vertical: 10,
                ),
                child: Container(
                  height: hieght * 0.03,
                  decoration: BoxDecoration(
                    color: kMintGreen.withOpacity(0.8),
                    borderRadius: BorderRadius.circular(24),
                  ),
                  child: Center(
                    child: Text(quizNumber, style: TextStyle(color: kWhite)),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}