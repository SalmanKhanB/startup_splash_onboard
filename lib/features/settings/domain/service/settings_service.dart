import 'package:share_plus/share_plus.dart';
import 'package:url_launcher/url_launcher_string.dart';
import '../../../../imports.dart';
import 'settings_service_interface.dart';

class SettingsService implements SettingsServiceInterface {
  @override
  Future<void> shareApp({String? message, String? url}) async {
    final shareMessage = url != null 
        ? '${message ?? 'share_app_message'.tr}\n$url'
        : (message ?? 'share_app_message'.tr);
    await Share.share(shareMessage);
  }

  @override
  Future<bool> rateApp(String url) async {
    return launchUrlString(url, mode: LaunchMode.externalApplication);
  }

  @override
  Future<bool> openUrl(String url) async {
    return launchUrlString(url, mode: LaunchMode.externalApplication);
  }
}


