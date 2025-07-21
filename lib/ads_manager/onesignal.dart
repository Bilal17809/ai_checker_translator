import 'dart:io';
import 'package:onesignal_flutter/onesignal_flutter.dart';

void initializeOneSignal() {
  OneSignal.Debug.setLogLevel(OSLogLevel.verbose);
  if (Platform.isAndroid) {
    OneSignal.initialize("d87996b7-d0b0-4a02-bd67-c0ed5bc9683e");
    OneSignal.Notifications.requestPermission(true);
  } else if (Platform.isIOS) {
    OneSignal.initialize("0a861af3-75dc-41f2-896e-cf8220fdd94a");
    OneSignal.Notifications.requestPermission(true);
  } else {
    print("Unsupported platform for OneSignal");
  }
}