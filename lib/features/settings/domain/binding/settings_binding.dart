import 'package:startup_repo/features/splash/presentation/controller/splash_controller.dart';
import 'package:startup_repo/imports.dart';
import '../service/settings_service.dart';
import '../service/settings_service_interface.dart';
import '../../presentation/controller/settings_controller.dart';

class SettingsBinding extends Bindings {
  @override
  void dependencies() {
    if (!Get.isRegistered<SettingsServiceInterface>()) {
      Get.lazyPut<SettingsServiceInterface>(() => SettingsService(), fenix: true);
    }
    if (!Get.isRegistered<SettingsController>()) {
      Get.lazyPut(() => SettingsController(
        settingsService: Get.find<SettingsServiceInterface>(),
        splashController: SplashController.find,
      ), fenix: true);
    }
  }
}


