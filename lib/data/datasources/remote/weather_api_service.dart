import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';
import 'package:skyris/domain/models/weather_response.dart';

part 'weather_api_service.g.dart';

@RestApi(parser: Parser.JsonSerializable)
abstract class WeatherApiService {
  factory WeatherApiService(Dio dio) = _WeatherApiService;

  @GET("/weather")
  Future<HttpResponse<WeatherResponse>> fetchCurrentWeather({
    @Query('lat') int? lat,
    @Query('lon') int? lon,
    @Query('appid') String? appid,
  });
}
