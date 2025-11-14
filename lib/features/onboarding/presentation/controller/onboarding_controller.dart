import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../../core/utils/app_constants.dart';
import '../../../../features/home/presentation/view/home.dart';

class OnboardingController extends GetxController implements GetxService {
  final PageController pageController = PageController();
  int currentPage = 0;

  static OnboardingController get find => Get.find<OnboardingController>();

  void onPageChanged(int index) {
    currentPage = index;
    update();
  }

  void nextPage() {
    if (currentPage < 2) {
      pageController.nextPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    } else {
      _completeOnboarding();
    }
  }

  void skipOnboarding() {
    _completeOnboarding();
  }

  Future<void> _completeOnboarding() async {
    final prefs = Get.find<SharedPreferences>();
    await prefs.setBool(AppConstants.onBoardingSkip, false);
    Get.offAll(() => const HomeScreen());
  }

  @override
  void onClose() {
    pageController.dispose();
    super.onClose();
  }
}

