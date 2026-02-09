import 'package:dio/dio.dart';

class DioClient {
  static Dio create({
    required String baseUrl,
    Map<String, String>? headers,
  }) =>
      Dio(
        BaseOptions(
          baseUrl: baseUrl,
          connectTimeout: const Duration(hours: 10),
          receiveTimeout: const Duration(hours: 15),
          headers: headers,
        ),
      );
}
