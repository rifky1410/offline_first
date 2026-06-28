class EnvConfig {
  EnvConfig._();
  
  static const String environment = String.fromEnvironment('ENV_NAME', defaultValue: 'DEV');
  static const String baseUrl = 'https://newsapi.org/v2/';
  static const String apiKey = '1ce83f90cbd8497093e339fb324c3fec';
  
  static bool get isProduction => environment == 'PROD';
}