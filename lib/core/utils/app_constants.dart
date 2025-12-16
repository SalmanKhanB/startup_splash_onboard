import '../../features/language/data/model/language.dart';

class AppConstants {
  // app name and package name
  static String appName = 'Startup Repo';

  // Base URL
  static String baseUrl = 'https://api.example.com/';

  // API Endpoints
  static const String configUrl = 'config';

  // Shared Key
  static const String theme = 'theme';
  static const String countryCode = 'country_code';
  static const String languageCode = 'language_code';
  static const String onBoardingSkip = 'on_boarding_skip';
  static const String token = 'token';
  static const String localizationKey = 'localization';

  // Store URLs - Update these with your actual package name and iOS app ID
  static const String androidStoreUrl = 'https://play.google.com/store/apps/details?id=com.example.startupRepo';
  static const String iOSStoreUrl = 'https://apps.apple.com/app/id000000000';
  
  // Privacy and Terms URLs - Temporary URLs, update with your actual URLs
  static const String privacyPolicyUrl = 'https://example.com/privacy-policy';
  static const String termsAndConditionsUrl = 'https://example.com/terms-and-conditions';

  // Language
  static List<LanguageModel> languages = [
    LanguageModel(languageName: 'English', countryCode: 'US', languageCode: 'en'),
    LanguageModel(languageName: 'Arabic', countryCode: 'SA', languageCode: 'ar'),
  ];
}
