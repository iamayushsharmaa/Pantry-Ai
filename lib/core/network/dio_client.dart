import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class DioClient {
  static Dio create(FlutterSecureStorage storage) {
    final options = BaseOptions(
      baseUrl: 'https://invoicely-367c.onrender.com',
      connectTimeout: const Duration(seconds: 10),
      receiveTimeout: const Duration(seconds: 10),
      responseType: ResponseType.json,
    );

    final dio = Dio(options);

    dio.interceptors.add(LogInterceptor(
      requestBody: true,
      responseBody: true,
    ));

    dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (options, handler) async {
          final token = await storage.read(key: 'token');
          if (token != null) {
            options.headers['Authorization'] = 'Bearer $token';
          }
          return handler.next(options);
        },
      ),
    );

    return dio;
  }
}