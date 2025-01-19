import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:injectable/injectable.dart';

@singleton
class EnvConfig {
  EnvConfig() {
    _initialize();
  }

  Future<void> _initialize() async {
    await dotenv.load();
  }

  String get weatherApiKey => dotenv.env['WEATHER_API_KEY'] ?? '';
  String get cityApiKey => dotenv.env['CITY_API_KEY'] ?? '';
}
