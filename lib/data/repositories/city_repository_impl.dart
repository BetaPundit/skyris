import 'package:injectable/injectable.dart';
import 'package:skyris/data/base/base_api_repository.dart';
import 'package:skyris/data/datasources/remote/city_api_service.dart';
import 'package:skyris/domain/models/city_response.dart';
import 'package:skyris/domain/repositories/city_repository.dart';
import 'package:skyris/utils/constants/constants.dart';
import 'package:skyris/utils/resources/data_state.dart';

@Injectable(as: CityRepository)
class CityRepositoryImpl extends BaseApiRepository implements CityRepository {
  final CityApiService _cityApiService;

  CityRepositoryImpl(this._cityApiService);

  @override
  Future<DataState<List<CityResponse>?>> searchCity({
    required String name,
  }) {
    return getStateOf<List<CityResponse>>(
      request: () => _cityApiService.searchCity(
        name: name,
        apiKey: Constants.ninjaApiKey,
      ),
    );
  }
}
