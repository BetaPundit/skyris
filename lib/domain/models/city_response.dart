import 'package:freezed_annotation/freezed_annotation.dart';

part 'city_response.freezed.dart';
part 'city_response.g.dart';

@freezed
class CityResponse with _$CityResponse {
  const factory CityResponse({
    required String name,
    required double latitude,
    required double longitude,
    @Default('') String country,
    @Default(0) int population,
    @Default('') String region,
    @Default(false) @JsonKey(name: 'is_capital') bool isCapital,
  }) = _CityResponse;

  factory CityResponse.fromJson(Map<String, dynamic> json) => _$CityResponseFromJson(json);
}
