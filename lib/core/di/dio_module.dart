import '../core.dart';
import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';

void setupDioModule(GetIt locator) {
  final dio = Dio();
  locator.registerLazySingleton<HttpAdapter>(() => DioAdapter(dio));
}