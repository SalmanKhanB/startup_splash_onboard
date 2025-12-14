import 'dart:io';

import 'package:startup_repo/features/language/presentation/view/language.dart';
import 'package:startup_repo/features/settings/presentation/view/settings_document_screen.dart';
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

  void openPrivacyPolicy() => _openDocument(
        titleKey: 'privacy_policy',
        content: splashController.settingModel.privacyPolicy,
      );

  void openTerms() => _openDocument(
        titleKey: 'terms_conditions',
        content: splashController.settingModel.termsAndConditions,
      );

  Future<void> shareApp() => settingsService.shareApp(message: 'share_app_message'.tr);

  Future<void> rateApp() async {
    final url = Platform.isIOS ? AppConstants.iOSStoreUrl : AppConstants.androidStoreUrl;
    final launched = await settingsService.rateApp(url);
    if (!launched) {
      showToast('coming_soon'.tr);
    }
  }

  void _openDocument({required String titleKey, required String content}) {
    launchScreen(SettingsDocumentScreen(titleKey: titleKey, content: content));
  }
}


