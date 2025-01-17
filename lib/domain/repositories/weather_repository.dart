import 'package:skyris/domain/models/weather_response.dart';
import 'package:skyris/utils/resources/data_state.dart';

abstract class WeatherRepository {
  Future<DataState<WeatherResponse?>> getCurrentWeather({
    int? latitude,
    int? longitude,
  });
}
