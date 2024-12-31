import '../entities/asset_entity.dart';
import '../interfaces/load_assets.dart';

class FetchAssetsUseCase {
  final LoadAssets loadAssets;
  FetchAssetsUseCase(this.loadAssets);

  Future<List<AssetEntity>> execute() async {
    return await loadAssets.load();
  }
}