import 'package:flutter/material.dart';

class AnimatedTypingText extends StatefulWidget {
  final String text;
  final Duration charDuration;
  final TextStyle? style;

  const AnimatedTypingText({
    super.key,
    required this.text,
    this.charDuration = const Duration(milliseconds: 50),
    this.style,
  });

  @override
  State<AnimatedTypingText> createState() => _AnimatedTypingTextState();
}

class _AnimatedTypingTextState extends State<AnimatedTypingText>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<int> _characterCount;

  @override
  void initState() {
    super.initState();

    final totalDuration = widget.charDuration * widget.text.length;

    _controller = AnimationController(duration: totalDuration, vsync: this);

    _characterCount = StepTween(
      begin: 0,
      end: widget.text.length,
    ).animate(_controller)..addListener(() {
      setState(() {});
    });

    _controller.forward();
  }

  @override
  void didUpdateWidget(covariant AnimatedTypingText oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.text != widget.text) {
      _controller.reset();
      _characterCount = StepTween(
        begin: 0,
        end: widget.text.length,
      ).animate(_controller);
      _controller.forward();
    }
  }

  @override
  Widget build(BuildContext context) {
    final visibleText = widget.text.substring(
      0,
      _characterCount.value.clamp(0, widget.text.length),
    );
    return Text(visibleText, style: widget.style);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}
