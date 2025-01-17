import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';
import 'package:skyris/utils/constants/constants.dart';

/// Will be used for injecting third party packages
@module
abstract class RegisterModule {
  // Inject Dio
  @lazySingleton
  Dio dio() {
    return Dio(
      BaseOptions(baseUrl: Constants.baseUrl),
    )..interceptors.add(
        PrettyDioLogger(
          requestHeader: true,
          requestBody: true,
          responseHeader: true,
          maxWidth: 120,
        ),
      );
  }
}
