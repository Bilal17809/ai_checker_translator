
import 'package:flutter/material.dart';
import 'package:ai_checker_translator/presentations/bottom_nav_bar/bottom_nav_bar.dart';

class BackToHomeWrapper extends StatelessWidget {
  final Widget child;

  const BackToHomeWrapper({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        FocusScope.of(context).unfocus(); 
        BottomNavExample.bottomNavKey.currentState?.goToHome();
        return true;
      },
      child: child,
    );
  }
}
