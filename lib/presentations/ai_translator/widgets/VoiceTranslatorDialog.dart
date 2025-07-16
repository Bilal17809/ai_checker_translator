// ✅ ios_voice_dialog.dart (Final version with live transcription, smooth retry, auto close, and animation)
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class IOSVoiceDialog extends StatefulWidget {
  final RxBool isListening;
  final RxString recognizedText;
  final VoidCallback onCancel;
  final Future<void> Function() onRetry;

  const IOSVoiceDialog({
    super.key,
    required this.isListening,
    required this.recognizedText,
    required this.onCancel,
    required this.onRetry,
  });

  @override
  State<IOSVoiceDialog> createState() => _IOSVoiceDialogState();
}

class _IOSVoiceDialogState extends State<IOSVoiceDialog>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  Timer? _silenceTimer;

  bool showTryAgain = false;
  bool micAlertRed = false;
  bool userSpoke = false;

  @override
  void initState() {
    super.initState();
    _startSilenceTimer();

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1000),
    )..repeat(reverse: true);

    ever(widget.isListening, (val) {
      if (!val && widget.recognizedText.value.isNotEmpty && mounted) {
        if (Navigator.canPop(context)) Get.back();
      }
    });

    ever(widget.recognizedText, (text) {
      if (text.toString().trim().isNotEmpty) {
        userSpoke = true;
        _resetSilenceTimer();
      }
    });
  }

  void _startSilenceTimer() {
    _silenceTimer?.cancel();
    _silenceTimer = Timer(const Duration(seconds: 3), () {
      if (!mounted || userSpoke) return;
      setState(() {
        showTryAgain = true;
        micAlertRed = true;
      });
    });
  }

  void _resetSilenceTimer() {
    if (_silenceTimer?.isActive ?? false) _silenceTimer?.cancel();
    if (!mounted) return;
    setState(() {
      micAlertRed = false;
      showTryAgain = false;
    });
    _startSilenceTimer();
  }

  @override
  void dispose() {
    _controller.dispose();
    _silenceTimer?.cancel();
    super.dispose();
  }

  void _handleTapOutside() {
    if (mounted && Navigator.canPop(context)) {
      widget.onCancel();
    }
  }

  @override
  Widget build(BuildContext context) {
    final scale = 1 + (_controller.value * 0.15);
    return GestureDetector(
      onTap: _handleTapOutside,
      behavior: HitTestBehavior.translucent,
      child: Dialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        backgroundColor: Colors.white,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 32),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Transform.scale(
                scale: scale,
                child: Container(
                  padding: const EdgeInsets.all(24),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color:
                        micAlertRed
                            ? Colors.red.withOpacity(0.2)
                            : Colors.blue.withOpacity(0.2),
                    border: Border.all(
                      color: micAlertRed ? Colors.red : Colors.blue,
                      width: 2,
                    ),
                  ),
                  child: Icon(
                    Icons.mic,
                    size: 40,
                    color: micAlertRed ? Colors.red : Colors.blue,
                  ),
                ),
              ),
              const SizedBox(height: 20),
              Obx(
                () => AnimatedSwitcher(
                  duration: const Duration(milliseconds: 300),
                  child: Text(
                    widget.recognizedText.value.isNotEmpty
                        ? widget.recognizedText.value
                        : widget.isListening.value
                        ? "Listening..."
                        : "Say something...",
                    key: ValueKey(
                      widget.recognizedText.value +
                          widget.isListening.value.toString(),
                    ),
                    textAlign: TextAlign.center,
                    style: const TextStyle(fontSize: 16),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              if (showTryAgain)
                ElevatedButton.icon(
                  icon: const Icon(Icons.refresh),
                  label: const Text("Try Again"),
                  onPressed: () async {
                    if (!mounted) return;
                    setState(() {
                      micAlertRed = false;
                      userSpoke = false;
                      showTryAgain = false;
                    });
                    await widget.onRetry();
                  },
                ),
            ],
          ),
        ),
      ),
    );
  }
}
