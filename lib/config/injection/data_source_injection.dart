import 'package:dio/dio.dart';

import 'package:injectable/injectable.dart';
import 'package:skyris/data/datasources/remote/city_api_service.dart';
import 'package:skyris/data/datasources/remote/weather_api_service.dart';
import 'package:skyris/core/services/env_config.dart';

@module
abstract class DataSourceInjectableModule {
  @injectable
  WeatherApiService getWeatherService(
    @Named('weatherClient') Dio dio,
    EnvConfig envConfig,
  ) =>
      WeatherApiService(dio, envConfig.weatherApiKey);

  @injectable
  CityApiService getCityService(
    @Named('cityClient') Dio dio,
    EnvConfig envConfig,
  ) =>
      CityApiService(dio, envConfig.cityApiKey);
}
