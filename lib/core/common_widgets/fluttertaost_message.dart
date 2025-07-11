
import 'package:ai_checker_translator/core/theme/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';

class Utils {

    void toastMessage(String msg){
      Fluttertoast.showToast(msg: msg,
     toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 5,
      backgroundColor: kMintGreen,
        textColor: Colors.white,
        fontSize: 16.0 
      );

    }
   void snakBar(String title){
    Get.snackbar(
      "Error", title
      );
   }
        
  static void copyTextFrom({required String? text}) {
    if (text == null || text.trim().isEmpty) return;
    Clipboard.setData(ClipboardData(text: text));
    Utils().toastMessage("Text copied successfully!");
  }



  static Color getColor({
    required double progress,
    required bool hasRules,
    required bool isContentLearned,
  }) {
    if (!hasRules) {
      return isContentLearned
          ? const Color(0xFF43A047)
          : Colors.grey.withOpacity(0.5);
    }
    final percent = (progress * 100).round();

    if (percent <= 25) {
      return const Color(0xFFE53935);
    } else if (percent <= 50) {
      return const Color(0xff18C184);
    } else if (percent <= 75) {
      return Colors.blue;
    } else {
      return const Color(0xFF43A047);
    }
  }

}