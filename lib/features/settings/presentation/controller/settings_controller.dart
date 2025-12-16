import 'dart:io';

import 'package:startup_repo/features/language/presentation/view/language.dart';
import 'package:startup_repo/features/splash/presentation/controller/splash_controller.dart';
import 'package:startup_repo/features/theme/presentation/controller/theme_controller.dart';
import 'package:startup_repo/imports.dart';
import '../../domain/service/settings_service_interface.dart';
import '../widgets/settings_theme_sheet.dart';

class SettingsController extends GetxController {
  final SettingsServiceInterface settingsService;
  final SplashController splashController;

  SettingsController({
    required this.settingsService,
    required this.splashController,
  });

  void openLanguage() => launchScreen(const LanguageScreen());

  void openThemeSelector() {
    final ThemeController controller = ThemeController.find;
    Get.bottomSheet(
      SettingsThemeSheet(
        currentTheme: controller.themeMode,
        onSelect: (mode) {
          controller.setThemeMode(mode);
          Get.back();
        },
      ),
    );
  }

  Future<void> openPrivacyPolicy() async {
    final url = AppConstants.privacyPolicyUrl;
    final launched = await settingsService.openUrl(url);
    if (!launched) {
      showToast('could_not_open_url'.tr);
    }
  }

  Future<void> openTerms() async {
    final url = AppConstants.termsAndConditionsUrl;
    final launched = await settingsService.openUrl(url);
    if (!launched) {
      showToast('could_not_open_url'.tr);
    }
  }

  Future<void> shareApp() async {
    final url = Platform.isIOS ? AppConstants.iOSStoreUrl : AppConstants.androidStoreUrl;
    await settingsService.shareApp(
      message: 'share_app_message'.tr,
      url: url,
    );
  }

  Future<void> rateApp() async {
    final url = Platform.isIOS ? AppConstants.iOSStoreUrl : AppConstants.androidStoreUrl;
    final launched = await settingsService.rateApp(url);
    if (!launched) {
      showToast('coming_soon'.tr);
    }
  }

}


