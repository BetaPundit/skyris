import 'package:skyris/domain/models/city_response.dart';
import 'package:skyris/utils/resources/data_state.dart';

abstract class CityRepository {
  Future<DataState<List<CityResponse>?>> searchCity({
    required String name,
  });
}
