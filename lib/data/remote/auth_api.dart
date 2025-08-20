import 'package:dio/dio.dart';
import 'dio_client.dart';

class AuthApi {
  final _dio = DioClient.instance.dio;

  Future<Response> register(Map<String, dynamic> body) =>
      _dio.post('/auth/register', data: body);

  Future<Response> login(Map<String, dynamic> body) =>
      _dio.post('/auth/login', data: body);
}
