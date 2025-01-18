import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:skyris/domain/models/weather_response.dart';
import 'package:skyris/domain/repositories/weather_repository.dart';
import 'package:skyris/utils/constants/enums.dart';

part 'weather_cubit.freezed.dart';

@freezed
class WeatherState with _$WeatherState {
  const factory WeatherState({
    @Default(NetworkStatus.initial) NetworkStatus status,
    WeatherResponse? weatherData,
    String? error,
  }) = _WeatherState;

  const WeatherState._();

  bool get isLoading => status.isLoading;

  bool get hasError => status.isFailure;
}

@injectable
class WeatherCubit extends Cubit<WeatherState> {
  final WeatherRepository _weatherRepository;

  WeatherCubit(this._weatherRepository) : super(const WeatherState());

  Future<void> fetchWeather({double? latitude, double? longitude}) async {
    emit(state.copyWith(status: NetworkStatus.loading));

    try {
      final response = await _weatherRepository.getCurrentWeather(
        latitude: latitude?.round(),
        longitude: longitude?.round(),
      );

      if (response.data != null) {
        emit(state.copyWith(
          status: NetworkStatus.success,
          weatherData: response.data,
        ));
      } else {
        emit(state.copyWith(
          status: NetworkStatus.failure,
          error: response.error?.message,
        ));
      }
    } catch (e) {
      emit(state.copyWith(
        status: NetworkStatus.failure,
        error: e.toString(),
      ));
    }
  }
}
