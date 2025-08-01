import 'dart:async';
import 'package:ai_checker_translator/core/routes/routes_name.dart';
import 'package:get/get.dart';

class SplashController extends GetxController {
  
  RxBool isLoading = true.obs;
  RxBool showButton = false.obs;
  RxBool initializingControllers = false.obs;
  RxDouble animationProgress = 0.0.obs;
  Timer? _animationTimer;

  @override
  void onInit() {
    super.onInit();
    startAnimations();
  }

  void startAnimations() {
    animationProgress.value = 0.0;
    _animationTimer = Timer.periodic(const Duration(milliseconds: 40), (timer) {
      animationProgress.value += 0.01;
      if (animationProgress.value >= 1.0) {
        timer.cancel();
        Timer(const Duration(milliseconds: 500), () {
          showButton.value = true;
          isLoading.value = false;
        });
      }
    });
  }

  Future<void> initializeAppControllers() async {
    if (initializingControllers.value) return;
    initializingControllers.value = true;

    await Future.delayed(const Duration(seconds: 2)); // Simulate initialization
    
    navigateToHome();
  }

  void navigateToHome() {
    Get.offNamed(RoutesName.bottomNevBar);
  }

  @override
  void onClose() {
    _animationTimer?.cancel();
    super.onClose();
  }
}