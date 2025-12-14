import 'package:share_plus/share_plus.dart';
import 'package:url_launcher/url_launcher_string.dart';
import '../../../../imports.dart';
import 'settings_service_interface.dart';

class SettingsService implements SettingsServiceInterface {
  @override
  Future<void> shareApp({String? message}) async {
    await Share.share(message ?? 'share_app_message'.tr);
  }

  @override
  Future<bool> rateApp(String url) async {
    return launchUrlString(url, mode: LaunchMode.externalApplication);
  }
}


