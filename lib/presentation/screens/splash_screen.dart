import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geolocator/geolocator.dart';
import 'package:skyris/config/injection/injection.dart';
import 'package:skyris/config/themes/extensions/app_color_scheme.dart';
import 'package:skyris/presentation/cubit/location_cubit.dart';
import 'package:skyris/presentation/screens/base_screen.dart';
import 'package:skyris/utils/constants/enums.dart';
import 'package:skyris/utils/extensions/app_theme_extension.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback(
      (_) async {
        await _handleLocationPermission();
        locator<LocationCubit>().fetchLocation();
      },
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = context.themeData.extension<AppColorScheme>()!;

    return Scaffold(
      backgroundColor: colorScheme.primary,
      body: BlocListener<LocationCubit, LocationState>(
        listener: (context, state) {
          if (state.status.isSuccess) {
            Navigator.of(context).pushReplacement(
              MaterialPageRoute(
                builder: (context) => const BaseScreen(),
              ),
            );
          }
        },
        child: Stack(
          children: [
            Center(
              child: Image.asset(
                'assets/images/skyris-logo.png',
                height: 300,
                width: 300,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<bool> _handleLocationPermission() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled && mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(
            'Location services are disabled. Please enable the services',
          ),
        ),
      );
      return false;
    }
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied && mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Location permissions are denied')));
        return false;
      }
    }
    if (permission == LocationPermission.deniedForever && mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(
            'Location permissions are permanently denied, we cannot request permissions.',
          ),
        ),
      );
      return false;
    }
    return true;
  }
}
