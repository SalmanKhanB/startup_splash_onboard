import 'package:get/get.dart';
import '../../data/model/config_model.dart';
import '../../domain/service/splash_service_interface.dart';

class SplashController extends GetxController implements GetxService {
  final SplashServiceInterface settingsService;
  SplashController({required this.settingsService});

  static SplashController get find => Get.find<SplashController>();

  ConfigModel? _settingModel;
  ConfigModel? get settingModel => _settingModel;

  set settingModel(ConfigModel? settingModel) {
    _settingModel = settingModel;
    update();
  }

  void initSharedData() {
    settingsService.initSharedData();
    getConfig();
  }

  Future<void> getConfig() async {
    try {
    _settingModel = await settingsService.getConfig();
    update();
    } catch (e) {
      // Handle error if config fails to load
      _settingModel = null;
      update();
    }
  }

  Future<void> saveFirstTime() async => await settingsService.saveFirstTime();
  bool get isFirstTime => settingsService.getFirstTime();
}
