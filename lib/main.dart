import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:skyris/config/injection/injection.dart';
import 'package:skyris/config/themes/app_theme.dart';
import 'package:skyris/presentation/cubit/location_cubit.dart';
import 'package:skyris/utils/constants/constants.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  configureDependencies();
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    // Make Status Bar transparent
    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
      ),
    );

    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: BlocProvider(
        create: (context) => locator<LocationCubit>(),
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          title: Constants.appTitle,
          theme: AppTheme.light,
          darkTheme: AppTheme.dark,
          themeMode: ThemeMode.dark,
          // home: const SplashScreen(),
          home: const Placeholder(),
        ),
      ),
    );
  }
}
