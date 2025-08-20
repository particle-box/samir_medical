import 'package:dio/dio.dart';
import 'dio_client.dart';

class DoctorsApi {
  final Dio _dio = DioClient.instance.dio;

  // We will add real methods later, e.g.:
  // Future<Response> getDoctors() => _dio.get('/doctors');
  // Future<Response> getDoctor(String id) => _dio.get('/doctors/$id');
}
