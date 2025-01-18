import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';
import 'package:skyris/domain/models/city_response.dart';

part 'city_api_service.g.dart';

@RestApi(parser: Parser.JsonSerializable)
abstract class CityApiService {
  factory CityApiService(Dio dio) = _CityApiService;

  @GET("/city")
  Future<HttpResponse<List<CityResponse>>> searchCity({
    @Query('name') required String name,
    @Header('X-Api-Key') required String apiKey,
  });
}
