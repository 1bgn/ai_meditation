import 'package:dio/dio.dart';

class DioClient {
  static Dio create({
    required String baseUrl,
    Map<String, String>? headers,
  }) =>
      Dio(
        BaseOptions(
          baseUrl: baseUrl,
          connectTimeout: const Duration(seconds: 10),
          receiveTimeout: const Duration(seconds: 15),
          headers: headers,
        ),
      );
}
