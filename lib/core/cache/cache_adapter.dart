




abstract class CacheAdapter {
  Future<void> save(String key, String value);
  Future<String?> load(String key);
  Future<void> remove(String key);
}