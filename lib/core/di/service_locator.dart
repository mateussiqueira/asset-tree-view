import '../../feature/assets/assests.dart';
import '../../feature/assets/data/repository/asset_repository.dart';
import '../core.dart';
import 'package:asset_tree_app/feature/assets/data/services/assets_service.dart';
import 'package:asset_tree_app/feature/assets/data/services/company_service.dart';
import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';

final GetIt locator = GetIt.instance;
const String baseUrl = 'https://fake-api.tractian.com';
const String assetsUrl = '$baseUrl/assets';
Future<void> setupLocator() async {
  final dio = Dio(BaseOptions(baseUrl: baseUrl));
  locator.registerLazySingleton<HttpAdapter>(() => DioAdapter(dio));

  final sharedPreferences = await SharedPreferences.getInstance();
  locator.registerLazySingleton<CacheAdapter>(
      () => SharedPreferencesAdapter(sharedPreferences));

  locator.registerLazySingleton(
      () => CompanyService(httpAdapter: locator.get(), url: baseUrl));
  locator.registerLazySingleton(
      () => AssetService(httpAdapter: locator.get(), url: baseUrl));

  locator.registerFactory(() => RemoteLoadAssets(
        httpAdapter: locator<HttpAdapter>(),
        url: 'https://fake-api.tractian.com/assets',
      ));

  locator.registerFactory(() => LocalLoadAssets(
        cacheAdapter: locator<CacheAdapter>(),
      ));

  locator.registerFactory(() => AssetRepository(
        remoteLoadAssets: locator<RemoteLoadAssets>(),
        localLoadAssets: locator<LocalLoadAssets>(),
      ));
}
