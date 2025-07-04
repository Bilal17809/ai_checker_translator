import 'package:flutter/material.dart';

class KeyboardDismissWrapper extends StatelessWidget {
  final Widget child;
  const KeyboardDismissWrapper({required this.child});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: child,
    );
  }
}
