import 'package:ai_checker_translator/core/theme/app_colors.dart';
import 'package:flutter/material.dart';

class RuleDetailScreen extends StatelessWidget {
  final String? title;
  final String? definition;
  const RuleDetailScreen({Key? key, this.title, this.definition})
    : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      
      appBar: AppBar(title: Text("Explanation",style: TextStyle(color: kWhite),),
      centerTitle: true,
      backgroundColor: kMintGreen,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 26),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title!,
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 10),
              SelectableText(definition!, style: const TextStyle(fontSize: 16)),
            ],
          ),
        ),
      ),
    );
  }
}
