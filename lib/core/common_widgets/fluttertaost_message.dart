
import 'package:ai_checker_translator/core/common_widgets/no_internet_dialog.dart';
import 'package:ai_checker_translator/core/theme/app_colors.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
 


class Utils {

  static final AudioPlayer _player = AudioPlayer();

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



  static final RxBool hasInternet = true.obs;

  static void monitorInternet() {
    Connectivity().onConnectivityChanged.listen((
      List<ConnectivityResult> results,
    ) {
      bool isConnected =
          results.isNotEmpty && !results.contains(ConnectivityResult.none);

      if (!hasInternet.value && isConnected) {
        Utils().toastMessage("Your internet connection has been restored");
      }
      hasInternet.value = isConnected;
    });
  }

  static Future<bool> isConnectedToInternet() async {
    final results = await Connectivity().checkConnectivity();
    return results.isNotEmpty && !results.contains(ConnectivityResult.none);
  }

  static Future<bool> checkAndShowNoInternetDialogIfOffline() async {
    final bool hasInternet = await Utils.isConnectedToInternet();
    if (!hasInternet) {
      Get.dialog(const NoInternetDialog(), barrierDismissible: false);
    }
    return hasInternet;
  }

  static Future<void> playCorrectSound() async {
    await _player.stop();
    await _player.play(AssetSource('sounds/correctanswer.mp3'));
  }

  static Future<void> playWrongSound() async {
    await _player.stop();
    await _player.play(AssetSource('sounds/wronganswer.mp3'));
  }
   

}