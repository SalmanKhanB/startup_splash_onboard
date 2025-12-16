abstract class SettingsServiceInterface {
  Future<void> shareApp({String? message, String? url});
  Future<bool> rateApp(String url);
  Future<bool> openUrl(String url);
}


