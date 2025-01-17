import 'dart:io' show HttpStatus;
import 'package:retrofit/dio.dart';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:skyris/utils/resources/data_state.dart';

abstract class BaseApiRepository {
  @protected
  Future<DataState<T?>> getStateOf<T>({
    required Future<HttpResponse<T>> Function() request,
  }) async {
    try {
      final httpResponse = await request();
      if (httpResponse.response.statusCode == HttpStatus.created ||
          httpResponse.response.statusCode == HttpStatus.ok) {
        return DataSuccess(httpResponse.data);
      } else if (httpResponse.response.statusCode == HttpStatus.unauthorized) {
        throw DataFailed(DioException(
          response: httpResponse.response,
          requestOptions: httpResponse.response.requestOptions,
        ));
      } else {
        throw DioException(
          response: httpResponse.response,
          requestOptions: httpResponse.response.requestOptions,
        );
      }
    } on DioException catch (error) {
      return DataFailed(error);
    }
  }
}
