import 'package:flutter/material.dart';



enum TypingDirection { leftToRight, rightToLeft }

class AnimatedTypingText extends StatefulWidget {
  final String text;
  final Duration charDuration;
  final TextStyle? style;
  final ScrollController? scrollController;
  final TypingDirection direction;
  final TextAlign textAlign;
  final Curve curve;
  final VoidCallback? onComplete;

  const AnimatedTypingText({
    super.key,
    required this.text,
    this.charDuration = const Duration(milliseconds: 20),
    this.style,
    this.scrollController,
    this.direction = TypingDirection.leftToRight,
    this.textAlign = TextAlign.left,
    this.curve = Curves.easeOutCubic,
    this.onComplete,
  });

  @override
  State<AnimatedTypingText> createState() => _AnimatedTypingTextState();
}

class _AnimatedTypingTextState extends State<AnimatedTypingText>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<int> _characterCount;
  late Animation<double> _slideAnimation;
  late Animation<double> _fadeAnimation;

  @override
  void initState() {
    super.initState();
    _setupAnimation();
    _startAnimation();
  }

  void _setupAnimation() {
    final totalDuration = widget.charDuration * widget.text.length;
    _controller = AnimationController(duration: totalDuration, vsync: this);

    // Slide and fade animations
    _slideAnimation = Tween<double>(
      begin: widget.direction == TypingDirection.leftToRight ? -1.0 : 1.0,
      end: 0.0,
    ).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Interval(0.0, 0.5, curve: widget.curve),
      )
    );
    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Interval(0.0, 0.5, curve: widget.curve),
      ),
    );

    final begin =
        widget.direction == TypingDirection.leftToRight
            ? 0
            : widget.text.length;
    final end =
        widget.direction == TypingDirection.leftToRight
            ? widget.text.length
            : 0;

    _characterCount = StepTween(begin: begin, end: end).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Interval(0.3, 1.0, curve: widget.curve),
    )..addListener(() {
        setState(() {});
        WidgetsBinding.instance.addPostFrameCallback((_) {
          if (widget.scrollController?.hasClients ?? false) {
            try {
              widget.scrollController!.jumpTo(
                widget.scrollController!.position.maxScrollExtent,
              );
            } catch (_) {}
          }
        });
      }),
    );
    // Add completion handler
    _controller.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        widget.onComplete?.call();
      }
    });
  }

  void _startAnimation() {
    _controller.forward();
  }

  @override
  void didUpdateWidget(covariant AnimatedTypingText oldWidget) {
    super.didUpdateWidget(oldWidget);

    if (oldWidget.text != widget.text ||
        oldWidget.direction != widget.direction) {
      _controller.dispose();
      _setupAnimation();
      _startAnimation();
    }
  }

  @override
  Widget build(BuildContext context) {
    final visibleText =
        widget.direction == TypingDirection.leftToRight
            ? widget.text.substring(
              0,
              _characterCount.value.clamp(0, widget.text.length),
            )
            : widget.text.substring(
              _characterCount.value.clamp(0, widget.text.length),
            );

    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        final screenWidth = MediaQuery.of(context).size.width;
        final slideOffset = _slideAnimation.value * screenWidth * 0.3;

        return Transform.translate(
          offset: Offset(slideOffset.clamp(-screenWidth, screenWidth), 0),
          child: Opacity(
            opacity: _fadeAnimation.value.clamp(0.0, 1.0),
            child: Text(
              visibleText,
              style: widget.style,
              textAlign: widget.textAlign,
            ),
          ),
        );
      },
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}
