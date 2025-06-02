
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';

class Utils {

    void toastMessage(String msg){
      Fluttertoast.showToast(msg: msg,
     toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 5,
        backgroundColor:  const Color.fromARGB(255, 44, 43, 43),
        textColor: Colors.white,
        fontSize: 16.0 
      );

    }
   void snakBar(String title){
    Get.snackbar(
      "Error", title
      );
   }
}