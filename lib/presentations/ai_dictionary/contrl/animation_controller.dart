import 'dart:async';
import 'package:get/get.dart';

class AnimatedTextController extends GetxController {
  final animatedText = ''.obs;
  Timer? _timer;
  int _currentIndex = 0;

  String _fullText = '';
  Duration _charDelay = const Duration(milliseconds: 100);

  /// Start typing animation with any text and optional speed
  void startTyping({required String text, Duration? charDelay}) {
    _timer?.cancel(); // stop any previous timer
    animatedText.value = '';
    _currentIndex = 0;
    _fullText = text;
    _charDelay = charDelay ?? const Duration(milliseconds: 50);

    _timer = Timer.periodic(_charDelay, (timer) {
      if (_currentIndex < _fullText.length) {
        animatedText.value += _fullText[_currentIndex];
        _currentIndex++;
      } else {
        _timer?.cancel();
      }
    });
  }

  /// Restart with same previous text and speed
  void restartTyping() {
    startTyping(text: _fullText, charDelay: _charDelay);
  }

  @override
  void onClose() {
    _timer?.cancel();
    super.onClose();
  }
}
