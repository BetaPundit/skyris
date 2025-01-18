import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:geolocator/geolocator.dart';
import 'package:injectable/injectable.dart';
import 'package:geocoding/geocoding.dart';
import 'package:skyris/utils/constants/enums.dart';

part 'location_cubit.freezed.dart';

@freezed
class LocationState with _$LocationState {
  const factory LocationState({
    @Default(NetworkStatus.initial) NetworkStatus status,
    Position? position,
  }) = _LocationState;

  const LocationState._();

  double? get latitude => position?.latitude;

  double? get longitude => position?.longitude;

  Future<Placemark?> get locality async {
    if (position == null) {
      return null;
    }
    final placemarks = await placemarkFromCoordinates(
      position!.latitude,
      position!.longitude,
    );
    Placemark place = placemarks[0];
    return place;
  }
}

@lazySingleton
class LocationCubit extends Cubit<LocationState> {
  LocationCubit() : super(const LocationState());

  Future<void> fetchLocation() async {
    emit(state.copyWith(status: NetworkStatus.loading));

    try {
      final response = await _getCurrentLocation();

      emit(state.copyWith(
        status: NetworkStatus.success,
        position: response,
      ));
    } catch (error) {
      emit(state.copyWith(status: NetworkStatus.failure));
    }
  }

  Future<Position> _getCurrentLocation() async {
    final position = await Geolocator.getCurrentPosition();

    return position;
  }
}
