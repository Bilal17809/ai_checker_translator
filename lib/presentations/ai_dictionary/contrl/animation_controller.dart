import 'package:flutter/material.dart';


/*
>>>>>>>>>>>>>>> improve <<<<<<<<<<<<<<<<<<<
create the animation in core all animation over
there you need just call here try it must!
*/

enum TypingDirection { leftToRight, rightToLeft }

class AnimatedTypingText extends StatefulWidget {
  final String text;
  final Duration charDuration;
  final TextStyle? style;
  final ScrollController? scrollController;
  final TypingDirection direction;
  final TextAlign textAlign;
  final Curve curve;

  const AnimatedTypingText({
    super.key,
    required this.text,
    this.charDuration = const Duration(milliseconds: 50),
    this.style,
    this.scrollController,
    this.direction = TypingDirection.leftToRight,
    this.textAlign = TextAlign.left,
    this.curve = Curves.easeOutCubic,
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

    final totalDuration = widget.charDuration * widget.text.length;
    _controller = AnimationController(duration: totalDuration, vsync: this);

    // Create animations with side appearance
    _slideAnimation = Tween<double>(
      begin: widget.direction == TypingDirection.leftToRight ? -1.0 : 1.0,
      end: 0.0,
    ).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Interval(0.0, 0.5, curve: widget.curve),
      ),
    );

    // Fade animation with clamped values
    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Interval(0.0, 0.5, curve: widget.curve),
      ),
    );

    // Character count animation
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
      ),
    )..addListener(() {
      setState(() {});

      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (widget.scrollController != null &&
            widget.scrollController!.hasClients) {
          try {
            widget.scrollController!.jumpTo(
              widget.scrollController!.position.maxScrollExtent,
            );
          } catch (_) {}
        }
      });
    });

    _controller.forward();
  }

  @override
  void didUpdateWidget(covariant AnimatedTypingText oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.text != widget.text ||
        oldWidget.direction != widget.direction) {
      _controller.reset();
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
        ),
      );
      _controller.forward();
    }
  }

  @override
  Widget build(BuildContext context) {
    String visibleText;

    if (widget.direction == TypingDirection.leftToRight) {
      visibleText = widget.text.substring(
        0,
        _characterCount.value.clamp(0, widget.text.length),
      );
    } else {
      final startIndex = _characterCount.value.clamp(0, widget.text.length);
      visibleText = widget.text.substring(startIndex);
    }

    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        // Get screen width for side animations
        final screenWidth = MediaQuery.of(context).size.width;

        // Calculate slide offset based on screen width
        final slideOffset = _slideAnimation.value * screenWidth * 0.3;

        // Clamp values to prevent errors
        final clampedOpacity = _fadeAnimation.value.clamp(0.0, 1.0);
        final clampedSlide = slideOffset.clamp(-screenWidth, screenWidth);
        
        return Transform.translate(
          offset: Offset(clampedSlide, 0),
          child: Opacity(
            opacity: clampedOpacity,
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
