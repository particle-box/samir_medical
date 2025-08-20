import 'package:dio/dio.dart';
import 'dio_client.dart';

class CartApi {
  final Dio _dio = DioClient.instance.dio;

  // Future<Response> addMedicine(Map<String, dynamic> body) => _dio.post('/cart/add-medicine', data: body);
  // Future<Response> addAppointment(Map<String, dynamic> body) => _dio.post('/cart/add-appointment', data: body);
  // Future<Response> myCart(String userId) => _dio.get('/cart/my/$userId');
  // Future<Response> removeItem(String id) => _dio.delete('/cart/remove/$id');
}
