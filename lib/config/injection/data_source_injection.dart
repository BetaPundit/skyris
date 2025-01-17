import 'package:dio/dio.dart';

import 'package:injectable/injectable.dart';
import 'package:skyris/data/datasources/remote/weather_api_service.dart';

@module
abstract class DataSourceInjectableModule {
  WeatherApiService getMoviesService(Dio dio) => WeatherApiService(dio);
}
