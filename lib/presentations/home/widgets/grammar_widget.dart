
import 'package:ai_checker_translator/core/theme/app_colors.dart';
import 'package:ai_checker_translator/core/theme/app_styles.dart';
import 'package:ai_checker_translator/core/theme/app_theme.dart';
import 'package:ai_checker_translator/extension/extension.dart';
import 'package:ai_checker_translator/presentations/ai_translator/widgets/elevated_button.dart';
import 'package:flutter/material.dart';
import 'package:path/path.dart';

class GrammarWidget extends StatelessWidget {
  final String  titleone;
   final String titletwo;
  final  String icon;
  const GrammarWidget({super.key,required this.icon,required this.titleone,required this.titletwo});

  @override
  Widget build(BuildContext context) {
    final hiegt = MediaQuery.of(context).size.height;
    final Width = MediaQuery.of(context).size.height;
    return Container(
    height: hiegt * 0.20,
    decoration: roundedDecoration.copyWith(
      color: kMintGreen
    ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10,vertical: 10),
        child: Column(
          children: [
            Row(
              children: [
                //  Image.asset(icon),
                 Column(
                  children: [
                    Text(titleone,style: context.textTheme.bodyLarge!.copyWith(
                      color: kWhite,fontSize: 28
                    ),),
                    Text(titletwo)
                  ],
                 )
              ],
            ),
            // Spacer(),
          //  Align(
          //   alignment: Alignment.bottomRight,
          //    child: SizedBox(
             
          //      child: ElevatedButton(onPressed: (){
                  
          //      }, 
          //      style: AppTheme.elevatedButtonStyle.copyWith(
          //       backgroundColor: MaterialStateProperty.all(kWhite),
          //       // fixedSize: MaterialStateProperty.all(Size(Width * 0.16, hiegt * 0.10))
          //      ),
          //      child: Text("Let,s go",style: context.textTheme.titleSmall?.copyWith(
          //                             color: kBlack,fontSize: 18
          //                           ),
                                  
          //   textAlign: TextAlign.center,
          //   softWrap: false, 
          //   overflow: TextOverflow.ellipsis, 
          //                           )
          //      ),
          //    ),
          //  )
          ],
        ),
      ),
    );
  }
}