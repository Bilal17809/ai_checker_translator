import 'package:ai_checker_translator/core/theme/app_styles.dart';
import 'package:ai_checker_translator/extension/extension.dart';
import 'package:flutter/material.dart';

class FeatureCardWidget extends StatelessWidget {
  final String image;
  final String title;
  final String? subtitle;
  final VoidCallback OnTap;
  

  const FeatureCardWidget({
    super.key,
    required this.image,
    required this.title,
    this.subtitle,
    required this.OnTap,
    
  });

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;

    return GestureDetector(
      onTap: OnTap,
      child: Container(
        width: width * 0.45,
        height: height * 0.26,
        padding: const EdgeInsets.all(16),
        decoration: rounBorderDecoration,
        child: Column(
          children: [
         
            Expanded(
              flex: 01,
              child: Image.asset(image, height: 50, fit: BoxFit.contain),
            ),
            const SizedBox(height: 04),
            Text(
              title,
              style: context.textTheme.bodySmall!.copyWith(
                fontWeight: FontWeight.bold,
                fontSize: 14
              ),
              textAlign: TextAlign.center,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
           
            if (subtitle != null && subtitle!.isNotEmpty) ...[
              Text(
                "(${subtitle!})",
                style: context.textTheme.bodySmall,
                textAlign: TextAlign.center,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ],
          ],
        ),
      ),
    );
  }
}




// class FeatureCardWidget extends StatelessWidget {
//   final String image;
//   final String title;
//   final String? subtitle;
//   final VoidCallback OnTap;

//   const FeatureCardWidget({
//     super.key,
//     required this.image,
//     required this.title,
//     this.subtitle,
//     required this.OnTap,
//   });

//   @override
//   Widget build(BuildContext context) {
//     final height = MediaQuery.of(context).size.height;
//     final width = MediaQuery.of(context).size.width;

//     return GestureDetector(
//       onTap: OnTap,
//       child: Container(
//         width: width * 0.45,
//         padding: const EdgeInsets.all(12),
//         height: height * 0.16,
//         decoration: roundedDecoration,
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             Flexible(
//               flex: 4,
//               child: Image.asset(image, height: 60, fit: BoxFit.contain),
//             ),
//             const SizedBox(height: 8),
//             Flexible(
//               flex: 3,
//               child: Text(
//                 title,
//                 style: context.textTheme.bodySmall!.copyWith(
//                   fontWeight: FontWeight.bold,
//                 ),
//                 textAlign: TextAlign.center,
//                 maxLines: 2,
//                 overflow: TextOverflow.ellipsis,
//               ),
//             ),
//             if (subtitle != null && subtitle!.isNotEmpty)
//               Flexible(
//                 flex: 3,
//                 child: Text(
//                   "($subtitle)",
//                   style: context.textTheme.bodySmall,
//                   textAlign: TextAlign.center,
//                   maxLines: 2,
//                   overflow: TextOverflow.ellipsis,
//                 ),
//               ),
//           ],
//         ),
//       ),
//     );
//   }
// }
