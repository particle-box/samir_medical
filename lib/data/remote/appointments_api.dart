import 'package:dio/dio.dart';
import 'dio_client.dart';

class AppointmentsApi {
  final Dio _dio = DioClient.instance.dio;

  // Future<Response> bookAppointment(Map<String, dynamic> body) => _dio.post('/appointments/book', data: body);
  // Future<Response> myAppointments(String userId) => _dio.get('/appointments/my/$userId');
}
