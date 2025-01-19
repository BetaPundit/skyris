import 'dart:math';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:skyris/config/themes/extensions/app_color_scheme.dart';
import 'package:skyris/config/themes/extensions/app_text_style.dart';
import 'package:skyris/domain/models/city_response.dart';
import 'package:skyris/domain/models/weather_response.dart';
import 'package:skyris/presentation/cubit/favourites_cubit.dart';
import 'package:skyris/presentation/cubit/location_cubit.dart';
import 'package:skyris/presentation/cubit/weather_cubit.dart';
import 'package:skyris/utils/constants/constants.dart';
import 'package:skyris/utils/extensions/app_theme_extension.dart';
import 'package:skyris/utils/extensions/string_extension.dart';

class HeaderSection extends StatefulWidget {
  final CityResponse? city;
  final WeatherResponse weatherResponse;

  const HeaderSection({
    super.key,
    required this.weatherResponse,
    this.city,
  });

  @override
  State<HeaderSection> createState() => _HeaderSectionState();
}

class _HeaderSectionState extends State<HeaderSection> {
  late final textStyle = context.themeData.extension<AppTextStyle>()!;
  late final colorScheme = context.themeData.extension<AppColorScheme>()!;
  late final locationCubit = context.read<LocationCubit>();
  late double? latitude;
  late double? longitude;
  late final double minHeight = 120;
  late final double maxHeight = MediaQuery.of(context).size.height * .5;
  late final cornerRadius = MediaQuery.viewPaddingOf(context).top == 0 ? 42.0 : MediaQuery.viewPaddingOf(context).top;
  String cityName = '';

  @override
  void initState() {
    latitude = widget.city?.latitude ?? locationCubit.state.latitude;
    longitude = widget.city?.latitude ?? locationCubit.state.longitude;

    WidgetsBinding.instance.addPostFrameCallback(
      (_) {
        locationCubit.state.locality.then((place) {
          setState(() {
            cityName = widget.city?.name ?? place?.locality ?? '';
          });
        });
      },
    );

    super.initState();
  }

  Widget _buildDateText(double offset) {
    return Opacity(
      opacity: pow(offset, 10) as double,
      child: Align(
        alignment: Alignment.centerLeft,
        child: RichText(
          textScaler: TextScaler.linear(pow(offset, 2) as double),
          text: TextSpan(
            children: [
              TextSpan(
                text: DateFormat('DD MMM,').format(DateTime.now()),
                style: textStyle.labelLarge,
              ),
              TextSpan(
                text: DateFormat(' EEEE').format(DateTime.now()),
                style: textStyle.bodyLarge,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildFeelsLike(double offset) {
    return Opacity(
      opacity: pow(offset, 10) as double,
      child: Align(
        alignment: Alignment.centerLeft,
        child: Text(
          'Feels like ${(widget.weatherResponse.main?.feelsLike)?.round() ?? '--'}°C',
          style: textStyle.bodyMedium,
          textScaler: TextScaler.linear(pow(offset, 2) as double),
        ),
      ),
    );
  }

  Widget _buildFavoriteButton(double offset) {
    return BlocBuilder<FavouritesCubit, FavouritesState>(
      builder: (context, state) {
        final isFavourite = context.read<FavouritesCubit>().isFavourite(
              widget.city!,
              widget.weatherResponse,
            );

        return SizedBox(
          height: 26 * pow(offset, 4) as double,
          child: IconButton(
            iconSize: 26 * pow(offset, 4) as double,
            icon: Icon(
              isFavourite ? CupertinoIcons.heart_fill : CupertinoIcons.heart,
              color: colorScheme.text.withValues(alpha: pow(offset, 10) as double),
            ),
            visualDensity: VisualDensity(vertical: -4),
            onPressed: () {
              if (isFavourite) {
                context.read<FavouritesCubit>().removeFromFavourites(widget.city!);
              } else {
                context.read<FavouritesCubit>().addToFavourites(widget.city!, widget.weatherResponse);
              }
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(
                    isFavourite
                        ? "${widget.city!.name} removed from favourites"
                        : "${widget.city!.name} added to favourites",
                  ),
                  duration: Duration(seconds: 2),
                  behavior: SnackBarBehavior.floating,
                ),
              );
            },
          ),
        );
      },
    );
  }

  Widget _buildTemperature(double offset) {
    return Row(
      spacing: 5,
      mainAxisAlignment: MainAxisAlignment.end,
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        CachedNetworkImage(
          imageUrl: "${Constants.iconBaseUrl}/${widget.weatherResponse.weather?.firstOrNull?.icon}@2x.png",
          height: (52 * offset).clamp(28, 52),
        ),
        FittedBox(
          child: Text(
            '${(widget.weatherResponse.main?.temp)?.round() ?? '--'}°C',
            style: textStyle.headlineLarge.copyWith(
              fontSize: (60 * offset).clamp(24, 60),
              fontWeight: FontWeight.w900,
              height: 1.2,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildHighLow(double offset) {
    return Opacity(
      opacity: pow(offset, 10) as double,
      child: Text(
        "H:${((widget.weatherResponse.main?.tempMax)?.toStringAsFixed(0) ?? '--')}°  L:${((widget.weatherResponse.main?.tempMin)?.toStringAsFixed(0) ?? '--')}°",
        style: textStyle.labelLarge.copyWith(
          height: 1.5,
          fontWeight: FontWeight.w800,
          letterSpacing: 1.2,
        ),
        textScaler: TextScaler.linear(pow(offset, 2) as double),
      ),
    );
  }

  Widget _buildContent(double offset, bool isLandscape) {
    return AnimatedSwitcher(
      duration: Duration(milliseconds: 800),
      switchInCurve: Curves.fastOutSlowIn,
      switchOutCurve: Curves.fastEaseInToSlowEaseOut,
      child: isLandscape
          ? Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      _buildDateText(offset),
                      Text(cityName.toUpperCase(), style: textStyle.titleMedium),
                      _buildFeelsLike(offset),
                      SizedBox(height: 36 * pow(offset, 4) as double),
                      if (widget.city != null) _buildFavoriteButton(offset),
                    ],
                  ),
                ),
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      _buildTemperature(offset),
                      Text(
                        (widget.weatherResponse.weather?.firstOrNull?.description ?? '--').titleCase,
                        style: textStyle.bodyMedium,
                      ),
                      _buildHighLow(offset),
                    ],
                  ),
                ),
              ],
            )
          : Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _buildDateText(offset),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(cityName.toUpperCase(), style: textStyle.titleMedium),
                    if (widget.city != null) _buildFavoriteButton(offset),
                  ],
                ),
                _buildFeelsLike(offset),
                Spacer(),
                _buildTemperature(offset),
                Align(
                  alignment: Alignment.centerRight,
                  child: Text(
                    (widget.weatherResponse.weather?.firstOrNull?.description ?? '--').titleCase,
                    style: textStyle.bodyMedium,
                  ),
                ),
                Align(
                  alignment: Alignment.centerRight,
                  child: _buildHighLow(offset),
                ),
              ],
            ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      automaticallyImplyLeading: false,
      backgroundColor: colorScheme.background,
      stretch: true,
      pinned: true,
      expandedHeight: maxHeight,
      collapsedHeight: minHeight,
      flexibleSpace: FlexibleSpaceBar(
        titlePadding: EdgeInsets.zero,
        expandedTitleScale: 1,
        title: LayoutBuilder(
          builder: (context, constraints) {
            final double height = constraints.biggest.height;
            final double offset =
                maxHeight - minHeight == 0 ? 0 : ((height - minHeight) / (maxHeight - minHeight)).clamp(0, 1);

            return OrientationBuilder(
              builder: (context, orientation) {
                final isLandscape = orientation == Orientation.landscape;

                return Stack(
                  fit: StackFit.expand,
                  children: [
                    Container(
                      margin: EdgeInsets.all(10),
                      foregroundDecoration: BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment(0.0, 0.6),
                          end: Alignment.center,
                          colors: <Color>[
                            Color(0x60000000),
                            Color(0x00000000),
                          ],
                        ),
                        borderRadius: BorderRadius.circular(cornerRadius),
                      ),
                      decoration: BoxDecoration(
                        color: colorScheme.background,
                        borderRadius: BorderRadius.circular(cornerRadius),
                      ),
                      clipBehavior: Clip.antiAlias,
                      child: Image.asset(
                        widget.weatherResponse.backgroundImage,
                        fit: BoxFit.cover,
                      ),
                    ),
                    SafeArea(
                      left: false,
                      // right: false,
                      child: Padding(
                        padding: EdgeInsets.fromLTRB(
                          30,
                          (30 * offset).clamp(MediaQuery.viewPaddingOf(context).top == 0 ? 20 : 0, 30),
                          30,
                          ((isLandscape ? 20 : 40) * offset).clamp(isLandscape ? 20 : 26, isLandscape ? 20 : 40),
                        ),
                        child: _buildContent(offset, isLandscape),
                      ),
                    ),
                  ],
                );
              },
            );
          },
        ),
      ),
      onStretchTrigger: () async {
        context.read<WeatherCubit>().fetchWeather(
              latitude: latitude,
              longitude: longitude,
            );
      },
    );
  }
}
