import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:skyris/config/injection/injection.dart';
import 'package:skyris/config/themes/extensions/app_color_scheme.dart';
import 'package:skyris/config/themes/extensions/app_text_style.dart';
import 'package:skyris/presentation/cubit/city_search_cubit.dart';
import 'package:skyris/presentation/cubit/weather_cubit.dart';
import 'package:skyris/presentation/screens/favourites_screen.dart';
import 'package:skyris/presentation/screens/home_screen.dart';
import 'package:skyris/utils/extensions/app_theme_extension.dart';

class BaseScreen extends StatefulWidget {
  const BaseScreen({super.key});

  @override
  State<BaseScreen> createState() => _BaseScreenState();
}

class _BaseScreenState extends State<BaseScreen> {
  late final textStyle = context.themeData.extension<AppTextStyle>()!;
  late final colorScheme = context.themeData.extension<AppColorScheme>()!;
  int _selectedIndex = 0;

  static final List<Widget> _tabOptions = <Widget>[
    MultiBlocProvider(
      providers: [
        BlocProvider<WeatherCubit>(
          create: (context) => locator<WeatherCubit>(),
        ),
      ],
      child: const HomeScreen(),
    ),
    MultiBlocProvider(
      providers: [
        BlocProvider<CitySearchCubit>(
          create: (context) => locator<CitySearchCubit>(),
        ),
      ],
      child: const FavouritesScreen(),
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return OrientationBuilder(
      builder: (context, orientation) {
        final isLandscape = orientation == Orientation.landscape;

        return Scaffold(
          extendBody: true,
          backgroundColor: colorScheme.background,
          body: isLandscape
              ? Row(
                  children: [
                    NavigationRail(
                      backgroundColor: colorScheme.surface,
                      selectedIndex: _selectedIndex,
                      onDestinationSelected: _onNavItemTap,
                      labelType: NavigationRailLabelType.none,
                      destinations: const [
                        NavigationRailDestination(
                          icon: Icon(CupertinoIcons.compass),
                          selectedIcon: Icon(CupertinoIcons.compass_fill),
                          label: Text(''),
                        ),
                        NavigationRailDestination(
                          icon: Icon(CupertinoIcons.square_favorites),
                          selectedIcon: Icon(CupertinoIcons.square_favorites_fill),
                          label: Text(''),
                        ),
                      ],
                    ),
                    Expanded(child: _tabOptions[_selectedIndex]),
                  ],
                )
              : _tabOptions[_selectedIndex],

          // Bottom Navbar - Only show in portrait mode
          bottomNavigationBar: !isLandscape
              ? ClipRRect(
                  borderRadius: BorderRadius.vertical(top: Radius.circular(36)),
                  child: BottomNavigationBar(
                    backgroundColor: colorScheme.surface,
                    elevation: 0,
                    iconSize: 26,
                    selectedLabelStyle: textStyle.bodySmall,
                    unselectedLabelStyle: textStyle.bodySmall,
                    showSelectedLabels: false,
                    showUnselectedLabels: false,
                    enableFeedback: true,
                    items: const <BottomNavigationBarItem>[
                      // Home Tab
                      BottomNavigationBarItem(
                        icon: Icon(CupertinoIcons.compass),
                        activeIcon: Icon(CupertinoIcons.compass_fill),
                        label: '',
                      ),

                      // Favourites Tab
                      BottomNavigationBarItem(
                        icon: Icon(CupertinoIcons.square_favorites),
                        activeIcon: Icon(CupertinoIcons.square_favorites_fill),
                        label: '',
                      ),
                    ],
                    currentIndex: _selectedIndex,
                    selectedItemColor: colorScheme.text,
                    unselectedItemColor: Colors.grey,
                    onTap: _onNavItemTap,
                  ),
                )
              : null,
        );
      },
    );
  }

  /// Callback function that handles tapping on bottom navigation bar items
  ///
  /// Updates the [_selectedIndex] state variable to the tapped [index],
  /// which triggers a rebuild of the UI to show the selected tab's content
  void _onNavItemTap(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }
}
