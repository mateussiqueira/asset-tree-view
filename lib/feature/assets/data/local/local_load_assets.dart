import '../../../../core/cache/cache.dart';
import '../../domain/entities/asset_entity.dart';
import '../../domain/interfaces/load_assets.dart';
import '../models/remote_assets_model.dart';
import 'dart:convert';

class LocalLoadAssets implements LoadAssets {
  final CacheAdapter cacheAdapter;
  final String cacheKey;

  LocalLoadAssets({
    required this.cacheAdapter,
    this.cacheKey = 'cached_assets',
  });

  @override
  Future<List<AssetEntity>> load() async {
    try {
      final cachedData = await cacheAdapter.load(cacheKey);

      if (cachedData == null || cachedData.isEmpty) {
        return [];
      }

      final List<Map<String, dynamic>> jsonList =
          (json.decode(cachedData) as List<dynamic>)
              .cast<Map<String, dynamic>>();

      return RemoteAssetsModel.toListEntity(jsonList);
    } catch (e) {
      throw Exception('Failed to load assets from cache: $e');
    }
  }

  Future<void> save(List<AssetEntity> assets) async {
    try {
      final jsonList = assets
          .map((asset) => RemoteAssetsModel.fromJson({
                'id': asset.id,
                'name': asset.name,
                'parentId': asset.parentId,
                'locationId': asset.locationId,
              }).json)
          .toList();

      await cacheAdapter.save(cacheKey, json.encode(jsonList));
    } catch (e) {
      throw Exception('Failed to save assets to cache: $e');
    }
  }

  Future<void> clearCache() async {
    try {
      await cacheAdapter.remove(cacheKey);
    } catch (e) {
      throw Exception('Failed to clear cache: $e');
    }
  }
}