import 'package:ai_checker_translator/presentations/ai_translator/controller/translation_contrl.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';


mixin AppLifecycleMixin<T extends StatefulWidget> on State<T> {

    final TranslationController translationController = Get.put(TranslationController());
  
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(_observer);
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(_observer);
    translationController.flutterTts.stop();
    super.dispose();
  }

  late final WidgetsBindingObserver _observer = _AppLifecycleObserver(onAppPause: onAppPause);
  void onAppPause() {}
}

class _AppLifecycleObserver extends WidgetsBindingObserver {
  final VoidCallback onAppPause;

  _AppLifecycleObserver({required this.onAppPause});

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.paused ||
        state == AppLifecycleState.inactive ||
        state == AppLifecycleState.detached) {
      onAppPause();
    }
  }
}
