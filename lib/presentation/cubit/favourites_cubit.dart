import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:skyris/domain/models/city_response.dart';
import 'package:skyris/domain/models/weather_response.dart';
import 'package:skyris/domain/models/weather_location.dart';

part 'favourites_cubit.freezed.dart';
part 'favourites_cubit.g.dart';

@freezed
class FavouritesState with _$FavouritesState {
  const factory FavouritesState({
    @Default([]) List<WeatherLocation> favourites,
    WeatherLocation? lastSelected,
  }) = _FavouritesState;

  factory FavouritesState.fromJson(Map<String, dynamic> json) => _$FavouritesStateFromJson(json);
}

@injectable
class FavouritesCubit extends HydratedCubit<FavouritesState> {
  FavouritesCubit() : super(const FavouritesState());

  void addToFavourites(CityResponse city, WeatherResponse? weather) {
    final currentFavourites = List<WeatherLocation>.from(state.favourites);
    final weatherLocation = WeatherLocation.fromWeatherResponse(city, weather);

    // Check if location already exists in favourites
    final exists = currentFavourites.any(
      (element) => element.latitude == weatherLocation.latitude && element.longitude == weatherLocation.longitude,
    );

    if (!exists) {
      currentFavourites.add(weatherLocation);
      emit(state.copyWith(favourites: currentFavourites));
    }
  }

  void removeFromFavourites(CityResponse location) {
    final currentFavourites = List<WeatherLocation>.from(state.favourites);

    currentFavourites.removeWhere(
      (element) => element.latitude == location.latitude && element.longitude == location.longitude,
    );

    emit(state.copyWith(favourites: currentFavourites));
  }

  void updateWeatherData(CityResponse city, WeatherResponse weather) {
    final currentFavourites = List<WeatherLocation>.from(state.favourites);
    final weatherLocation = WeatherLocation.fromWeatherResponse(city, weather);

    // Update weather data for matching location
    final index = currentFavourites.indexWhere(
      (element) => element.latitude == weatherLocation.latitude && element.longitude == weatherLocation.longitude,
    );

    if (index != -1) {
      currentFavourites[index] = weatherLocation;
      emit(state.copyWith(favourites: currentFavourites));
    }

    // Update last selected if it matches the location
    if (state.lastSelected?.latitude == weatherLocation.latitude &&
        state.lastSelected?.longitude == weatherLocation.longitude) {
      emit(state.copyWith(lastSelected: weatherLocation));
    }
  }

  void setLastSelected(CityResponse city, WeatherResponse? weather) {
    final weatherLocation = WeatherLocation.fromWeatherResponse(city, weather);
    emit(state.copyWith(lastSelected: weatherLocation));
  }

  bool isFavourite(CityResponse city, WeatherResponse? weather) {
    final weatherLocation = WeatherLocation.fromWeatherResponse(city, weather);
    return state.favourites.any(
      (element) => element.latitude == weatherLocation.latitude && element.longitude == weatherLocation.longitude,
    );
  }

  @override
  FavouritesState? fromJson(Map<String, dynamic> json) {
    return FavouritesState.fromJson(json);
  }

  @override
  Map<String, dynamic>? toJson(FavouritesState state) {
    return state.toJson();
  }
}
