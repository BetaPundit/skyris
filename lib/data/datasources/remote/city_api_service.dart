import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';
import 'package:skyris/domain/models/city_response.dart';

part 'city_api_service.g.dart';

@RestApi()
abstract class CityApiService {
  factory CityApiService(Dio dio, String apiKey) {
    dio.options.headers = {'X-Api-Key': apiKey};
    return _CityApiService(dio);
  }

  @GET("/city")
  Future<HttpResponse<List<CityResponse>>> searchCity({
    @Query('name') required String name,
  });
}
