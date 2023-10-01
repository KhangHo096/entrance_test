import 'dart:developer';

import 'package:awesome_dio_interceptor/awesome_dio_interceptor.dart';
import 'package:dio/dio.dart';
import 'package:entrance_test/app/data/rest_api/dio/auth_interceptor.dart';
import 'package:flutter/foundation.dart';

const Duration _kTimeout = Duration(seconds: 60);

class DioFactory {
  late Dio dio;
  String baseUrl = 'http://streaming.nexlesoft.com:3001';

  DioFactory() {
    dio = Dio(
      BaseOptions(
        receiveDataWhenStatusError: true,
        connectTimeout: _kTimeout,
        receiveTimeout: _kTimeout,
        sendTimeout: _kTimeout,
        baseUrl: baseUrl,
      ),
    );
    if (kDebugMode) {
      dio.interceptors.add(
        AwesomeDioInterceptor(
          logRequestTimeout: false,
          logRequestHeaders: false,
          logResponseHeaders: false,
          logger: (value) {
            log(value, name: 'Ohrey');
          },
        ),
      );
      dio.interceptors.add(AuthInterceptor());
    }
  }
}
