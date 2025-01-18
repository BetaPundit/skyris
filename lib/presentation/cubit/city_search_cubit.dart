import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:skyris/domain/models/city_response.dart';
import 'package:skyris/domain/repositories/city_repository.dart';
import 'package:skyris/utils/constants/enums.dart';

part 'city_search_cubit.freezed.dart';

@freezed
class CitySearchState with _$CitySearchState {
  const factory CitySearchState({
    @Default(NetworkStatus.initial) NetworkStatus status,
    @Default([]) List<CityResponse> cities,
    String? error,
  }) = _CitySearchState;

  const CitySearchState._();

  bool get isLoading => status.isLoading;
  bool get hasError => status.isFailure;
}

@lazySingleton
class CitySearchCubit extends Cubit<CitySearchState> {
  final CityRepository _cityRepository;
  Timer? _debounce;

  CitySearchCubit(this._cityRepository) : super(const CitySearchState());

  @override
  Future<void> close() {
    _debounce?.cancel();
    return super.close();
  }

  Future<void> searchCity(String name) async {
    if (_debounce?.isActive ?? false) _debounce?.cancel();

    _debounce = Timer(const Duration(milliseconds: 500), () async {
      if (name.isEmpty) {
        emit(const CitySearchState());
        return;
      }

      emit(state.copyWith(status: NetworkStatus.loading));

      try {
        final response = await _cityRepository.searchCity(name: name);

        if (response.data != null) {
          emit(state.copyWith(
            status: NetworkStatus.success,
            cities: response.data ?? [],
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
    });
  }
}
