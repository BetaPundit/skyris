import 'package:dio/dio.dart';

import 'package:injectable/injectable.dart';
import 'package:skyris/data/datasources/remote/city_api_service.dart';
import 'package:skyris/data/datasources/remote/weather_api_service.dart';

@module
abstract class DataSourceInjectableModule {
  WeatherApiService getMoviesService(@Named('weatherClient') Dio dio) => WeatherApiService(dio);
  CityApiService getCityService(@Named('cityClient') Dio dio) => CityApiService(dio);
}
