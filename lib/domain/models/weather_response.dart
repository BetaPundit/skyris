import 'package:freezed_annotation/freezed_annotation.dart';

part 'weather_response.freezed.dart';
part 'weather_response.g.dart';

@freezed
class WeatherResponse with _$WeatherResponse {
  const factory WeatherResponse({
    Coord? coord,
    List<Weather>? weather,
    String? base,
    Main? main,
    int? visibility,
    Wind? wind,
    Rain? rain,
    Snow? snow,
    Clouds? clouds,
    int? dt,
    Sys? sys,
    int? timezone,
    int? id,
    String? name,
    int? cod,
  }) = _WeatherResponse;

  const WeatherResponse._();

  String get backgroundImage {
    if ((weather?.firstOrNull?.id ?? 0) < 300) {
      return "assets/images/backgrounds/thunderstorm.png";
    } else if ((weather?.firstOrNull?.id ?? 0) < 500) {
      return "assets/images/backgrounds/drizzle.png";
    } else if ((weather?.firstOrNull?.id ?? 0) < 600) {
      return "assets/images/backgrounds/rain.png";
    } else if ((weather?.firstOrNull?.id ?? 0) < 700) {
      return "assets/images/backgrounds/snow.png";
    } else if ((weather?.firstOrNull?.id ?? 0) < 800) {
      return "assets/images/backgrounds/atmosphere.png";
    } else if ((weather?.firstOrNull?.id ?? 0) == 800) {
      return "assets/images/backgrounds/clear.png";
    } else {
      return "assets/images/backgrounds/clouds.png";
    }
  }

  factory WeatherResponse.fromJson(Map<String, dynamic> json) => _$WeatherResponseFromJson(json);
}

@freezed
class Coord with _$Coord {
  const factory Coord({
    double? lon,
    double? lat,
  }) = _Coord;

  factory Coord.fromJson(Map<String, dynamic> json) => _$CoordFromJson(json);
}

@freezed
class Weather with _$Weather {
  const factory Weather({
    int? id,
    String? main,
    String? description,
    String? icon,
  }) = _Weather;

  factory Weather.fromJson(Map<String, dynamic> json) => _$WeatherFromJson(json);
}

@freezed
class Main with _$Main {
  const factory Main({
    double? temp,
    @JsonKey(name: 'feels_like') double? feelsLike,
    @JsonKey(name: 'temp_min') double? tempMin,
    @JsonKey(name: 'temp_max') double? tempMax,
    int? pressure,
    int? humidity,
    @JsonKey(name: 'sea_level') int? seaLevel,
    @JsonKey(name: 'grnd_level') int? grndLevel,
  }) = _Main;

  factory Main.fromJson(Map<String, dynamic> json) => _$MainFromJson(json);
}

@freezed
class Wind with _$Wind {
  const factory Wind({
    double? speed,
    int? deg,
    double? gust,
  }) = _Wind;

  factory Wind.fromJson(Map<String, dynamic> json) => _$WindFromJson(json);
}

@freezed
class Rain with _$Rain {
  factory Rain({
    @JsonKey(name: '1h') double? oneHour,
  }) = _Rain;

  factory Rain.fromJson(Map<String, dynamic> json) => _$RainFromJson(json);
}

@freezed
class Snow with _$Snow {
  factory Snow({
    @JsonKey(name: '1h') double? oneHour,
  }) = _Snow;

  factory Snow.fromJson(Map<String, dynamic> json) => _$SnowFromJson(json);
}

@freezed
class Clouds with _$Clouds {
  const factory Clouds({
    int? all,
  }) = _Clouds;

  factory Clouds.fromJson(Map<String, dynamic> json) => _$CloudsFromJson(json);
}

@freezed
class Sys with _$Sys {
  const factory Sys({
    int? type,
    int? id,
    String? country,
    int? sunrise,
    int? sunset,
  }) = _Sys;

  factory Sys.fromJson(Map<String, dynamic> json) => _$SysFromJson(json);
}
