abstract class SettingsServiceInterface {
  Future<void> shareApp({String? message});
  Future<bool> rateApp(String url);
}


