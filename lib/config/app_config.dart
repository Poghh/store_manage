enum Flavor { dev, stg }

class AppConfig {
  static late Flavor environment;

  static bool get isDev => environment == Flavor.dev;
  static bool get isProd => environment == Flavor.stg;
}
