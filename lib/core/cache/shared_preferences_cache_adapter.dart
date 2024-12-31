import 'cache_adapter.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferencesAdapter implements CacheAdapter {
  final SharedPreferences sharedPreferences;
  SharedPreferencesAdapter(this.sharedPreferences);

  @override
  Future<void> save(String key, String value) async {
    await sharedPreferences.setString(key, value);
  }

  @override
  Future<String?> load(String key) async {
    return sharedPreferences.getString(key);
  }

  @override
  Future<void> remove(String key) async {
    await sharedPreferences.remove(key);
  }
}