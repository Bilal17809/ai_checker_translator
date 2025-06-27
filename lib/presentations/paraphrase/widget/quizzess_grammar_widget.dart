
import 'package:flutter/material.dart';

class QuizzessGrammarWidget extends StatelessWidget {
  final String grammarTitle;
  final String quizNumber;
  final VoidCallback onTap;
  const QuizzessGrammarWidget({super.key,required this.grammarTitle,required this.quizNumber,required this.onTap});

  @override
  Widget build(BuildContext context) {
    final hieght = MediaQuery.of(context).size.height;
    return InkWell(
      onTap: onTap,
      child: Container(
        height: hieght * 0.36,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
            BoxShadow(
              color: Colors.grey,
              // offset: Offset(0,),
              blurRadius: 1,
            ),
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Spacer(),
            Center(
              child: Text(
                grammarTitle,
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
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
                    color: Colors.grey[300],
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Center(child: Text(quizNumber)),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}