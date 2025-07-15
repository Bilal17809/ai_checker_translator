import 'dart:io';

import 'package:ai_checker_translator/core/common_widgets/no_internet_dialog.dart';
import 'package:ai_checker_translator/core/theme/app_colors.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:just_audio/just_audio.dart';
 


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
    ) async {
      bool isActuallyOnline = await isConnectedToInternet();
      if (!hasInternet.value && isActuallyOnline) {
        Utils().toastMessage("Your internet connection has been restored");
      }
      hasInternet.value = isActuallyOnline;
    });
  }

static Future<bool> isConnectedToInternet() async {
    try {
      final result = await InternetAddress.lookup('google.com');
      return result.isNotEmpty && result[0].rawAddress.isNotEmpty;
    } catch (_) {
      return false;
    }
  }

static Future<bool> checkAndShowNoInternetDialogIfOffline() async {
    final bool online = await isConnectedToInternet();
    if (!online) {
      Get.dialog(const NoInternetDialog(), barrierDismissible: false);
    }
    return online;
  }


  // static Future<void> playCorrectSound() async {
  //   await _player.stop();
  //   await _player.play(AssetSource('sounds/correctanswer.mp3'));
  // }
  //
  // static Future<void> playWrongSound() async {
  //   await _player.stop();
  //   await _player.play(AssetSource('sounds/wronganswer.mp3'));
  // }

  // It's good practice to ensure resources are disposed when no longer needed.
  // You might call this in a dispose method of your stateful widget or similar.
  static Future<void> playCorrectSound() async {
    // You can stop the player if it's currently playing something else
    await _player.stop();

    // Set the audio source from an asset
    await _player.setAudioSource(
      AudioSource.asset('assets/sounds/correctanswer.mp3'),
    );

    // Play the audio
    await _player.play();
  }
  static Future<void> playWrongSound() async {
    await _player.stop();
    await _player.setAudioSource(
      AudioSource.asset('assets/sounds/wronganswer.mp3'),
    );
    await _player.play();
  }

}
