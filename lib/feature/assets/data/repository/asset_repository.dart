import '../../domain/entities/asset_entity.dart';
import '../../domain/interfaces/load_assets.dart';
import '../local/local_load_assets.dart';
import '../remote/remote_load_assets.dart';

class AssetRepository implements LoadAssets {
  final RemoteLoadAssets remoteLoadAssets;
  final LocalLoadAssets localLoadAssets;
  AssetRepository({
    required this.remoteLoadAssets,
    required this.localLoadAssets,
  });

  @override
  Future<List<AssetEntity>> load() async {
    try {
      final remoteAssets = await remoteLoadAssets.load();

      if (remoteAssets.isNotEmpty) {
        await localLoadAssets.save(remoteAssets);
      }

      return remoteAssets;
    } catch (e) {
      return await localLoadAssets.load();
    }
  }
}