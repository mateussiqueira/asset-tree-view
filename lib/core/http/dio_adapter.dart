import '../core.dart';
import 'package:dio/dio.dart';

class DioAdapter implements HttpAdapter {
  final Dio dio;
  DioAdapter(this.dio);

  @override
  Future<dynamic> request({
    required String url,
    required HttpMethod method,
    Map<String, dynamic>? body,
    Map<String, String>? headers,
  }) async {
    try {
      final options = Options(method: method.name, headers: headers);
      final response = await dio.request(url, data: body, options: options);
      return response.data;
    } on DioException catch (error) {
      throw error.response?.data ?? 'Unknown error';
    }
  }
}