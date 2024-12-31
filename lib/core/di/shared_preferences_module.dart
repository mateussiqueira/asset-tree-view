import '../cache/cache.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future<void> setupSharedPreferencesModule(GetIt locator) async {
  final sharedPreferences = await SharedPreferences.getInstance();
  locator.registerLazySingleton<CacheAdapter>(
      () => SharedPreferencesAdapter(sharedPreferences));
}