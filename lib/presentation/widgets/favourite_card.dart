import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:skyris/config/injection/injection.dart';
import 'package:skyris/config/themes/extensions/app_color_scheme.dart';
import 'package:skyris/config/themes/extensions/app_text_style.dart';
import 'package:skyris/domain/models/city_response.dart';
import 'package:skyris/domain/models/weather_location.dart';
import 'package:skyris/presentation/cubit/favourites_cubit.dart';
import 'package:skyris/presentation/cubit/weather_cubit.dart';
import 'package:skyris/presentation/screens/home_screen.dart';
import 'package:skyris/utils/constants/enums.dart';
import 'package:skyris/utils/extensions/app_theme_extension.dart';

class FavouriteCard extends StatelessWidget {
  const FavouriteCard({
    super.key,
    required this.location,
  });

  final WeatherLocation location;

  @override
  Widget build(BuildContext context) {
    final textStyle = context.themeData.extension<AppTextStyle>()!;
    final colorScheme = context.themeData.extension<AppColorScheme>()!;

    return Card(
      margin: EdgeInsets.symmetric(vertical: 8),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      clipBehavior: Clip.antiAlias,
      child: Container(
        decoration: BoxDecoration(
          color: colorScheme.surface,
          image: location.weatherData != null
              ? DecorationImage(
                  image: AssetImage(location.weatherData?.backgroundImage ?? ''),
                  fit: BoxFit.cover,
                )
              : null,
        ),
        child: ListTile(
          tileColor: Colors.transparent,
          contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          title: Text(
            location.cityName,
            style: textStyle.titleMedium.copyWith(
              shadows: [
                Shadow(
                  color: Colors.black.withValues(alpha: 0.15),
                  offset: Offset(1, 1),
                  blurRadius: 4,
                ),
              ],
            ),
          ),
          subtitle: Text(
            '${(location.weatherData?.main?.temp)?.round() ?? '--'}°C',
            style: textStyle.bodyMedium.copyWith(
              shadows: [
                Shadow(
                  color: Colors.black.withValues(alpha: 0.15),
                  offset: Offset(1, 1),
                  blurRadius: 4,
                ),
              ],
            ),
          ),
          trailing: IconButton(
            icon: Icon(CupertinoIcons.heart_fill, color: colorScheme.text),
            onPressed: () {
              context.read<FavouritesCubit>().removeFromFavourites(
                    CityResponse(
                      name: location.cityName,
                      latitude: location.latitude,
                      longitude: location.longitude,
                    ),
                  );
            },
          ),
          onTap: () {
            showModalBottomSheet(
              useSafeArea: true,
              context: context,
              showDragHandle: true,
              isScrollControlled: true,
              backgroundColor: colorScheme.background,
              constraints: BoxConstraints(
                maxHeight: MediaQuery.of(context).size.height * 0.9,
              ),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.vertical(top: Radius.circular(42)),
              ),
              clipBehavior: Clip.antiAlias,
              builder: (context) {
                return Scaffold(
                  body: BlocProvider(
                    create: (context) => locator<WeatherCubit>(),
                    child: BlocListener<WeatherCubit, WeatherState>(
                      listener: (context, state) {
                        if (state.status.isSuccess) {
                          context.read<FavouritesCubit>().updateWeatherData(
                                CityResponse(
                                  name: location.cityName,
                                  latitude: location.latitude,
                                  longitude: location.longitude,
                                ),
                                state.weatherData!,
                              );
                        }
                      },
                      child: HomeScreen(
                        city: CityResponse(
                          name: location.cityName,
                          latitude: location.latitude,
                          longitude: location.longitude,
                        ),
                      ),
                    ),
                  ),
                );
              },
            );
          },
        ),
      ),
    );
  }
}
