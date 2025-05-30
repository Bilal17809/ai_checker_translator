
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class elevatedButtons extends StatelessWidget {

  final String buttonTitle;
  Color? color;
  final VoidCallback onTap;
  
 elevatedButtons({super.key,required this.buttonTitle,required this.onTap,this.color});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ElevatedButton(
          style: ElevatedButton.styleFrom(
               backgroundColor: color
          ),
          child: Text(buttonTitle),
          onPressed: onTap,   
      ),
    );
  }
}