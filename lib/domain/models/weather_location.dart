import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:skyris/domain/models/city_response.dart';
import 'package:skyris/domain/models/weather_response.dart';

part 'weather_location.freezed.dart';
part 'weather_location.g.dart';

@freezed
class WeatherLocation with _$WeatherLocation {
  const factory WeatherLocation({
    required String cityName,
    required double latitude,
    required double longitude,
    required WeatherResponse? weatherData,
  }) = _WeatherLocation;

  factory WeatherLocation.fromJson(Map<String, dynamic> json) => _$WeatherLocationFromJson(json);

  const WeatherLocation._();

  // Helper constructor to create from WeatherResponse
  factory WeatherLocation.fromWeatherResponse(CityResponse city, WeatherResponse? weather) {
    return WeatherLocation(
      cityName: city.name,
      latitude: city.latitude,
      longitude: city.longitude,
      weatherData: weather,
    );
  }
}
