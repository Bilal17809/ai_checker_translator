import 'dart:io';

import 'package:ai_checker_translator/core/common_widgets/no_internet_dialog.dart';
import 'package:ai_checker_translator/core/theme/app_colors.dart';
import 'package:ai_checker_translator/gen/assets.gen.dart';
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
      Get.dialog(
        CustomInfoDialog(
          title: "No Internet Connection",
          message: "An internet connection is required. Please try again.",
          iconPath: Assets.nointernet.path,
          type: DialogType.internet,
        ),
        barrierDismissible: false,
      );
    }
    return online;
  }

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

  static String buildTTSUrl({
    required String text,
    required String langCode,
    required double speed,
    required double pitch,
  }) {
    final encoded = Uri.encodeComponent(text);
    return 'https://translate.google.com/translate_tts?ie=UTF-8'
        '&client=tw-ob'
        '&q=$encoded'
        '&tl=$langCode'
        '&ttsspeed=$speed'
        '&pitch=$pitch';
  }

  static List<String> splitText(String text, int maxLength) {
    final words = text.split(' ');
    final chunks = <String>[];
    var buffer = StringBuffer();

    for (final word in words) {
      if ((buffer.length + word.length + 1) < maxLength) {
        buffer.write('$word ');
      } else {
        chunks.add(buffer.toString().trim());
        buffer.clear();
        buffer.write('$word ');
      }
    }

    if (buffer.isNotEmpty) {
      chunks.add(buffer.toString().trim());
    }

    return chunks;
  }

  static String getFlagEmoji(String countryCode) {
    return countryCode.toUpperCase().codeUnits.map((char) {
      return String.fromCharCode(char + 127397);
    }).join();
  }

  static const MethodChannel _methodChannel = MethodChannel(
    'com.modernschool.aigrammar.learnenglish/speech_Text',
  );

  static Future<String?> startListening({
    required String languageISO,
    required RxBool isListening,
  }) async {
    try {
      isListening.value = true;

      final result = await _methodChannel.invokeMethod('getTextFromSpeech', {
        'languageISO': languageISO,
      });

      return result;
    } on PlatformException catch (e) {
      print("Error in Speech-to-Text: ${e.message}");
      return null;
    } finally {
      isListening.value = false;
    }
  }

  static String limitLines(String text, int maxLines) {
    final lines = text.split('\n');
    if (lines.length <= maxLines) return text;
    return lines.take(maxLines).join('\n');
  }

  static String limitCharacters(String text, int maxChars) {
    if (text.length <= maxChars) return text;
    return text.substring(0, maxChars).trim() + '...';
  }
}


