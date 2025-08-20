import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:samir_medical/core/config/app_config.dart';

class DioClient {
  DioClient._();
  static final DioClient instance = DioClient._();

  final Dio dio = Dio(BaseOptions(
    baseUrl: AppConfig.apiBaseUrl,
    connectTimeout: const Duration(seconds: 20),
    receiveTimeout: const Duration(seconds: 20),
    contentType: 'application/json',
    responseType: ResponseType.json,
  ));

  final _secure = const FlutterSecureStorage();

  void init() {
    dio.interceptors.clear();
    dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (options, handler) async {
          // Attach Bearer token if available
          final token = await _secure.read(key: 'jwt');
          if (token != null && token.isNotEmpty) {
            options.headers['Authorization'] = 'Bearer $token';
          }
          handler.next(options);
        },
        onError: (err, handler) {
          // Map errors; allow caller to handle
          handler.next(err);
        },
      ),
    );
  }
}
