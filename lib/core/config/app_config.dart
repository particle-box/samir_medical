class AppConfig {
  // Base API URL
  static const String apiBaseUrl = 'https://samir-medical-backend.onrender.com';

  // PayKun placeholders (replace in local config for production)
  static const String paykunMerchantId = 'YOUR_MERCHANT_ID';
  static const String paykunAccessToken = 'YOUR_ACCESS_TOKEN';
  static const String paykunKey = 'YOUR_KEY';
  static const String paykunSalt = 'YOUR_SALT';
  static const bool paykunSandbox = true; // toggle in prod

  // MapLibre style / token (public style can be used; avoid secrets)
  static const String mapStyleUrl = 'https://demotiles.maplibre.org/style.json';
}
