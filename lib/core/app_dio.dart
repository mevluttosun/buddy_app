import 'package:buddy/core/constants/constants.dart';
import 'package:dio/dio.dart';
import 'package:dio/io.dart';

class AppDio with DioMixin implements Dio {
  AppDio([BaseOptions? options]) {
    options = BaseOptions(
      baseUrl: baseUrl,
      contentType: 'application/json',
      connectTimeout: const Duration(seconds: 10),
      sendTimeout: const Duration(seconds: 10),
      receiveTimeout: const Duration(seconds: 10),
    );
    this.options = options;
    httpClientAdapter = IOHttpClientAdapter();
  }
}
