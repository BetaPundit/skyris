import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:skyris/config/injection/injection.dart';
import 'package:skyris/config/themes/extensions/app_color_scheme.dart';
import 'package:skyris/config/themes/extensions/app_text_style.dart';
import 'package:skyris/presentation/cubit/city_search_cubit.dart';
import 'package:skyris/presentation/cubit/favourites_cubit.dart';
import 'package:skyris/presentation/cubit/weather_cubit.dart';
import 'package:skyris/presentation/screens/home_screen.dart';
import 'package:skyris/presentation/widgets/favourite_card.dart';
import 'package:skyris/utils/constants/enums.dart';
import 'package:skyris/utils/extensions/app_theme_extension.dart';

class FavouritesScreen extends StatefulWidget {
  const FavouritesScreen({super.key});

  @override
  State<FavouritesScreen> createState() => _FavouritesScreenState();
}

class _FavouritesScreenState extends State<FavouritesScreen> {
  late final textStyle = context.themeData.extension<AppTextStyle>()!;
  late final colorScheme = context.themeData.extension<AppColorScheme>()!;
  final _searchController = SearchController();

  @override
  void dispose() {
    _searchController.dispose();
    locator.resetLazySingleton<CitySearchCubit>();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // App Bar
      appBar: AppBar(
        title: Text(
          'Skiris - Weather',
          style: textStyle.headlineLarge,
        ),
        automaticallyImplyLeading: false,
        backgroundColor: Colors.transparent,
      ),

      body: Column(
        children: [
          // Search Bar
          BlocListener<CitySearchCubit, CitySearchState>(
            listener: (context, state) {
              if (state.status.isSuccess && state.cities.isNotEmpty) {
                if (_searchController.isOpen) _searchController.closeView(null);
                _searchController.openView();
              }
            },
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Theme(
                data: ThemeData.dark(),
                child: SearchAnchor(
                  isFullScreen: false,
                  searchController: _searchController,
                  builder: (context, controller) {
                    return SearchBar(
                      controller: controller,
                      hintText: 'Search for a city...',
                      onChanged: (value) {
                        context.read<CitySearchCubit>().searchCity(value);
                      },
                    );
                  },
                  suggestionsBuilder: (BuildContext _, SearchController controller) {
                    final cities = locator<CitySearchCubit>().state.cities;

                    return List<ListTile>.generate(
                      cities.length,
                      (int index) {
                        final city = cities[index];
                        return ListTile(
                          title: Text(city.name, style: textStyle.bodyMedium),
                          onTap: () {
                            setState(() {
                              controller.closeView(city.name);
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
                                      child: HomeScreen(city: city),
                                    ),
                                  );
                                },
                              );
                            });
                          },
                        );
                      },
                    );
                  },
                ),
              ),
            ),
          ),

          // List of Favourites
          Expanded(
            child: BlocBuilder<FavouritesCubit, FavouritesState>(
              builder: (context, state) {
                if (state.favourites.isEmpty) {
                  return Center(
                    child: Text(
                      'No favourites added yet',
                      style: textStyle.bodyMedium,
                    ),
                  );
                }

                return ListView.builder(
                  padding: EdgeInsets.symmetric(horizontal: 20),
                  itemCount: state.favourites.length,
                  itemBuilder: (context, index) {
                    final location = state.favourites[index];
                    return FavouriteCard(location: location);
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
