import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:skyris/config/themes/extensions/app_color_scheme.dart';
import 'package:skyris/config/themes/extensions/app_text_style.dart';
import 'package:skyris/domain/models/city_response.dart';
import 'package:skyris/presentation/cubit/location_cubit.dart';
import 'package:skyris/presentation/cubit/weather_cubit.dart';
import 'package:skyris/presentation/widgets/data_card.dart';
import 'package:skyris/presentation/widgets/error_card.dart';
import 'package:skyris/presentation/widgets/header_section.dart';
import 'package:skyris/utils/extensions/app_theme_extension.dart';

class HomeScreen extends StatefulWidget {
  final CityResponse? city;
  const HomeScreen({
    super.key,
    this.city,
  });

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late final textStyle = context.themeData.extension<AppTextStyle>()!;
  late final colorScheme = context.themeData.extension<AppColorScheme>()!;
  late final locationCubit = context.read<LocationCubit>();

  late double? latitude;
  late double? longitude;

  @override
  void initState() {
    latitude = widget.city?.latitude ?? locationCubit.state.latitude;
    longitude = widget.city?.longitude ?? locationCubit.state.longitude;

    context.read<WeatherCubit>().fetchWeather(
          latitude: latitude,
          longitude: longitude,
        );

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return OrientationBuilder(
      builder: (context, orientation) {
        return BlocBuilder<WeatherCubit, WeatherState>(
          builder: (context, state) {
            return AnimatedSwitcher(
              duration: Duration(milliseconds: 500),
              child: state.isLoading
                  ? Center(child: _buildLoader())
                  : state.hasError
                      ? Center(
                          child: ErrorCard(
                            errorMessage: state.error ?? '',
                            onRetry: () {
                              context.read<WeatherCubit>().fetchWeather(
                                    latitude: latitude,
                                    longitude: longitude,
                                  );
                            },
                          ),
                        )
                      : CustomScrollView(
                          slivers: [
                            // Header Section
                            HeaderSection(
                              weatherResponse: state.weatherData!,
                              city: widget.city,
                            ),

                            SliverPadding(
                              padding: const EdgeInsets.all(10),
                              sliver: SliverGrid(
                                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: orientation == Orientation.landscape ? 4 : 2,
                                  mainAxisSpacing: 10,
                                  crossAxisSpacing: 10,
                                  childAspectRatio: orientation == Orientation.landscape ? 1.8 : 1.45,
                                ),
                                delegate: SliverChildListDelegate(
                                  [
                                    // Wind Data
                                    if (state.weatherData?.wind != null)
                                      DataCard(
                                        icon: Icon(
                                          CupertinoIcons.wind,
                                          color: colorScheme.text,
                                        ),
                                        heading: 'Wind',
                                        content:
                                            '${((state.weatherData?.wind!.speed ?? 0) * 18 / 5).toStringAsFixed(2)} km/h',
                                      ),

                                    // Sunrise/sunset Data
                                    if (state.weatherData?.sys != null)
                                      DataCard(
                                        icon: Icon(
                                          CupertinoIcons.sunrise,
                                          color: colorScheme.text,
                                        ),
                                        heading:
                                            'Sunrise: ${DateFormat.jm().format(DateTime.fromMillisecondsSinceEpoch(state.weatherData?.sys!.sunrise ?? 0))}',
                                        content:
                                            'Sunset: ${DateFormat.jm().format(DateTime.fromMillisecondsSinceEpoch(state.weatherData?.sys!.sunset ?? 0))}',
                                      ),

                                    // Pressure Data
                                    if (state.weatherData?.main?.pressure != null)
                                      DataCard(
                                        icon: Icon(
                                          CupertinoIcons.thermometer,
                                          color: colorScheme.text,
                                        ),
                                        heading: 'Pressure',
                                        content: '${(state.weatherData?.main!.pressure!)} hPa',
                                      ),

                                    // Humidity Data
                                    if (state.weatherData?.main?.humidity != null)
                                      DataCard(
                                        icon: Icon(
                                          CupertinoIcons.drop,
                                          color: colorScheme.text,
                                        ),
                                        heading: 'Humidity',
                                        content: '${(state.weatherData?.main!.humidity!)}%',
                                      ),

                                    // visibility Data
                                    if (state.weatherData?.visibility != null)
                                      DataCard(
                                        icon: Icon(
                                          CupertinoIcons.eye,
                                          color: colorScheme.text,
                                        ),
                                        heading: 'visibility',
                                        content:
                                            '${((state.weatherData?.visibility ?? 0) / 1000).toStringAsFixed(2)} km',
                                      ),

                                    // Cloudiness Data
                                    DataCard(
                                      icon: Icon(
                                        CupertinoIcons.cloud,
                                        color: colorScheme.text,
                                      ),
                                      heading: 'Cloudiness',
                                      content: '${(state.weatherData?.clouds?.all ?? 0)}%',
                                    ),

                                    // Rain Data
                                    DataCard(
                                      icon: Icon(
                                        CupertinoIcons.cloud_rain,
                                        color: colorScheme.text,
                                      ),
                                      heading: 'Precipitation',
                                      content: '${(state.weatherData?.rain?.oneHour ?? 0)} mm/h',
                                    ),

                                    // Rain Data
                                    DataCard(
                                      icon: Icon(
                                        CupertinoIcons.cloud_snow,
                                        color: colorScheme.text,
                                      ),
                                      heading: 'Snow',
                                      content: '${(state.weatherData?.snow?.oneHour ?? 0)} mm/h',
                                    ),

                                    const SizedBox(height: 100)
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
            );
          },
        );
      },
    );
  }

  Widget _buildLoader() {
    return Center(
      child: CircularProgressIndicator(),
    );
  }
}
