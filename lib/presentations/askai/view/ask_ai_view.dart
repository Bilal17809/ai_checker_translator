
import 'package:flutter/material.dart';

class AskAiView extends StatefulWidget {
  const AskAiView({super.key});

  @override
  State<AskAiView> createState() => _AskAiViewState();
}

class _AskAiViewState extends State<AskAiView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text("Ask Ai"),
      ),
    );
  }
}