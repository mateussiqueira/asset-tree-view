import 'http_methods.dart';

abstract class HttpAdapter {
  Future<dynamic> request({
    required String url,
    required HttpMethod method,
    Map<String, dynamic>? body,
    Map<String, String>? headers,
  });
}