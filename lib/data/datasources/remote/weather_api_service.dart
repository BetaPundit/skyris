import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';
import 'package:skyris/domain/models/weather_response.dart';

part 'weather_api_service.g.dart';

@RestApi(parser: Parser.JsonSerializable)
abstract class WeatherApiService {
  factory WeatherApiService(Dio dio, String apiKey) {
    dio.options.queryParameters = {'appid': apiKey};
    return _WeatherApiService(dio);
  }

  @GET("/weather")
  Future<HttpResponse<WeatherResponse>> fetchCurrentWeather({
    @Query('lat') int? lat,
    @Query('lon') int? lon,
    @Query('units') String? units = 'metric',
  });
}
