import 'package:injectable/injectable.dart';
import 'package:skyris/data/base/base_api_repository.dart';
import 'package:skyris/data/datasources/remote/weather_api_service.dart';
import 'package:skyris/domain/models/weather_response.dart';
import 'package:skyris/domain/repositories/weather_repository.dart';
import 'package:skyris/utils/resources/data_state.dart';

@Injectable(as: WeatherRepository)
class WeatherRepositoryImpl extends BaseApiRepository implements WeatherRepository {
  final WeatherApiService _weatherApiService;
  WeatherRepositoryImpl(this._weatherApiService);

  @override
  Future<DataState<WeatherResponse?>> getCurrentWeather({
    int? latitude,
    int? longitude,
  }) {
    return getStateOf<WeatherResponse>(
      request: () => _weatherApiService.fetchCurrentWeather(
        lat: latitude,
        lon: longitude,
      ),
    );
  }
}
