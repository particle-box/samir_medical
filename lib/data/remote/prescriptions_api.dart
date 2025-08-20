import 'package:dio/dio.dart';
import 'dio_client.dart';

class PrescriptionsApi {
  final Dio _dio = DioClient.instance.dio;

  // Multipart upload example will be added later:
  // Future<Response> uploadPrescription(FormData formData) =>
  //     _dio.post('/prescriptions/upload', data: formData);
  // Admin-only report endpoint exists but will not be called from user app.
}
