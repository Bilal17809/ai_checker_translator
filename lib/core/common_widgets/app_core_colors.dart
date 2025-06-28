import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
class GreenCircleDecoration extends StatelessWidget {
  const GreenCircleDecoration({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Positioned(
          top: -150,
          left: -100,
          child: Container(
            width: 400,
            height: 350,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              gradient: const LinearGradient(
                begin: Alignment.topRight,
                end: Alignment.bottomLeft,
                colors: [
                  Color(0xFF43A047), // Dark green
                  Color(0xFF81C784), // Light green
                ],
              ),
            ),
          ),
        ),

        Positioned(
          top: -150,
          right: -80,
          child: Container(
            width: 320,
            height: 350,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              gradient: const LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomLeft,
                colors: [
                  Color(0xFF81C784),
                  Color(0xFF388E3C),
                ],
              ),
            ),
          ),
        ),
      ],
    );

  }
}

